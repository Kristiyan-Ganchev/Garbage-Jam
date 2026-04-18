extends Area2D
class_name Planet

static var current_menu: Node2D = null

@onready var menu = $MenuAnchor/planet_info_ui

@onready var collonise_menu = $ColloniseMenu
@onready var collonise_btn = $ColloniseMenu/Collonise

@onready var attack_menu = $AttackMenu
@onready var attack_btn = $AttackMenu/Attack

@onready var name_lbl = $MenuAnchor/planet_info_ui/NameLabel
@onready var pop_lbl = $MenuAnchor/planet_info_ui/PopLabel
@onready var rsr_lbl = $MenuAnchor/planet_info_ui/RsrLabel

@onready var build_pb = $BuildPB
@onready var build_lbl = $BuildLbl
@onready var resource_lbl = $ResourceLabel

@onready var build_mech_legs_btn = get_node("/root/Ui/BuildUi/LegsBtn")
@onready var build_mech_arms_btn = get_node("/root/Ui/BuildUi/ArmsBtn")
@onready var build_mech_fin_btn = get_node("/root/Ui/BuildUi/FinBtn")


@onready var build_ship_btn = get_node("/root/Ui/BuildUi/ShipBtn")
@onready var build_interstellar_btn = get_node("/root/Ui/BuildUi/InterstellarBtn")
@onready var build_fighter_btn = get_node("/root/Ui/BuildUi/FighterBtn")
@onready var build_btn = get_node("/root/Ui/BuildUi/Build")
@onready var cancel_build_btn = get_node("/root/Ui/BuildUi/Cancel")

@export var planet_info: PlanetData

var to_build: GameEnums.Builds = GameEnums.Builds.NONE

func _on_mouse_entered():
	$AnimatedSprite2D.set_instance_shader_parameter("active", true)

func _on_mouse_exited():
	$AnimatedSprite2D.set_instance_shader_parameter("active", false)
	
func _ready() -> void:
	TurnManager.add_planet(self)
	
	build_ship_btn.pressed.connect(build_target.bind(GameEnums.Builds.SHIP))
	build_interstellar_btn.pressed.connect(build_target.bind(GameEnums.Builds.INTERSTELLAR))
	build_fighter_btn.pressed.connect(build_target.bind(GameEnums.Builds.FIGHTER))
	build_mech_legs_btn.pressed.connect(build_target.bind(GameEnums.Builds.LEGS))
	build_mech_arms_btn.pressed.connect(build_target.bind(GameEnums.Builds.ARMS))
	build_mech_fin_btn.pressed.connect(build_target.bind(GameEnums.Builds.V_FIN))
	build_btn.pressed.connect(build_press)
	cancel_build_btn.pressed.connect(build_cancel)
	collonise_btn.pressed.connect(collonise_press)
	attack_btn.pressed.connect(attack_press)
	
	
	wipe_planet_ui()
	if planet_info:
		mouse_entered.connect(_on_mouse_entered)
		mouse_exited.connect(_on_mouse_exited)
		
		name_lbl.text = str(planet_info.planet_name)
		pop_lbl.text = str(planet_info.population)
		rsr_lbl.text = "HOPE: "+str(planet_info.hope) + " TECH: "+str(planet_info.tech)
		$AnimatedSprite2D.sprite_frames = planet_info.sprite_frames
		$AnimatedSprite2D.play("default")
		
		$AnimatedSprite2D.set_instance_shader_parameter("active",false)
		
		if planet_info.controlled_by == GameEnums.ControlledBy.HUMAN:
			match planet_info.mat_type:
				GameEnums.Mats.MATS:
					resource_lbl.text = "&"
				GameEnums.Mats.HEAVY:
					resource_lbl.text = "$"
				GameEnums.Mats.SUNS:
					resource_lbl.text = "%"
				GameEnums.Mats.LICH:
					resource_lbl.text = "^"
		elif planet_info.controlled_by == GameEnums.ControlledBy.NEUTRAL:
			resource_lbl.text = "}"+str(planet_info.needed_ships_to_colonise)
		else: resource_lbl.text = ""

func _process(delta: float) -> void:
	build_pb.value = planet_info.get_build_progress()
	if planet_info.build == GameEnums.Builds.NONE:
		build_lbl.text = ""
	pass

func display_menu() -> void:
	if(current_menu != null && current_menu != menu):
		current_menu.visible = false
	menu.visible = !menu.visible
	current_menu = menu
	name_lbl.text = str(planet_info.planet_name)
	pop_lbl.text = str(planet_info.population)
	rsr_lbl.text = "HOPE: "+str(planet_info.hope) + " TECH: "+str(planet_info.tech)

func display_collonise() -> void:
	if(current_menu != null && current_menu != collonise_menu):
		current_menu.visible = false
	collonise_menu.visible = !collonise_menu.visible
	current_menu = collonise_menu

func display_attack() ->void:
	if(current_menu != null && current_menu != attack_menu):
		attack_menu.visible = false
	attack_menu.visible = !attack_menu.visible
	current_menu = attack_menu

func handle_click() -> void:
	if current_menu != null:
		current_menu.visible = false
		current_menu = null
	TurnManager.currentElement = self
	TurnManager.state = GameEnums.States.Planet
	
	if(planet_info.controlled_by == GameEnums.ControlledBy.HUMAN):
		UiManager.enable_ui(GameEnums.UIs.BUILD)
		display_menu()
	elif(planet_info.controlled_by == GameEnums.ControlledBy.NEUTRAL):
		UiManager.enable_ui(GameEnums.UIs.TURN)
		display_collonise()
	elif(planet_info.controlled_by == GameEnums.ControlledBy.ALIEN):
		UiManager.enable_ui(GameEnums.UIs.TURN)
		display_attack()

func build_target(build_target: GameEnums.Builds) -> void:
	if(MatManager.can_build(build_target)):
		to_build = build_target

func build_press() -> void:
	if(TurnManager.currentElement != self):
		return
	planet_info.set_build(to_build)
	to_build = GameEnums.Builds.NONE
	match planet_info.build:
				GameEnums.Builds.SHIP:
					build_lbl.text = "}"
				GameEnums.Builds.INTERSTELLAR:
					build_lbl.text = "@"
				GameEnums.Builds.FIGHTER:
					build_lbl.text = "#"
				GameEnums.Builds.LEGS:
					build_lbl.text = "]"
				GameEnums.Builds.ARMS:
					build_lbl.text = "["
				GameEnums.Builds.V_FIN:
					build_lbl.text = "*"
				GameEnums.Builds.NONE:
					build_lbl.text = ""

func build_cancel() -> void:
	if(TurnManager.currentElement != self):
		return
	planet_info.cancel_build()
	to_build = GameEnums.Builds.NONE
	build_lbl.text = ""
	
func collonise_press() -> void:
	if(TurnManager.currentElement != self):
		return
	if(MatManager.ships < planet_info.needed_ships_to_colonise):
		return
	MatManager.ships -= planet_info.needed_ships_to_colonise
	planet_info.controlled_by = GameEnums.ControlledBy.HUMAN
	collonise_menu.visible=false
	match planet_info.mat_type:
				GameEnums.Mats.MATS:
					resource_lbl.text = "&"
				GameEnums.Mats.HEAVY:
					resource_lbl.text = "$"
				GameEnums.Mats.SUNS:
					resource_lbl.text = "%"
				GameEnums.Mats.LICH:
					resource_lbl.text = "^"

func attack_press() -> void:
	if(TurnManager.currentElement !=self):
		return
	if(MatManager.fighters <= 0):
		return
	attack_menu.visible = false
	TurnManager.go_to_schmup(planet_info)
	
func wipe_planet_ui() -> void:
	collonise_menu.visible = false
	menu.visible = false
	attack_menu.visible = false
