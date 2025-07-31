extends Camera2D

func _ready() -> void:
	SignalBus.position_camera.connect(update_position)

func update_position(train_pos : Vector2):
	global_position.x = max(train_pos.x + 360, 640)
