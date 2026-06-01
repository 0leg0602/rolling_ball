extends Control

@onready var menu = get_node("ColorRect/menu");
@onready var level_select = get_node("ColorRect/level_select");

@onready var complete_level_theme = load("res://themes/level_button_complete.tres");
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var container = get_node("ColorRect/level_select/container");
	var assets = load("res://scenes/objects/assets.tscn").instantiate();
	for i in range(1, 10):
		var level_button: Button = assets.get_node("level_button").duplicate();
		level_button.text = str(i);
		level_button.pressed.connect(_on_level_button_pressed.bind(str(i)));
		if (Global.levels.get(i).is_completed):
			level_button.theme = complete_level_theme;
			var coin_holder = level_button.get_node("coin_holder")
			for c in range(1, 4):
				if (Global.levels.get(i).coins_collected < c):
					break;
				var coin = coin_holder.get_node("coin" + str(c));
				coin.material = null;
		container.add_child(level_button);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_level_button_pressed(level: String) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#get_tree().change_scene_to_file("res://scenes/level%s.tscn" % [level]);
	get_tree().change_scene_to_file("res://scenes/level1.tscn");
	Global.current_level = int(level);

func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_start_button_pressed() -> void:
	menu.visible = false;
	level_select.visible = true;


func _on_back_button_pressed() -> void:
	menu.visible = true;
	level_select.visible = false;
