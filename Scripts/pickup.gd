extends Node2D

var amp := 5.0
var speed := 5.0

var time := 0.0

@onready var init_pos_y := position.y

func _process(delta: float) -> void:
	time += delta
	position.y = init_pos_y + sin(time) * amp

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		SignalBus.pickup_loop.emit()
		self.queue_free()
