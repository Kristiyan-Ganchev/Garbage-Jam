extends Node2D

@export var scroll_speed = 80
func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	position.y += scroll_speed * delta
