extends Node2D
const CARD_SCENE_PATH = "res://Scenes/card.tscn"
var playerDeck = ["Winged dragon of Ra", "Osyris the sky dragon", "Obelisk the tormentor", "Black sage", "Black magician girl", "Dark Paladin",
 "Summoning skull", "Blue eyes white dragon", "Flaming swordsman", "Monster reborn", "Polymerisation",
"BATMAN NA KON", "Magician of Black Chaos", "Dragon master knight", "Right hand of the forbidden one",
 "Left leg of the forbidden one", "Right leg of the forbidden one",
"EXODIA THE FORBIDDEN ONE"]
var cardDatabaseReference
var handRef

func _ready() -> void:
	playerDeck.shuffle()
	cardDatabaseReference = preload("res://Scripts/CardDatabase.gd")
	handRef = $"../PlayerHand"

func drawCard():
	if handRef.cardsInHand < handRef.maxCardsInHand:
		var card_drawn = playerDeck[0]
		playerDeck.erase(card_drawn)
	
		if playerDeck.size() == 0:
			$Area2D/CollisionShape2D.disabled = true
			$Sprite2D.visible = false
	
		var cardScene = preload(CARD_SCENE_PATH)
		var newCard = cardScene.instantiate()
		var cardImagePath = str("res://Assets/" + card_drawn + ".jpg")			
		var sprite = newCard.get_node("card image")
		sprite.texture = load(cardImagePath)
		newCard.get_node("card image").texture = load(cardImagePath)
		newCard.get_node("element").text = str(cardDatabaseReference.CARDS[card_drawn][0])
		newCard.get_node("value").text = str(cardDatabaseReference.CARDS[card_drawn][1])
		$"../CardManager".add_child(newCard)
		newCard.name = "Card"
		handRef.addCardToHand(newCard)
		newCard.get_node("AnimationPlayer").play("card_flip")
		
