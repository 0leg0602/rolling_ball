extends Node3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

@export var delay: float = 1.5

var time_elaples: float = 0.0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(delay).timeout
	lunge();

func lunge() -> void:
	while (true):
		anim_player.play("lunge_spikes");
		await anim_player.animation_finished;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
