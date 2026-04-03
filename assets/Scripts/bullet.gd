extends Area2D

var speed: float = 10.0
var direction = Vector2(0,-1)
func _ready() -> void:
	body_entered.connect(hit)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func hit(body) -> void:
	set_physics_process(false)
	$CollisionShape2D.set_deferred("disabled",true)
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()

func set_direction(s_direction: Vector2)-> void:
	direction = s_direction
