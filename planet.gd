extends Area2D
class_name Planet

@export var planet_info: PlanetData

@onready var menu = $MenuAnchor/MenuSprite
# Called when the node enters the scene tree for the first time.
func _on_mouse_entered():
	$AnimatedSprite2D.set_instance_shader_parameter("active", true)

func _on_mouse_exited():
	$AnimatedSprite2D.set_instance_shader_parameter("active", false)
	
func _ready() -> void:
	menu.hide()
	if planet_info:
		mouse_entered.connect(_on_mouse_entered)
		mouse_exited.connect(_on_mouse_exited)
		
		$AnimatedSprite2D.sprite_frames = planet_info.sprite_frames
		$AnimatedSprite2D.play("idle")
		
		$AnimatedSprite2D.set_instance_shader_parameter("active",false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func handle_click() -> void:
	menu.visible = !menu.visible
	
