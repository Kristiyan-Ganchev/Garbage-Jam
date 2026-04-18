extends Area2D
class_name System

@export var system_info: SystemData

@onready var reach_btn = $ColloniseMenu/Button
@onready var collonise_menu = $ColloniseMenu
@onready var ship_lbl = $ResourceLabel

# Called when the node enters the scene tree for the first time.
func _on_mouse_entered():
	$AnimatedSprite2D.set_instance_shader_parameter("active", true)

func _on_mouse_exited():
	$AnimatedSprite2D.set_instance_shader_parameter("active", false)
	
func _ready() -> void:
	if system_info:
		mouse_entered.connect(_on_mouse_entered)
		mouse_exited.connect(_on_mouse_exited)
		
		collonise_menu.visible=false
		ship_lbl.text = ""
		if(!TurnManager.reached_systems.has(system_info.system_name)):
			reach_btn.pressed.connect(collonise)
			collonise_menu.visible = true
			ship_lbl.text = "@" + str(system_info.needed_ships)
		
		$AnimatedSprite2D.sprite_frames = system_info.sprite_frames
		$AnimatedSprite2D.play("default")
		
		$AnimatedSprite2D.set_instance_shader_parameter("active",false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func collonise()-> void:
	if(MatManager.interstellars >= system_info.needed_ships):
		TurnManager.add_system(self.system_info)
		MatManager.interstellars -= system_info.needed_ships
	collonise_menu.visible = false
	ship_lbl.text = ""


func handle_click() -> void:
	TurnManager.currentElement = self
	if(TurnManager.reached_systems.has(system_info.system_name)):
		TurnManager.state = GameEnums.States.System
		UiManager.enable_ui(GameEnums.UIs.TURN)
		get_tree().change_scene_to_packed(system_info.scene)
