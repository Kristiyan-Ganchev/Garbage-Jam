extends Node2D


@export var population: int = 0
@export var tech: int = 0
@export var hope: int = 0
@export var mats: int = 0
@export var suns: int = 0
@export var heavy: int = 0
@export var lich: int = 0

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
