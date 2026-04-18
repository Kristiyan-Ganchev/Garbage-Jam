extends CharacterBody2D

@export var speed: int = 80
@export var attack_speed_modifier = 2
@export var damage: int = 1
const Distance_sqr = 10000


@onready var sound = $AudioStreamPlayer2D
@onready var hitbox = $Hitbox
@onready var sprite = $AnimatedSprite2D
var player: CharacterBody2D = null
var hp = 50
var dead = false

func _ready() -> void:	
	sprite.play("idle")
	hitbox.body_entered.connect(_on_body_entered)
	player = get_tree().root.find_child("Player",true,false)

func _physics_process(delta: float) -> void:
	if dead:
		return
	if hp <= 0:
		die()
		return
	if player:
		var dist_sq = global_position.distance_squared_to(player.global_position)
		if dist_sq < Distance_sqr:
			attack()
		else:
			move()

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		die()

func attack() -> void:
	sprite.play("attack")
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed * attack_speed_modifier
	look_at(player.global_position)
	move_and_slide()
	
func move() -> void:
	sprite.play("idle")
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	look_at(player.global_position)
	move_and_slide()

func take_damage(amount:int) -> void:
	flash_white()
	var cam = get_tree().get_first_node_in_group("camera")
	if cam:
		cam.add_trauma(0.2)
		cam.hit_stop(0.1,0.8)
	hp -= amount

func die() -> void:
	sprite.play("die")
	if !sound.playing:
		sound.pitch_scale = randf_range(0.8,1.1)
		print("sound")
		sound.play()
	dead = true
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	collision_layer = 0 
	collision_mask = 0
	await sprite.animation_finished
	queue_free()
	
func flash_white() -> void:
	sprite.material.set_shader_parameter("active",true)
	await get_tree().create_timer(0.1).timeout
	sprite.material.set_shader_parameter("active",false)
	
