extends Node2D


@export var population: int = 0
@export var tech: int = 0
@export var hope: int = 0
@export var mats: int = 0
@export var suns: int = 0
@export var heavy: int = 0
@export var lich: int = 0
@export var ships: int = 5
@export var interstellars: int = 5
@export var fighters: int = 0  

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
