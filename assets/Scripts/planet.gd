extends Area2D
class_name Planet

@export var planet_info: PlanetData

@onready var menu = $MenuAnchor/planet_info_ui
@onready var name_lbl = $MenuAnchor/planet_info_ui/NameLabel
@onready var pop_lbl = $MenuAnchor/planet_info_ui/PopLabel
@onready var rsr_lbl = $MenuAnchor/planet_info_ui/RsrLabel

static var current_menu: Node2D = null

var population_counter = -2


func _on_mouse_entered():
	$AnimatedSprite2D.set_instance_shader_parameter("active", true)

func _on_mouse_exited():
	$AnimatedSprite2D.set_instance_shader_parameter("active", false)
	
func _ready() -> void:
	TurnManager.add_planet(self)
	menu.visible = false
	if planet_info:
		mouse_entered.connect(_on_mouse_entered)
		mouse_exited.connect(_on_mouse_exited)
		
		name_lbl.text = str(planet_info.planet_name)
		pop_lbl.text = str(planet_info.population)
		rsr_lbl.text = "HOPE: "+str(planet_info.hope) + " TECH: "+str(planet_info.tech)
		$AnimatedSprite2D.sprite_frames = planet_info.sprite_frames
		$AnimatedSprite2D.play("default")
		
		$AnimatedSprite2D.set_instance_shader_parameter("active",false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func display_menu() -> void:
	if(current_menu != null && current_menu != menu):
		current_menu.visible = false
	menu.visible = !menu.visible
	current_menu = menu
	name_lbl.text = str(planet_info.planet_name)
	pop_lbl.text = str(planet_info.population)
	rsr_lbl.text = "HOPE: "+str(planet_info.hope) + " TECH: "+str(planet_info.tech)

func handle_click() -> void:
	TurnManager.currentElement = self
	display_menu()

func process_population() -> void:
	if(planet_info.controlled_by == GameEnums.ControlledBy.HUMAN):
		population_counter +=1
	grow_population()
	
func grow_population() -> void:
	if(population_counter < 3):
		return
	population_counter = 0
	planet_info.population +=1
	pass

func process_material() -> void:
	var mat = planet_info.mat_type
	MatManager.grow_mats(mat,planet_info.mat_growth)
	pass
