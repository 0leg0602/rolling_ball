extends Node

var coin_count: int = 0;
var time_start = 0;
var time_elapsed = 0;

signal game_over;
signal coin_collect;

var levels: Array[Level] = [];
var current_level: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0, 10):
		levels.append(Level.new());


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_coin() -> void:
	coin_count += 1;
	coin_collect.emit();

func restart() -> void:
	reset();
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	get_tree().paused = false;
	var current_scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(current_scene_path);

func end_game(is_failed) -> void:
	time_elapsed = (Time.get_ticks_msec() - time_start) / 1000.0;
	if !is_failed:
		levels.get(current_level).is_completed = true;
		if (levels.get(current_level).coins_collected < coin_count):
			levels.get(current_level).coins_collected = coin_count;
		
		if (levels.get(current_level).best_time > time_elapsed || levels.get(current_level).best_time == 0.0):
			levels.get(current_level).best_time = time_elapsed;
	game_over.emit(is_failed);
	
func reset() -> void:
	time_start = Time.get_ticks_msec();
	time_elapsed = 0;
	coin_count = 0;
