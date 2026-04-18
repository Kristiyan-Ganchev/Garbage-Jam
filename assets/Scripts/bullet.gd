extends Area2D

var speed: float = 10.0
var direction = Vector2(0,-1)
var damage: float = 1
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	sprite.play("default")
	var notifier = $VisibleOnScreenNotifier2D
	notifier.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
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
		body.take_damage(damage)
	sprite.play("dissapate")
	await sprite.animation_finished
	queue_free()

func set_direction(s_direction: Vector2)-> void:
	direction = s_direction
