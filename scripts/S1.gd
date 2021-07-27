extends Tetro

func _init(i, j, color):
	self.Points = [
		{"i": i, "j": j},
		{"i": i, "j": j+1},
		{"i": i+1, "j": j+1},
		{"i": i+1, "j": j+2},
	]
	self.color = color
