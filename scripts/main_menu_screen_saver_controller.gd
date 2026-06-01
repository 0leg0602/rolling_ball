extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	if ($ball_rigid_body.position.y < -10):
		$ball_rigid_body.freeze = true
		$ball_rigid_body.position = Vector3(-4.2, 9, 0)
		$ball_rigid_body.rotation = Vector3(0, 0, 0)
		$ball_rigid_body.linear_velocity = Vector3(0, 0, 0)
		$ball_rigid_body.angular_velocity = Vector3(0, 0, 0)
		$ball_rigid_body.freeze = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
