extends Resource
class_name PlanetData 


@export var planet_name: String = "Unknown"
@export var controlled_by: GameEnums.ControlledBy = GameEnums.ControlledBy.NEUTRAL
@export var population: int = 0
@export var tech: int = 0
@export var hope: int = 0
@export var sprite_frames: SpriteFrames
@export var mat_type: GameEnums.Mats = GameEnums.Mats.MATS
@export var mat_growth: int = 0
