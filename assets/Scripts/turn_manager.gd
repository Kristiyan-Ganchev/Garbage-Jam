extends Node

var turnCount = 0
var overrall_population = 0
var currentElement: Node2D = null
var state: GameEnums.States = GameEnums.States.Galaxy
@export var starting_system: SystemData
var planet_dict: Dictionary[String,PlanetData] = { }
var reached_systems: Dictionary [String,SystemData] ={ }
var last_scene_path: String = ""
var shmup_planet: PlanetData = null

func _ready() -> void:
	if starting_system !=null:
		add_system(starting_system)
	process_planets()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func process_turn() -> void:
	turnCount +=1
	process_planets()
	if(currentElement && currentElement is Planet):
		currentElement.display_menu()
		currentElement.display_menu()

func process_planets() -> void:
	var pop_sum = 0
	for planet in planet_dict:
		var data = planet_dict[planet] as PlanetData
		if(data.controlled_by == GameEnums.ControlledBy.HUMAN):
			planet_dict[planet].process_turn()
			pop_sum += data.population
	overrall_population = pop_sum

func add_planet(planet: Planet) -> void:
	var p_name = planet.planet_info.planet_name
	
	if(planet_dict.has(p_name)):
		planet.planet_info = planet_dict[p_name]
	else:
		planet_dict[p_name] = planet.planet_info

func go_to_galaxy_map() -> void:
	state = GameEnums.States.Galaxy
	UiManager.wipe_ui()
	get_tree().change_scene_to_file("res://scenes/galaxy_map.tscn")
	
func go_to_schmup(planet: PlanetData) -> void:
	state = GameEnums.States.SHMUP
	UiManager.wipe_ui()
	shmup_planet = planet
	last_scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/schmup.tscn")
	
func finish_shmup() -> void:
	state = GameEnums.States.System
	UiManager.wipe_ui()
	if shmup_planet:
		shmup_planet.controlled_by = GameEnums.ControlledBy.NEUTRAL
	if last_scene_path && last_scene_path != "":
		UiManager.enable_ui(GameEnums.UIs.TURN)
		get_tree().call_deferred("change_scene_to_file",last_scene_path)
	else: 
		call_deferred("go_to_galaxy_map")
	
func add_system(system: SystemData) -> void:
	if(reached_systems.has(system.system_name)):
		system = reached_systems[system.system_name]
	else:
		reached_systems[system.system_name] = system
