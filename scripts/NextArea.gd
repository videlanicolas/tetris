extends GridContainer

export(int) var square_size = 40

const single_square = preload("res://scenes/SingleSquare.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	createGrid(
		self.rect_size.x,
		self.rect_size.y)

func createGrid(width, height):
	# Calculate the amount of squares.
	var w_amount = int(width / square_size)
	var h_amount = int(height / square_size)
	
	self.columns = w_amount
	for _i in range(w_amount):
		for _j in range(h_amount):
			add_child(single_square.instance())
