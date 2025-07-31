class_name Obstacle
extends Node2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		SignalBus.lose.emit()
