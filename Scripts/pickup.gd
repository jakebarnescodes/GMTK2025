extends Node2D

var amp := 5.0
var speed := 5.0

var rot_amp := 0.1
var rot_speed := 10.0

var time := 0.0

@onready var init_pos_y := position.y

func _process(delta: float) -> void:
	time += delta
	position.y = init_pos_y + sin(time * speed) * amp
	rotation = sin(time * rot_speed) * rot_amp

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		SignalBus.pickup_loop.emit()
		SignalBus.play_sfx.emit("res://SFX/pickup.wav")
		self.queue_free()
