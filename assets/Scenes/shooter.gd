extends CharacterBody2D


const move_speed = 70
const bullet_speed = 500
const Bullet_scene = preload("res://assets/Scenes/enemy_bullet.tscn")
const offset = 70
var player: CharacterBody2D = null

@onready var muzzle = $Muzzle

func _ready() -> void:	
	player = get_tree().root.find_child("Player",true,false)

func _physics_process(delta: float) -> void:
	chase_player()
	if player_close():
		shoot()

func shoot()->void:
	var bullet = Bullet_scene.instantiate()
	bullet.set_direction(Vector2(0,1))
	bullet.speed = bullet_speed
	get_tree().root.add_child(bullet)
	bullet.global_position = muzzle.global_position

func chase_player() -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		direction.y = 0
		if(global_position.y > player.global_position.y - offset):
			direction.y = -1
		velocity = direction * move_speed
		look_at(direction)
		move_and_slide()

func player_close() -> bool:
	if((global_position.x > player.global_position.x - offset) && (global_position.x < player.global_position.x + offset)):
		return true
	return false
