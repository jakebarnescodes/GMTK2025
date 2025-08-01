extends Control

var loops : int = 0

func _ready() -> void:
	SignalBus.pickup_loop.connect(add_loop)
	$BoostLabel.visible = false
	#add_loop()

func add_loop():
	loops += 1
	$BoostButton.disabled = false
	$BoostLabel.text = str(loops)
	$BoostLabel.visible = true

func remove_loop():
	loops -= 1
	if loops <= 0:
		$BoostButton.disabled = true
		$BoostLabel.visible = false
	$BoostLabel.text = str(loops)

## BUILD

func _on_straight_button_pressed() -> void:
	SignalBus.build_piece.emit("res://Scenes/Track Pieces/straight_piece.tscn")

func _on_down_button_pressed() -> void:
	SignalBus.build_piece.emit("res://Scenes/Track Pieces/down_piece.tscn")

func _on_up_button_pressed() -> void:
	SignalBus.build_piece.emit("res://Scenes/Track Pieces/up_piece.tscn")

func _on_boost_button_pressed() -> void:
	SignalBus.build_piece.emit("res://Scenes/Track Pieces/boost_piece.tscn")
	remove_loop()
