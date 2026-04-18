extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var left_muzzle = $LeftMuzzle
@onready var right_muzzle = $RightMuzzle
@onready var sound = $AudioStreamPlayer2D

const Bullet_scene = preload("res://assets/Scenes/bullet.tscn")
const move_speed = 150
const bullet_speed = 500

var is_moving: bool = false
var is_shooting: bool = false
var hp = 3.0
var lives = MatManager.fighters
var move_dir: Vector2
var is_invincible = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		shoot() 
	else: is_shooting = false
	animation_manager()

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	move_dir = direction.normalized()
	if(direction.length() < 0.01):
		is_moving = false
	else: 
		is_moving = true
		
	velocity = direction*move_speed
	move_and_slide()

func shoot() -> void:
	if !sound.playing:
		sound.pitch_scale = randf_range(0.8,1.1)
		sound.play()
	is_shooting=true
	var left_bullet = Bullet_scene.instantiate()
	var right_bullet = Bullet_scene.instantiate()
	
	left_bullet.speed = bullet_speed
	right_bullet.speed = bullet_speed
	
	get_tree().root.add_child(left_bullet)
	get_tree().root.add_child(right_bullet)
	
	left_bullet.global_position = left_muzzle.global_position
	right_bullet.global_position = right_muzzle.global_position


func animation_manager() -> void:
	var target_anim = "default"
	
	if move_dir.x < -0.1:
		target_anim = "move_left"
	elif move_dir.x > 0.1:
		target_anim = "move_right"
	elif move_dir.y != 0:
		target_anim = "move_y"
	else:
		target_anim = "default"
		
	if sprite.animation != target_anim:
		sprite.play(target_anim)

func take_damage(amount:float) -> void:
	if is_invincible:
		return
	is_invincible = true
	flash_white()
	hp -=amount
	UiManager.change_hp(ceil(hp))
	if hp <= 0:
		die()
	else:
		await get_tree().create_timer(0.3).timeout
		is_invincible = false
		
func flash_white() -> void:
	sprite.material.set_shader_parameter("active",true)
	await get_tree().create_timer(0.1).timeout
	sprite.material.set_shader_parameter("active",false)
	
func die() -> void:
	lives -=1
	if lives < 0:
		print("failed")
		TurnManager.fail_shmup()
	else:
		MatManager.fighters -=1
		respawn()
		
func respawn() -> void:
	hp = 3
	UiManager.change_hp(hp)
	UiManager.change_lives(MatManager.fighters)
	await get_tree().create_timer(0.3).timeout
	is_invincible = false
