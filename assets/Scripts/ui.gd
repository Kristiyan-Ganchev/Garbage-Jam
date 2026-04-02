extends Node

@onready var turn_button = $Button
@onready var exit_button = $Exit
@onready var turn_lbl = $TurnLbl
@onready var population_lbl = $PopLbl
@onready var mats_lbl = $MatsLbl
@onready var ships_lbl = $Ships

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turn_button.pressed.connect(_on_turn_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	turn_lbl.text = "TURN " + str(TurnManager.turnCount)
	population_lbl.text = "POPULATION " + str(TurnManager.overrall_population)
	mats_lbl.text = "MATS " + str(MatManager.mats)
	ships_lbl.text = "SHIPS " + str(MatManager.ships)
	pass

func _on_turn_pressed() -> void:
	TurnManager.process_turn()

func _on_exit_pressed() -> void:
	print(1)
	TurnManager.go_to_galaxy_map()
