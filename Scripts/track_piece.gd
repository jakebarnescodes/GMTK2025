class_name TrackPiece
extends Path2D

func _ready() -> void:
	SignalBus.build_piece.connect(darken)

func darken(_piece_path : String):
	modulate.r -= 0.05
