class_name Bugs
extends Obstacle

var amp := 10.0
var speed := 10.0

var time := 0.0

@onready var init_pos_y := position.y

func _ready():
	$AnimatedSprite2D.play("default")

func _process(delta: float) -> void:
	time += delta
	position.y = init_pos_y + sin(time) * amp
