extends Node3D

#@export var delay: float = 0.0;
@onready var anim_player = get_node("platform_path/AnimationPlayer");
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(randf_range(0, 6.0)).timeout
	travel();

func travel() -> void:
		anim_player.play("travel");
	#while (true):
		#await anim_player.animation_finished;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
