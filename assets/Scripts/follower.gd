extends CharacterBody2D

@export var damage: int = 1

@onready var sound = $AudioStreamPlayer2D
@onready var hitbox = $Hitbox
@onready var sprite = $AnimatedSprite2D
@onready var follow_speed = 100
@onready var path_follow: PathFollow2D = get_parent() as PathFollow2D
var player: CharacterBody2D = null
var hp = 50
var dead = false

func _ready() -> void:	
	sprite.play("idle")
	hitbox.body_entered.connect(_on_body_entered)
	player = get_tree().root.find_child("Player",true,false)

func _process(delta: float) -> void:
	if dead:
		return
	if path_follow:
		path_follow.progress += follow_speed * delta
		if path_follow.progress_ratio >= 1.0:
			die()
			
func _physics_process(delta: float) -> void:
	if dead:
		return
	if hp <= 0:
		die()
		return
	
func _on_body_entered(body):
	print(body)
	if body.has_method("take_damage"):
		body.take_damage(damage)
	die()

func take_damage(amount:int) -> void:
	flash_white()
	var cam = get_tree().get_first_node_in_group("camera")
	if cam:
		cam.add_trauma(0.2)
		cam.hit_stop(0.1,0.8)
	hp -= amount

func die() -> void:
	if !sound.playing:
		sound.pitch_scale = randf_range(0.8,1.1)
		sound.play()
	dead = true
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	collision_layer = 0 
	collision_mask = 0
	sprite.play("die")
	await sprite.animation_finished
	if path_follow:
		path_follow.queue_free()
	queue_free()

func flash_white() -> void:
	sprite.material.set_shader_parameter("active",true)
	await get_tree().create_timer(0.1).timeout
	sprite.material.set_shader_parameter("active",false)
	
