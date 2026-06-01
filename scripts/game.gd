extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.reset();
	var assets = load("res://scenes/objects/assets.tscn").instantiate();
	
	var pause_menu = assets.get_node("pause_menu").duplicate();
	
	pause_menu.visible = false;
	pause_menu.get_node("ColorRect/end").visible = false;
	add_child(pause_menu);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
