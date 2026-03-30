extends Resource
class_name PlanetData 

enum control {
	Neutral, 
	Alien , 
	Human
}

@export var planet_name: String = "Unknown"
@export var controlled_by: control = control.Neutral
@export var population: int = 0
@export var tech: int = 0
@export var hope: int = 0
@export var sprite_frames: SpriteFrames
