extends Resource
class_name SystemData 


@export var system_name: String = "Unknown"
@export var controlled_by: GameEnums.ControlledBy = GameEnums.ControlledBy.NEUTRAL
@export var population: int = 0
@export var tech: int = 0
@export var hope: int = 0
@export var sprite_frames: SpriteFrames
@export var scene: PackedScene = null
