extends PathFollow2D

var speed : float = 100.0
var drag : float = 1.0005
var gravity : float = 0.9
var boost_amount : float = 100.0
var furthest_x : float = 0

func _ready():
	SignalBus.lose.connect(lose)

func lose():
	print("LOSER")

func _process(delta: float) -> void:
	progress += speed * delta
	furthest_x = max(global_position.x,furthest_x)
	if progress_ratio >= 1 or global_position.y < 0 or global_position.y > 720 or global_position.x < -100:
		SignalBus.lose.emit()
	SignalBus.position_camera.emit(global_position)
	SignalBus.position_cars.emit(progress)
	$RoarPlayer.volume_linear = inverse_lerp(0,500,speed)

func _physics_process(_delta: float) -> void:
	# Special Track Collisions
	var overlapping = $Area2D.get_overlapping_areas()
	for area in overlapping:
		if area.collision_layer == 2:
			speed = max(speed, 100.0)

	# Speed
	speed /= drag
	var rot = wrapf(rotation,-PI,PI)
	if rot > 0:
		speed += gravity * (PI/2 - abs(rot - PI/2))
	elif rot < 0:
		speed -= gravity * (PI/2 - abs(rot - -PI/2))


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.collision_layer == 4 and speed > 0:
		speed = max(speed+boost_amount, 200)
		print("BOOST! (speed = " + str(speed) + ")")
		$BoostPlayer.play()
	if area.collision_layer == 64:
		SignalBus.lose.emit()
	if area.collision_layer == 128:
		SignalBus.win.emit()
