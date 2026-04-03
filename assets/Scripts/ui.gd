extends Node

@onready var turn_button = $Button
@onready var exit_button = $Exit
@onready var turn_lbl = $TurnLbl
@onready var population_lbl = $PopLbl
@onready var mats_lbl = $MatsLbl
@onready var heavy_lbl = $HeavyLbl
@onready var suns_lbl = $SunsLbl
@onready var lich_lbl = $LichLbl
@onready var ships_lbl = $Ships
@onready var interstellar_lbl = $InterstellarLbl
@onready var fighters_lbl = $FightersLbl

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turn_button.pressed.connect(_on_turn_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	turn_lbl.text = "TURN " + str(TurnManager.turnCount)
	population_lbl.text = "POPULATION " + str(TurnManager.overrall_population)
	mats_lbl.text = "MATS " + str(MatManager.mats)
	heavy_lbl.text = "HEAVY " + str(MatManager.heavy)
	suns_lbl.text = "SUNS " + str(MatManager.suns)
	lich_lbl.text = "LICH " + str(MatManager.lich)
	ships_lbl.text = "SHIPS " + str(MatManager.ships)
	interstellar_lbl.text = "INTERSTELLARS "+str(MatManager.interstellars)
	fighters_lbl.text = "FIGHTERS "+str(MatManager.fighters)
	pass

func _on_turn_pressed() -> void:
	TurnManager.process_turn()

func _on_exit_pressed() -> void:
	TurnManager.go_to_galaxy_map()
