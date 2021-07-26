extends GridContainer

var single_square = preload("res://scenes/SingleSquare.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	createGrid(self.rect_size.x, self.rect_size.y, 40)

# Create a grid on the container.
func createGrid(width, height, maximum_square_size):
	# Calculate the amount of squares.
	var w_amount = int(width / maximum_square_size)
	var h_amount = int(height / maximum_square_size)
	
	# Debug output.
	print(w_amount)
	print(h_amount)
	
	self.columns = w_amount
	for _i in range(w_amount):
		for _j in range(h_amount):
			add_child(single_square.instance())
	
