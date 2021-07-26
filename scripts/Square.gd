extends Tetro

func _init(i, j, limit_x, limit_y, color):
	self.Points = [
		{"i": i, "j": j},
		{"i": i, "j": j+1},
		{"i": i+1, "j": j},
		{"i": i+1, "j": j+1},
	]
	self.color = color
	self.LimitX = limit_x
	self.LimitY = limit_y
