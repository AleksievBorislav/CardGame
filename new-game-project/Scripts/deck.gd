extends Node2D
const CARD_SCENE_PATH = "res://Scenes/card.tscn"
var playerDeck = []
var cardDatabaseReference
var handRef

func _ready() -> void:
	cardDatabaseReference = preload("res://Scripts/CardDatabase.gd")
	handRef = $"../PlayerHand"
	for card_name in cardDatabaseReference.CARDS.keys():
		playerDeck.append({ 
			"name": card_name, 
			"element": cardDatabaseReference.CARDS[card_name][0], 
			"value": cardDatabaseReference.CARDS[card_name][1] 
		})

	playerDeck.shuffle()  # Shuffle the deck


func drawCard():
	if handRef.cardsInHand < handRef.maxCardsInHand:
		var card_drawn = playerDeck[0]
		playerDeck.erase(card_drawn)
	
		if playerDeck.size() == 0:
			$Area2D/CollisionShape2D.disabled = true
			$Sprite2D.visible = false
	
		var cardScene = preload(CARD_SCENE_PATH)
		var newCard = cardScene.instantiate()
		var cardImagePath = str("res://Assets/" + card_drawn.name + ".jpg")			
		var sprite = newCard.get_node("card image")
		sprite.texture = load(cardImagePath)
		newCard.get_node("card image").texture = load(cardImagePath)
		newCard.get_node("element").text = card_drawn.element
		newCard.get_node("value").text = card_drawn.value
		$"../CardManager".add_child(newCard)
		newCard.name = "Card"
		newCard.cardProps = card_drawn
		handRef.addCardToHand(newCard)
		newCard.get_node("AnimationPlayer").play("card_flip")
		
