extends ColorRect

const TRANSPARENT = Color(0, 0, 0, 0)

func _ready():
	clear()

func clear():
	self.color = TRANSPARENT

func occupied():
	return self.color != TRANSPARENT
