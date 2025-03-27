extends Node2D
const CARD_SCENE_PATH = "res://Scenes/card.tscn"
var playerDeck = []
var cardDatabaseReference
var handRef

# Paths to mini images for elements and values
const ELEMENT_ICONS = {
	"fire": preload("res://Assets/mini icons/miniFire.jpg"),
	"fear": preload("res://Assets/mini icons/fear.jpeg"),
	"ice": preload("res://Assets/mini icons/ice.jpg"),
	"thunder": preload("res://Assets/mini icons/thunder.jpg")
}


const VALUE_ICONS = {
	"ace": preload("res://Assets/mini icons/ace.jpg"),
	"king": preload("res://Assets/mini icons/king.png"),
	"queen": preload("res://Assets/mini icons/queen.jpg"),
	"jack": preload("res://Assets/mini icons/jack.jpg"),
	"ten": preload("res://Assets/mini icons/10.jpeg"),
	"nine": preload("res://Assets/mini icons/9.png"),
	"eight": preload("res://Assets/mini icons/8.png"),
	"seven": preload("res://Assets/mini icons/7.png"),
	"six": preload("res://Assets/mini icons/6.png"),
	"five": preload("res://Assets/mini icons/5.png"),
	"four": preload("res://Assets/mini icons/4.png"),
	"three": preload("res://Assets/mini icons/3.png"),
	"two": preload("res://Assets/mini icons/2.jpg")
}

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

			# Set mini images
		var element_icon = newCard.get_node("elementIcon")
		var value_icon = newCard.get_node("valueIcon")
		
		
		if card_drawn.element in ELEMENT_ICONS:
			element_icon.texture = ELEMENT_ICONS[card_drawn.element]
			
		if card_drawn.value in VALUE_ICONS:
			value_icon.texture = VALUE_ICONS[card_drawn.value]
		
		$"../CardManager".add_child(newCard)
		newCard.name = "Card"
		newCard.cardProps = card_drawn
		handRef.addCardToHand(newCard)
		newCard.get_node("AnimationPlayer").play("card_flip")
		
