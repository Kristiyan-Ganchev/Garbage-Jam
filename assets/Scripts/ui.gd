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
@onready var mech = $MechHitBox/Mech
@onready var launch = $MechHitBox/Mech/Launch

var launchable = false

func _ready() -> void:
	turn_button.pressed.connect(_on_turn_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	launch.pressed.connect(launch_mech)
	launch.disabled = true
	update_mech()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	turn_lbl.text = "TURN " + str(TurnManager.turnCount)
	population_lbl.text = "{ " + str(TurnManager.overrall_population)
	mats_lbl.text = "& " + str(MatManager.mats)
	heavy_lbl.text = "$ " + str(MatManager.heavy)
	suns_lbl.text = "% " + str(MatManager.suns)
	lich_lbl.text = "^ " + str(MatManager.lich)
	ships_lbl.text = "} " + str(MatManager.ships)
	interstellar_lbl.text = "@ "+str(MatManager.interstellars)
	fighters_lbl.text = "# "+str(MatManager.fighters)
	
	if launchable:
		launch.disabled = false
	

func _on_turn_pressed() -> void:
	TurnManager.process_turn()

func _on_exit_pressed() -> void:
	TurnManager.go_to_galaxy_map()
	
func update_mech() -> void:
	if !MatManager.mech_legs && !MatManager.mech_arms && !MatManager.mech_v_fin:
		mech.play("build")
		mech.frame = 7
		mech.pause()
	elif MatManager.mech_legs && !MatManager.mech_arms && !MatManager.mech_v_fin:
		mech.play("build")
		mech.frame = 6
		mech.pause()
	elif !MatManager.mech_legs && !MatManager.mech_arms && MatManager.mech_v_fin:
		mech.play("build")
		mech.frame = 5
		mech.pause()
	elif !MatManager.mech_legs && MatManager.mech_arms && !MatManager.mech_v_fin:
		mech.play("build")
		mech.frame = 2
		mech.pause()
	elif !MatManager.mech_legs && MatManager.mech_arms && MatManager.mech_v_fin:
		mech.play("build")
		mech.frame = 4
		mech.pause()
	elif MatManager.mech_legs && MatManager.mech_arms && !MatManager.mech_v_fin:
		mech.play("build")
		mech.frame = 3
		mech.pause()
	elif MatManager.mech_legs && !MatManager.mech_arms && MatManager.mech_v_fin:
		mech.play("build")
		mech.frame = 1
		mech.pause()
	elif MatManager.mech_legs && MatManager.mech_arms && MatManager.mech_v_fin:
		mech.play("build")
		mech.frame = 0
		mech.pause()
		launchable = true
		eyecatch()

func eyecatch() -> void:
	mech.play("eyecatch")
	
func launch_mech() -> void:
	UiManager.play_cutscene()
