extends Node2D

var card_being_dragged
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x),
		 clamp(mouse_pos.y, 0, screen_size.y))

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			var card = raycast_check_for_card()
			if card:
				card_being_dragged = card 
				
		else:
			card_being_dragged = null
			
func raycast_check_for_card():
		var space_state = get_world_2d().direct_space_state
		var parameters = PhysicsPointQueryParameters2D.new()
		parameters.position = get_global_mouse_position()
		parameters.collide_with_areas = true
		parameters.collision_mask = 1
		var result = space_state.intersect_point(parameters)
		return result[0].collider.get_parent()
