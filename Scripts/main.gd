extends Node

var main_menu_scene := preload("res://Scenes/main_menu.tscn")
var main_menu_node : Node2D
var level_1_scene := preload("res://Scenes/level_1.tscn")
var level_1_node : Node2D

func _ready():
	SignalBus.lose.connect(lose)
	SignalBus.play.connect(play_level_1)

	main_menu_node = main_menu_scene.instantiate()
	add_child(main_menu_node)

func lose():
	#level_1_node.process_mode = PROCESS_MODE_DISABLED
	level_1_node.call_deferred("set", "process_mode", Node.PROCESS_MODE_DISABLED)
	SignalBus.play_sfx.emit("res://SFX/game-over.wav")
	$RespawnTimer.start()

func play_level_1():
	main_menu_node.queue_free()
	level_1_node = level_1_scene.instantiate()
	add_child(level_1_node)

func _on_respawn_timer_timeout() -> void:
	$RespawnTimer.stop()
	level_1_node.queue_free()
	level_1_scene = load("res://Scenes/level_1.tscn")
	level_1_node = level_1_scene.instantiate()
	add_child(level_1_node)
