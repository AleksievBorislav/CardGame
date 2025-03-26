extends Node2D

var playerHandList = []
var centerScreenX
const CARD_WIDTH = 120
const HAND_Y_POSITION = 960
var cardsInHand = 0
var maxCardsInHand = 8

func _ready() -> void:
	centerScreenX = get_viewport().size.x / 2
		
func addCardToHand(card):
	if card not in playerHandList:
		playerHandList.insert(0, card)
		updateHandPositions()
	else:
		animateCardToPosition(card, card.positionInHand)
	cardsInHand = cardsInHand + 1
		
func updateHandPositions():
	for i in range(playerHandList.size()):
		var newPosition = Vector2(calculateCardXPosition(i), HAND_Y_POSITION)
		var card = playerHandList[i]
		card.positionInHand = newPosition
		animateCardToPosition(card, newPosition)
		
		
func calculateCardXPosition(index):
	var totalWidh = (playerHandList.size() - 1) * CARD_WIDTH
	var xOffset = centerScreenX + index * CARD_WIDTH - totalWidh / 2
	return xOffset
	
func animateCardToPosition(card, newPosition):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", newPosition, 0.2)
	
	
func removeCardFromHand(card):
	if card in playerHandList:
		playerHandList.erase(card)
		updateHandPositions()
		cardsInHand = cardsInHand - 1

		
	
