extends Node2D

@onready var complete_area = $Area2D

func _ready() -> void:
	complete_area.body_entered.connect(complete_level)
	pass

func _process(delta: float) -> void:
	pass


func complete_level(body) -> void:
	if body.is_in_group("player"):
		TurnManager.finish_shmup()
