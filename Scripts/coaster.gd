class_name Coaster
extends Path2D

func _ready() -> void:
	SignalBus.build_piece.connect(build)
	reset_curve(6)

func reset_curve(keep_count: int):
	var total = curve.get_point_count()
	for i in range(total - 1, keep_count - 1, -1):
		curve.remove_point(i)

func build(piece_path : String):
	var piece_scene = load(piece_path)
	var piece_node = piece_scene.instantiate()
	add_child(piece_node)
	append_piece(piece_node)
	$Sprite2D.modulate.r -= 0.05
	$BuildPlayer.pitch_scale = randf_range(0.8,1.0)
	$BuildPlayer.play()

func append_piece(piece_path : TrackPiece):
	var piece_curve : Curve2D = piece_path.curve
	var piece_curve_count := piece_curve.get_point_count()
	var self_curve_count := self.curve.get_point_count()
	print("APPEND " + str(piece_path.name))

	# Get rotation angle
	var self_dir := (self.curve.get_point_position(self_curve_count - 1) - self.curve.get_point_position(self_curve_count - 2)).normalized()
	print("self_dir: " + str(self_dir))
	var piece_dir := (piece_curve.get_point_position(1) - piece_curve.get_point_position(0)).normalized()
	print("piece_dir: " + str(piece_dir))
	var angle := -self_dir.angle_to(piece_dir)
	print("angle: " + str(rad_to_deg(angle)))
	var rot := Transform2D(angle, Vector2.ZERO)

	# Offset position to attach curve_b to curve_a
	var attach_point := self.curve.get_point_position(self_curve_count - 1)
	var first_b := piece_curve.get_point_position(0)
	var translation := attach_point - rot * first_b

	# Add points to curve
	for i in range(piece_curve_count):
		var pos := rot * piece_curve.get_point_position(i) + translation
		var in_tangent := rot * piece_curve.get_point_in(i)
		var out_tangent := rot * piece_curve.get_point_out(i)
		self.curve.add_point(pos, in_tangent, out_tangent)

	# Align piece node
	piece_path.position = attach_point
	piece_path.rotation = angle

func print_path():
	for i in range(self.curve.get_point_count()):
		var local_point := self.curve.get_point_position(i)
		var global_point := self.to_global(local_point)
		print(global_point)
