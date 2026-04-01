extends Node2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left_click"):
		mouse_click_at()

func mouse_click_at() -> void:
	print("click")
	var space_state = get_world_2d().direct_space_state;
	var mouse_pos = get_global_mouse_position();
	
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mouse_pos
	query.collide_with_areas = true
	#query.collision_mask = 2
	
	var result = space_state.intersect_point(query)
	
	if result:
		#var planet = result[0].collider as Planet
		#planet.handle_click()
		var clicked = result[0].collider
		if(clicked.has_method("handle_click")):
			clicked.handle_click()
