extends Node

var ui_screens = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	var ui_root = get_node("/root/Ui")
	if ui_root:
		for child in ui_root.get_children():
			ui_screens[child.name] = child
			child.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func wipe_ui() -> void:
	for ui in ui_screens:
		ui_screens[ui].visible = false

func enable_ui(ui:GameEnums.UIs) -> void:			
		match ui:
			GameEnums.UIs.BUILD:
				wipe_ui()
				ui_screens["BuildUi"].visible = true
			GameEnums.UIs.TURN:
				wipe_ui()
				ui_screens["TurnUi"].visible = true
			GameEnums.UIs.SHMUP:
				wipe_ui()
				ui_screens["ShmupUi"].visible = true
		if TurnManager.currentElement && TurnManager.currentElement is Planet:
			var planet = TurnManager.currentElement as Planet
			planet.wipe_planet_ui()

func change_hp(amount:int) -> void:
	ui_screens["ShmupUi"].change_hp(amount)

func change_lives(amount:int) ->void:
	ui_screens["ShmupUi"].change_lives(amount)
	
func update_mech() -> void:
	ui_screens["TurnUi"].update_mech()
	
func eyecatch() -> void:
	ui_screens["TurnUi"].eyectch()
	
func play_cutscene() -> void:
	ui_screens["Cutscene"].play_cutscene()
