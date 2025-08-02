extends PathFollow2D

@export var car_number : int

func _ready() -> void:
	SignalBus.position_cars.connect(set_car_progress)

func set_car_progress(train_progress : float):
	progress = max(0,train_progress - (44 * car_number))
