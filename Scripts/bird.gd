class_name Bird
extends Obstacle

var speed := 100.0
var moving := false

@onready var init_pos_y := position.y

func _ready() -> void:
	SignalBus.position_camera.connect(pos_camera)
	$AnimatedSprite2D.play("default")

func pos_camera(train_pos : Vector2):
	if position.x - train_pos.x <= 1280 - 240:
		moving = true

func _process(delta: float) -> void:
	if moving:
		position.x -= speed * delta
		if position.x <= 0:
			self.queue_free()
