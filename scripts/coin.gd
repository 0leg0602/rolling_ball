extends Node3D

@onready var coin_animation: AnimationPlayer = get_node("coin_animation");
@onready var coin_light: MeshInstance3D = get_node("coin_model/coin_light");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_coin_area_body_entered(body: Node3D) -> void:
	if (body.is_in_group("player")):
		coin_collect();
	
func coin_collect() -> void:
	Global.add_coin();
	
	coin_animation.pause();
	coin_light.material_override = coin_light.material_override.duplicate();
	coin_animation.play("coin_collect");
	


func _on_coin_animation_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "coin_collect"):
		queue_free();
