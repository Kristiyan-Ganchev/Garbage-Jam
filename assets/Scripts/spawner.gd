extends Node2D

@export var enemy_scene: PackedScene
@onready var notifier = $VisibleOnScreenNotifier2D

func _ready() -> void:
	notifier.screen_entered.connect(spawn)
	pass # Replace with function body.


func _process(delta: float) -> void:
	
	pass

func spawn() -> void:
	if enemy_scene:
		var enemy = enemy_scene.instantiate()
		get_parent().get_parent().add_child(enemy)
		enemy.global_position = global_position
	queue_free()
