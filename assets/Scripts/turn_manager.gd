extends Node

enum control {
	Neutral, 
	Alien , 
	Human
}
var turnCount = 0
var overrall_population = 0
var controlled_planets: Array[Planet] = []
var currentElement: Node2D = null
var planet_dict: Dictionary[String,PlanetData] = { }

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_population()
	print(controlled_planets)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func process_turn() -> void:
	turnCount +=1
	process_population()
	if(currentElement && currentElement is Planet):
		currentElement.display_menu()
		currentElement.display_menu()

func process_population() -> void:
	var pop_sum = 0
	for planet in controlled_planets:
		planet.process_population()
	for planet in planet_dict:
		var data = planet_dict[planet] as PlanetData
		if(data.controlled_by == GameEnums.ControlledBy.HUMAN):
			pop_sum += data.population
	overrall_population = pop_sum

func add_planet(planet: Planet) -> void:
	if(planet.planet_info.controlled_by == GameEnums.ControlledBy.HUMAN && !controlled_planets.has(planet)):
		controlled_planets.append(planet)
	var p_name = planet.planet_info.planet_name
	
	if(planet_dict.has(p_name)):
		planet.planet_info = planet_dict[p_name]
	else:
		planet_dict[p_name] = planet.planet_info

func go_to_galaxy_map() -> void:
	controlled_planets.clear()
	get_tree().change_scene_to_file("res://scenes/galaxy_map.tscn")
