extends Node2D

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_CARD_SLOT = 2

var card_being_dragged
var screen_size
var is_hovering_on_card
var card_hovered_scale = Vector2(1.1, 1.1)
var card_normal_scale = Vector2(1, 1)
var playerHandReference
var slotsmanagerReference

signal pickedACardInSlot
signal removedACardFromSlot


										#Setup
func _ready() -> void:
	playerHandReference = $"../PlayerHand"
	slotsmanagerReference = $"../SlotsManager"
	screen_size = get_viewport_rect().size
	$"../InputManager".connect("leftRelease", onLeftRelease)

func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x),
		 clamp(mouse_pos.y, 0, screen_size.y))
		
		
func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off_over_card)
	
										#Drag logic
			
func start_drag(card):
	var card_slot_found = raycast_check_for_card_slot()
	if card_slot_found :
			slotsmanagerReference.deslotACard(card, card_slot_found)
	card_being_dragged = card
	
func finish_drag():
	var card_slot_found = raycast_check_for_card_slot()
	if card_slot_found and not card_slot_found.card_in_slot:
		if card_being_dragged:
			playerHandReference.removeCardFromHand(card_being_dragged)
			card_being_dragged.position = card_slot_found.position
			card_being_dragged.scale = card_normal_scale
			card_slot_found.card_in_slot = card_being_dragged;
			slotsmanagerReference.slotCard(card_being_dragged, card_slot_found)
	else:
		if(card_being_dragged):
			playerHandReference.addCardToHand(card_being_dragged)
	card_being_dragged = null
	
func onLeftRelease():
	if card_being_dragged:
		finish_drag()	

												#Hover logic
func on_hovered_over_card(card):
	if !is_hovering_on_card:
		is_hovering_on_card = true
		highlight_card(card, true)

func on_hovered_off_over_card(card):
	highlight_card(card, false)
	var new_card_hovered = raycast_check_for_card()
	if new_card_hovered:
		highlight_card(new_card_hovered, true)
		
	else: 
		is_hovering_on_card = false
	
	
func highlight_card(card, hovered):
	if hovered and not raycast_check_for_card_slot():
		card.scale = card_hovered_scale
		card.z_index = 2;
	else:
		card.scale = card_normal_scale
		card.z_index = 1
												#Raycasts
func raycast_check_for_card_slot():
		var space_state = get_world_2d().direct_space_state
		var parameters = PhysicsPointQueryParameters2D.new()
		parameters.position = get_global_mouse_position()
		parameters.collide_with_areas = true
		parameters.collision_mask = COLLISION_MASK_CARD_SLOT
		var result = space_state.intersect_point(parameters)
		if result:
			return result[0].collider.get_parent()
		else:
			return null			

			
func raycast_check_for_card():
		var space_state = get_world_2d().direct_space_state
		var parameters = PhysicsPointQueryParameters2D.new()
		parameters.position = get_global_mouse_position()
		parameters.collide_with_areas = true
		parameters.collision_mask = COLLISION_MASK_CARD
		var result = space_state.intersect_point(parameters)
		if result.size() > 0:
			return get_highest_z_index_card(result)
		else:
			return null
			
func get_highest_z_index_card(cards):
	if (cards):
		var z_card = cards[0].collider.get_parent()
		var z_index = z_card.z_index
		
		for i in range(1, cards.size()):
			var current_card = cards[i].collider.get_parent()
			if (current_card.z_index > z_index):
				z_card = current_card
				z_index = current_card.z_index
		return z_card
	else:
		return null
