extends RichTextLabel

func _ready():
	modulate = Color(1, 1, 1, 0)  # Start fully transparent

func show_text(text, position):
	self.text = text
	self.position = position
	modulate = Color(1, 1, 1, 1)  # Make visible

func fade_out():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 1)  # Fade out over 1s
	await tween.finished
