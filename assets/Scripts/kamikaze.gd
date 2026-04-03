extends CharacterBody2D

@export var speed: int = 50
@export var damage: int = 1

@onready var hitbox = $Hitbox
var player: CharacterBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	hitbox.body_entered.connect(_on_body_entered)
	player = get_tree().root.find_child("Player",true,false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		look_at(direction)
		move_and_slide()

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	explode()

func explode() -> void:
	queue_free()

func take_damage() -> void:
	explode()
