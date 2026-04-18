extends CharacterBody2D


const move_speed = 70
const bullet_speed = 200
const Bullet_scene = preload("res://assets/Scenes/enemy_bullet.tscn")

const offset = 100
var player: CharacterBody2D = null
var hp = 100
var dead = false
var can_shoot = true
var burst_count = 5
var bullet_damage = 0.2
var bullet_gap = 10

@onready var hitbox = $Hitbox
@onready var sound = $AudioStreamPlayer2D
@onready var muzzle = $Muzzle
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:	
	player = get_tree().root.find_child("Player",true,false)

func _physics_process(delta: float) -> void:
	if dead:
		return
	if hp <= 0:
		die()
		return
	chase_player()
	if player_close() && can_shoot:
		shoot()
		

func shoot()->void:
	can_shoot = false
	sprite.play("attack")
	
	for i in range(burst_count):
		var bullet = Bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		
		var y_offset = (i - 2) * bullet_gap
		bullet.global_position = muzzle.global_position + Vector2(0, y_offset)
		
		bullet.set_direction(Vector2(0,1))
		bullet.speed = bullet_speed
		bullet.damage = bullet_damage
		
	
	await get_tree().create_timer(1).timeout
	can_shoot = true

func chase_player() -> void:
	if !sprite.animation == "attack" || !sprite.is_playing():
		sprite.play("idle")
	if player:
		var direction = Vector2.ZERO
		
		var x_diff = player.global_position.x - global_position.x
		
		if abs(x_diff) > 10:
			direction.x = sign(x_diff)
				
		var target_y = player.global_position.y - offset
		var y_diff = target_y - global_position.y
			
		if abs(y_diff) > 10: 
			direction.y = sign(y_diff)
			
		velocity = direction * move_speed
		move_and_slide()

func player_close() -> bool:
	if((global_position.x > player.global_position.x - offset) && (global_position.x < player.global_position.x + offset)):
		return true
	return false

func take_damage(amount: int) -> void:
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
	queue_free()
	
func flash_white() -> void:
	sprite.material.set_shader_parameter("active",true)
	await get_tree().create_timer(0.1).timeout
	sprite.material.set_shader_parameter("active",false)
	
