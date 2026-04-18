extends Node

@onready var player1 = AudioStreamPlayer.new()

func _ready() -> void:
	add_child(player1)	
	player1.bus = "Music"

func play_music(stream: AudioStream,fade_time: float = 1.0) -> void:
	if player1:
		player1.stream = stream
		player1.play()

func _process(delta: float) -> void:
	pass
