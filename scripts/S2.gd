extends Tetro

func _init(i, j, color):
	self.Points = [
		{"i": i, "j": j},
		{"i": i, "j": j+1},
		{"i": i+1, "j": j},
		{"i": i+1, "j": j-1},
	]
	self.color = color
