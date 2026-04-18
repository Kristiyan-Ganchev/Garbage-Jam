extends Control



@onready var lives_lbl = $LivesLbl
@onready var hp = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_hp(3)
	change_lives(MatManager.fighters)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func change_hp(amount: int) -> void:
	hp.frame = amount

func change_lives(amount: int) -> void:
	lives_lbl.text = "X"+str(amount)
