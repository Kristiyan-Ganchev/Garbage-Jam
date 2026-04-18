extends Node2D


@export var population: int = 0
@export var tech: int = 0
@export var hope: int = 0
@export var mats: int = 1
@export var suns: int = 0
@export var heavy: int = 0
@export var lich: int = 0
@export var ships: int = 1
@export var interstellars: int = 0
@export var fighters: int = 0
@export var mech_legs: bool = true
@export var mech_arms: bool = true
@export var mech_v_fin: bool = true

func grow_mats(mat_type: GameEnums.Mats,amount: int) -> void:
	match mat_type:
		GameEnums.Mats.MATS:
			mats+= amount
		GameEnums.Mats.SUNS:
			suns+= amount
		GameEnums.Mats.HEAVY:
			heavy+= amount
		GameEnums.Mats.LICH:
			lich+= amount
	pass

func can_build(build: GameEnums.Builds)-> bool:
	match build:
		GameEnums.Builds.SHIP:
			if(mats >= 3):
				return true
		GameEnums.Builds.INTERSTELLAR:
			if(mats >= 5 && heavy >=2):
				return true
		GameEnums.Builds.FIGHTER:
			if(mats >= 3):
				return true
		GameEnums.Builds.LEGS:
			if(mats >= 20 && heavy >=10) && mech_legs == false:
				return true
		GameEnums.Builds.ARMS:
			if(mats >= 30 && heavy >=20 && suns >=5) && mech_arms == false:
				return true
		GameEnums.Builds.V_FIN:
			if(mats >= 30 && heavy >=20 && suns >=5 && lich >=3) && mech_v_fin == false:
				return true
	return false

func get_ships(num:int) -> void:
	mats -=3
	ships +=num

func get_interstellars(num:int) -> void:
	mats -=5
	heavy -=2
	interstellars +=num
	
func get_fighters(num:int) -> void:
	mats -=3
	fighters +=num

func get_mech_legs() -> void:
	if mech_legs:
		return
	mech_legs = true
	mats -=20
	heavy -=10
	UiManager.update_mech()

func get_mech_arms() -> void:
	if mech_arms:
		return
	mech_arms = true
	mats -=30
	heavy -=20
	suns -= 5
	UiManager.update_mech()
	
func get_mech_fin() -> void:
	if mech_v_fin:
		return
	mech_v_fin = true
	mats -=30
	heavy -=20
	suns -= 5
	lich -= 3
	UiManager.update_mech()
