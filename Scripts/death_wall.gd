extends Node2D

var speed := 10.0

func _ready() -> void:
	SignalBus.position_camera.connect(move)

func _process(delta: float) -> void:
	global_position.x += delta * speed


func move(train_pos : Vector2):
	global_position.x = max(train_pos.x - 320, global_position.x)
