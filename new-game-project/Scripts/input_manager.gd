extends Node2D

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_DECK = 4

var cardManagerReference
var deckReference

signal leftClick
signal leftRelease

func _ready() -> void:
	cardManagerReference = $"../CardManager"
	deckReference = $"../Deck"

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			emit_signal("leftClick")
			raycastAtCursor()
		else:
			emit_signal("leftRelease")


func raycastAtCursor():
		var space_state = get_world_2d().direct_space_state
		var parameters = PhysicsPointQueryParameters2D.new()
		parameters.position = get_global_mouse_position()
		parameters.collide_with_areas = true
		var result = space_state.intersect_point(parameters)
		if result.size() > 0:
			var resultCollisionMask = result[0].collider.collision_mask
			if resultCollisionMask == COLLISION_MASK_CARD:
				var cardFound = result[0].collider.get_parent()
				if cardFound:
					cardManagerReference.start_drag(cardFound)
			elif resultCollisionMask == COLLISION_MASK_DECK:
				deckReference.drawCard()
