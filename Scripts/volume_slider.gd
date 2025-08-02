extends HSlider

func _on_value_changed(value: float) -> void:
	var db_volume = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db_volume)
