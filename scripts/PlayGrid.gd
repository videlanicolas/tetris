extends GridContainer

export(int) var square_size = 40

const single_square = preload("res://scenes/SingleSquare.tscn")
const Square_tetro = preload("res://scripts/Square.gd")

var grid_matrix = Array()
var current_tetro
var LimitY: int
var LimitX: int

enum Shapes {
	L1,
	L2,
	S1,
	S2,
	SQUARE,
	LINE = -1
}

# Called when the node enters the scene tree for the first time.
func _ready():
	createGrid(
		self.rect_size.x, 
		self.rect_size.y)
	clear()
	current_tetro = Square_tetro.new(10, 0, Color.aqua)
	paint_current_tetro()
	$Timer.start()

func createGrid(width, height):
	# Calculate the amount of squares.
	var w_amount = int(width / square_size)
	var h_amount = int(height / square_size)
	
	self.columns = w_amount
	for _i in range(h_amount):
		var tmp_array = Array()
		for _j in range(w_amount):
			var inst = single_square.instance()
			add_child(inst)
			tmp_array.append(inst)
		grid_matrix.append(tmp_array)
	LimitX = w_amount
	LimitY = h_amount

func clear():
	for a in grid_matrix:
		for n in a:
			n.clear()

func paint_point(i, j):
	grid_matrix[i][j].color = Color.aqua

func _on_Timer_timeout():
	if current_tetro:
		if not check_current_tetro_bounds():
			current_tetro = null
			return
		clear_current_tetro()
		current_tetro.down()
		paint_current_tetro()

func check_current_tetro_bounds():
	for p in current_tetro.Points:
		if p.i >= (LimitY - 1):
			return false
	return true

func clear_current_tetro():
	for p in current_tetro.Points:
		grid_matrix[p["i"]][p["j"]].clear()

func paint_current_tetro():
	for p in current_tetro.Points:
		grid_matrix[p["i"]][p["j"]].color = current_tetro.color
