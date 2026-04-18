extends Resource
class_name PlanetData 


@export var planet_name: String = "Unknown"
@export var controlled_by: GameEnums.ControlledBy = GameEnums.ControlledBy.NEUTRAL
@export var population: int = 0
@export var tech: int = 0
@export var hope: int = 0
@export var sprite_frames: SpriteFrames
@export var mat_type: GameEnums.Mats = GameEnums.Mats.MATS
@export var mat_growth: int = 1
@export var mat_max_countdown = 10
@export var needed_ships_to_colonise = 1

static var ship_build_length = 10
static var interstellar_build_length = 15
static var fighter_build_length = 5
static var mech_arms_build_length = 10
static var mech_legs_build_length = 10
static var mech_fin_build_length = 10

var mat_countdown = mat_max_countdown
var mat_acq_speed = 1
var population_counter = -2
var builder_counter = 0

var build: GameEnums.Builds = GameEnums.Builds.NONE
var build_length = 100

func process_population() -> void:
	if(controlled_by == GameEnums.ControlledBy.HUMAN):
		population_counter +=1
	grow_population()
	
func grow_population() -> void:
	if(population_counter < 3):
		return
	population_counter = 0
	population +=1
	pass

func process_material() -> void:
	var mat = mat_type
	var mat_acq = mat_acq_speed * (population/3)
	var modifier = 1
	mat_countdown -= mat_acq
	if(mat_acq > mat_max_countdown):
		modifier = mat_acq/mat_max_countdown
	if(mat_countdown<=0):
		MatManager.grow_mats(mat,mat_growth * modifier)
		mat_countdown = mat_max_countdown

func process_build() -> void:
	if(build == GameEnums.Builds.NONE):
		return
	builder_counter +=1
	if(builder_counter <= build_length):
		return
	#if(build == GameEnums.Builds.SHIP):
		#MatManager.get_ships(1)
		#set_build(GameEnums.Builds.NONE)
	#elif(build == GameEnums.Builds.INTERSTELLAR):
		#MatManager.get_interstellars(1)
		#set_build(GameEnums.Builds.NONE)
	#elif(build == GameEnums.Builds.FIGHTER):
		#MatManager.get_fighters(1)
		#set_build(GameEnums.Builds.NONE)
	match build:
		GameEnums.Builds.SHIP:
			MatManager.get_ships(1)
			set_build(GameEnums.Builds.NONE)
		GameEnums.Builds.INTERSTELLAR:
			MatManager.get_interstellars(1)
			set_build(GameEnums.Builds.NONE)
		GameEnums.Builds.FIGHTER:
			MatManager.get_fighters(1)
			set_build(GameEnums.Builds.NONE)
		GameEnums.Builds.LEGS:
			MatManager.get_mech_legs()
			set_build(GameEnums.Builds.NONE)
		GameEnums.Builds.ARMS:
			MatManager.get_mech_arms()
			set_build(GameEnums.Builds.NONE)
		GameEnums.Builds.V_FIN:
			MatManager.get_mech_fin()
			set_build(GameEnums.Builds.NONE)
	builder_counter = 0
	
func set_build(set_build: GameEnums.Builds) -> void:
	build = set_build
	#if(build == GameEnums.Builds.SHIP):
		#build_length = ship_build_length
	#elif(build == GameEnums.Builds.INTERSTELLAR):
		#build_length = interstellar_build_length
	#elif(build == GameEnums.Builds.FIGHTER):
		#build_length = fighter_build_length
	match build:
		GameEnums.Builds.SHIP:
			build_length = ship_build_length
		GameEnums.Builds.INTERSTELLAR:
			build_length = interstellar_build_length
		GameEnums.Builds.FIGHTER:
			build_length = fighter_build_length
		GameEnums.Builds.LEGS:
			build_length = mech_legs_build_length
		GameEnums.Builds.ARMS:
			build_length = mech_arms_build_length
		GameEnums.Builds.V_FIN:
			build_length = mech_fin_build_length
			
func cancel_build() -> void:
	build = GameEnums.Builds.NONE
	builder_counter = 0

func get_build_progress() -> float:
	if(build == GameEnums.Builds.NONE):
		return 0
	return float(builder_counter)/build_length
func process_turn() -> void:
	process_material()
	process_population()
	process_build()
