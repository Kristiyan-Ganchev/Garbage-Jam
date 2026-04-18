extends Area2D

func _on_mouse_entered():
	if MatManager.mech_legs && MatManager.mech_arms && MatManager.mech_v_fin:
		$Mech.set_instance_shader_parameter("active", true)

func _on_mouse_exited():
	$Mech.set_instance_shader_parameter("active", false)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
