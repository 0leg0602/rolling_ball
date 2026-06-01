extends Control

var is_paused = false;
var is_game_over = false;

@onready var continue_button: Button = get_node("ColorRect/pause/CenterContainer/VBoxContainer/continue_button");
@onready var time_taken_label: Label = get_node("ColorRect/end/CenterContainer/VBoxContainer/panel_time_taken/label");
@onready var best_time_label: Label = get_node("ColorRect/end/CenterContainer/VBoxContainer/panel_best_time/label");
@onready var end_ui: Control = get_node("ColorRect/end");
@onready var coin_holder: Control = get_node("ColorRect/end/CenterContainer/VBoxContainer/coins_holder/coins_bounds");
@onready var end_label: Label = get_node("ColorRect/end/CenterContainer/VBoxContainer/Label");
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.game_over.connect(_on_game_over);

func _on_game_over(is_failed: bool) -> void:
	print(is_failed);
	is_game_over = true;
	if is_failed:
		continue_button.disabled = true;
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
	toggle_pause();


func _on_restart_button_pressed() -> void:
	Global.restart();
