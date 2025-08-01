extends AudioStreamPlayer

func _ready() -> void:
	SignalBus.play_sfx.connect(play_sfx)

func play_sfx(string):
	stream = load(string)
	play()
