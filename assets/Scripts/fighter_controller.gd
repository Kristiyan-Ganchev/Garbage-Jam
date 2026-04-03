extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var left_muzzle = $LeftMuzzle
@onready var right_muzzle = $RightMuzzle

const Bullet_scene = preload("res://assets/Scenes/bullet.tscn")
const move_speed = 100
const bullet_speed = 500

var is_moving: bool = false
var is_shooting: bool = false
var hp = 3

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		shoot() 
	else: is_shooting = false
	animation_manager()

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	if(direction.length() < 0.01):
		is_moving = false
	else: is_moving = true
	velocity = direction*move_speed
	move_and_slide()

func shoot() -> void:
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
	if !is_moving && !is_shooting:
		sprite.play("default") 
	if is_moving && !is_shooting:
		sprite.play("move") 
	if !is_moving && is_shooting:
		sprite.play("shoot") 
	if is_moving && is_shooting:
		sprite.play("move_shoot") 
		
func take_damage(amount:int) -> void:
	hp -=amount
