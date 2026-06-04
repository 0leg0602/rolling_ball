extends Control

var is_paused = false;
var is_game_over = false;
var is_level_failed = false;
@onready var continue_button: Button = get_node("ColorRect/pause/CenterContainer/VBoxContainer/continue_button");
@onready var time_taken_label: Label = get_node("ColorRect/end/CenterContainer/VBoxContainer/panel_time_taken/label");
@onready var best_time_label: Label = get_node("ColorRect/end/CenterContainer/VBoxContainer/panel_best_time/label");
@onready var end_ui: Control = get_node("ColorRect/end");
@onready var coin_holder: Control = get_node("ColorRect/end/CenterContainer/VBoxContainer/coins_holder/coins_bounds");
@onready var end_label: Label = get_node("ColorRect/end/CenterContainer/VBoxContainer/Label");
@onready var settings: Control = get_node("ColorRect/settings");

@onready var color1: ColorPickerButton = get_node("ColorRect/settings/CenterContainer/VBoxContainer/color_box1/color");
@onready var color2: ColorPickerButton = get_node("ColorRect/settings/CenterContainer/VBoxContainer/color_box2/color");
@onready var mouse: Range = get_node("ColorRect/settings/CenterContainer/VBoxContainer/mouse_box/mouse");


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color1.color = Global.color1;
	color2.color = Global.color2;
	mouse.value = Global.mouse_sence;
	Global.game_over.connect(_on_game_over);

func _on_game_over(is_failed: bool) -> void:
	is_level_failed = is_failed;
	print(is_failed);
	is_game_over = true;
	if is_failed:
		continue_button.disabled = true;
	else:
		if Global.current_level == 9:
			continue_button.disabled = true;
			continue_button.text = "good job";
		else:
			continue_button.text = "next";
		best_time_label.text = str(Global.levels.get(Global.current_level).best_time) + " s";
	
	end_ui.visible = true;
	time_taken_label.text = str(Global.time_elapsed) + " s";
	
	if is_failed:
		end_label.text = "game over\nyou lost"
	else:
		for i in range(1, 4):
			var coin = coin_holder.get_node("coin" + str(i));
			if (Global.coin_count >= i):
				coin.material = null;
		
	
	toggle_pause();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()

func  toggle_pause() -> void:
	if is_paused && !is_game_over:
		visible = false;
		get_tree().paused = false;
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		visible = true;
		get_tree().paused = true;
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	is_paused = !is_paused;


func _on_exit_button_pressed() -> void:
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn");


func _on_start_button_pressed() -> void:
	if (is_game_over && !is_level_failed):
		Global.current_level += 1;
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_tree().paused = false;
		get_tree().change_scene_to_file("res://scenes/level%s.tscn" % [Global.current_level]);
	else:
		toggle_pause();


func _on_restart_button_pressed() -> void:
	Global.restart();


func _on_setting_button_pressed() -> void:
	Global.update_player();
	settings.visible = !settings.visible;


func _on_color1_color_changed(color: Color) -> void:
	Global.color1 = color;
	Global.update_player();


func _on_color2_color_changed(color: Color) -> void:
	Global.color2 = color;
	Global.update_player();


func _on_mouse_value_changed(value: float) -> void:
	Global.mouse_sence = value;
	Global.update_player();
