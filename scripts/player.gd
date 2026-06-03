extends Node3D

var mouse_sensitivity: float = 0.003
var force_strength: float = 15.0
var jumps = 0
var jump_delay = 0

var cheats = false;

@onready var coin_counter_label: Label = get_node("UI/HBoxContainer/Label");
@onready var big: Area3D = get_node("pivot_h/big");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$pivot_h/bottom_shape_cast.add_exception($player_rigid_body)
	#big.add_exception($player_rigid_body)
	Global.coin_collect.connect(_on_coin_collect);

func _on_coin_collect() -> void:
	coin_counter_label.text = str(Global.coin_count);

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$pivot_h.rotate_y((event.relative.x * -1) * mouse_sensitivity)
		$pivot_h/pivot_v.rotate_x((event.relative.y * -1) * mouse_sensitivity)
		$pivot_h/pivot_v.rotation.x = clamp($pivot_h/pivot_v.rotation.x, deg_to_rad(-89), deg_to_rad(1))
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_WHEEL_DOWN):
			$pivot_h/pivot_v/camera_collision_ray.spring_length += 1
		elif (event.button_index == MOUSE_BUTTON_WHEEL_UP):
			$pivot_h/pivot_v/camera_collision_ray.spring_length -= 1
	if event is InputEventKey:
		if event.is_action_pressed("cheats"):
			toggle_cheats();

func toggle_cheats() -> void:
	if (cheats):
		$player_rigid_body.constant_force.y = -9.8;
	else:
		$player_rigid_body.constant_force.y = 0;
	cheats = !cheats;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	print(jump_delay);
	if (jump_delay > 0):
		jump_delay -= delta;
	elif (jump_delay < 0):
		jump_delay = 0;
	
	if(jump_delay <= 0 && $pivot_h/bottom_area.get_overlapping_bodies().size() > 1):
		jumps = 1;
		
	#if(big.get_overlapping_bodies().size() > 1):
		#for i in big.get_overlapping_bodies():
			#if (i.is_in_group("wall_jump")):
					#jumps = 1
					
	
	$pivot_h.position = $player_rigid_body.position
	
	var axis_y: float = Input.get_axis("forward","back")
	var axis_x: float = Input.get_axis("right","left")
	
	var rot_y: float = $pivot_h.rotation.y
	
	var force_x = axis_x * cos(rot_y) -  axis_y * sin(rot_y)
	var force_y = axis_y * cos(rot_y) + axis_x * sin(rot_y)
	
	#print("axis_y: ", axis_y, " axis_x:", axis_x, " | ", "force_y: ", force_y, " force_x:", force_x)
	
	#$PlayerRigidBody.apply_torque(Vector3(force_y * torque_strength, 0, force_x * torque_strength))
	$player_rigid_body.apply_force(Vector3(-force_x * force_strength, 0, force_y * force_strength))
	
	if (jumps > 0 || cheats):
			if (Input.is_action_pressed("jump") || Input.is_action_just_pressed("jump") && cheats):
				$player_rigid_body.apply_force(Vector3(0, 500, 0))
				jumps = 0;
				jump_delay = 0.3
	
#	Shadow logic
	
	var collision_count: int = $pivot_h/bottom_shape_cast.get_collision_count()
	var highest_collision_pos = -1e10
	for i in range(collision_count):
		#print($pivot_h/bottom_shape_cast.get_collider(i))
		var current_pos = $pivot_h/bottom_shape_cast.get_collision_point(i).y;
		
		if (current_pos > highest_collision_pos):
			highest_collision_pos = current_pos
	
	#print($fake_shadow.global_position.y, " | ", highest_collision_pos)
	$fake_shadow.global_position = $player_rigid_body.global_position
	$fake_shadow.global_position.y = highest_collision_pos
	
func _process(delta: float) -> void:
	pass
