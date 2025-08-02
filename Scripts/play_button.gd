extends TextureButton

func _on_mouse_entered() -> void:
	scale = Vector2(1.1,1.1)

func _on_mouse_exited() -> void:
	scale = Vector2(1.0,1.0)

func _on_pressed() -> void:
	SignalBus.play_sfx.emit("res://SFX/select.wav")
	SignalBus.play.emit()
