extends Node2D

var cardSlots = []
var slottedCards = []
var comboText

const FIRE = "fire"
const FEAR = "fear"
const ICE = "ice"
const THUNDER = "thunder"
const KING = "king"
const QUEEN = "queen"
const JACK = "jack"
const ACE = "ace"

func _ready() -> void:
		cardSlots = [$CardSlot, $CardSlot2, $CardSlot3, $CardSlot4, $CardSlot5]
		comboText = $"../comboText"

func slotCard(card, cardSlot):
		cardSlot.card_in_slot = card
		showCombo()
		
func deslotACard(card, cardSlot):
		cardSlot.card_in_slot = false
		#slottedCards.remove(card)
		showCombo()
		
		
func showCombo():
	for i in range(cardSlots.size()):
		if cardSlots[i].card_in_slot:
			slottedCards.append([cardSlots[i].card_in_slot.cardProps.element, cardSlots[i].card_in_slot.cardProps.value])
	
	var combo = evaluate_hand(slottedCards)
	if combo:
		show_text(combo, Vector2(950, 600))
	else:
		fadeOutText()
	
func show_text(text, position):
	
	comboText.bbcode_enabled = true
	comboText.autowrap_mode = TextServer.AUTOWRAP_OFF
	comboText.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	get_tree().current_scene.add_child(comboText)
	comboText.show_text("[center]"+text+"[/center]", Vector2(950, 600))  # Set text and make it visible
	
func fadeOutText():
	comboText.fade_out()
	
func evaluate_hand(equipped_cards: Array) -> String:
	# Store counts for suits and values
	var suit_counts = { "fire": 0, "ice": 0, "thunder": 0, "fear": 0 }
	var value_counts = {}  # Dictionary to store counts of values
	
	# Populate counts
	for card in equipped_cards:
		var suit = card[0]   # First element is suit
		var value = card[1]  # Second element is value
		
		# Count suits
		if suit in suit_counts:
			suit_counts[suit] += 1
		
		# Count values
		if value in value_counts:
			value_counts[value] += 1
		else:
			value_counts[value] = 1
	
	# Sort values to check for straights
	var sorted_values = value_counts.keys()
	sorted_values.sort_custom(func(a, b): return card_value(a) < card_value(b))
	
	# Check for Flush (all cards same suit)
	var flush_suit = null
	for suit in suit_counts.keys():
		if suit_counts[suit] == 5:
			flush_suit = suit
			break
	
	# Check for Straight
	var is_straight = sorted_values.size() == 5 and (card_value(sorted_values[4]) - card_value(sorted_values[0]) == 4)

	# Check for Royal Flush (Ace-high Straight Flush)
	if flush_suit and is_straight and "ace" in sorted_values:
		return "Royal Flush"

	# Check for Straight Flush (Straight + Flush)
	if flush_suit and is_straight:
		return "Straight Flush"

	# Check for Four of a Kind
	for value in value_counts:
		if value_counts[value] == 4:
			return "Four of a Kind"

	# Check for Full House (Three of a Kind + Pair)
	var three_of_a_kind = false
	var has_pair = false
	for value in value_counts:
		if value_counts[value] == 3:
			three_of_a_kind = true
		if value_counts[value] == 2:
			has_pair = true
	if three_of_a_kind and has_pair:
		return "Full House"

	# Check for Flush
	if flush_suit:
		return "Flush"

	# Check for Straight
	if is_straight:
		return "Straight"

	# Check for Three of a Kind
	for value in value_counts:
		if value_counts[value] == 3:
			return "Three of a Kind"

	# Check for Two Pair
	var pair_count = 0
	for value in value_counts:
		if value_counts[value] == 2:
			pair_count += 1
	if pair_count == 2:
		return "Two Pair"

	# Check for One Pair
	if pair_count == 1:
		return "One Pair"

	if(sorted_values):
		return "High Card: " + str(sorted_values[-1])
	return ""
	

# Helper function to convert card values to numerical ranking
func card_value(card_rank: String) -> int:
	var values = {
		"two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9,
		"ten": 10, "jack": 11, "queen": 12, "king": 13, "ace": 14
	}
	return values.get(card_rank, 0)  # Default to 0 if not found
