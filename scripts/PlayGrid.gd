extends GridContainer

export(int) var square_size = 40

const single_square = preload("res://scenes/SingleSquare.tscn")
const Square_tetro = preload("res://scripts/Square.gd")

var grid_matrix = Array()
var current_tetro

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
	var r = createGrid(
		self.rect_size.x, 
		self.rect_size.y)
	clear()
	current_tetro = Square_tetro.new(0, 0, r["w"], r["h"], Color.aqua)
	paint_tetro(current_tetro)
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
	return {"w": w_amount, "h": h_amount}

func clear():
	for a in grid_matrix:
		for n in a:
			n.clear()

func paint_point(i, j):
	grid_matrix[i][j].color = Color.aqua

func _on_Timer_timeout():
	clear_tetro(current_tetro)
	current_tetro.down()
	paint_tetro(current_tetro)

func clear_tetro(tetro):
	for p in tetro.Points:
		grid_matrix[p["i"]][p["j"]].clear()

func paint_tetro(tetro):
	for p in tetro.Points:
		grid_matrix[p["i"]][p["j"]].color = tetro.color
