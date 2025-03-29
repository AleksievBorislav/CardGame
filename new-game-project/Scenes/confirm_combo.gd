extends Button

var slotsReference

func _ready() -> void:
	self.connect("pressed", _on_Button_pressed)
	slotsReference = $"../SlotsManager"

func _on_Button_pressed():
	print(slotsReference.slottedCards.size())
