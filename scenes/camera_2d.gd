extends Camera2D

@export var decay := 0.8  
@export var max_offset := Vector2(100, 75)  
@export var max_roll := 0.1  

var trauma := 0.0  
var trauma_power := 2

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	if trauma:
		trauma = max(trauma - decay * delta,0)
		shake()
	pass

func shake() -> void:
	var amount = pow(trauma,trauma_power)
	rotation = max_roll * amount * randf_range(-1,1)
	offset.x = max_offset.x * amount * randf_range(-1,1)
	offset.y = max_offset.y * amount * randf_range(-1,1)

func add_trauma(amount: float) -> void:
	trauma = min(trauma + amount,0.1)

func hit_stop(duration: float, amount: float = 0.8) -> void:
	Engine.time_scale = amount
	await get_tree().create_timer(duration,true,false,true).timeout
	Engine.time_scale = 1.0
	
