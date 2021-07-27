extends GridContainer

export(int) var square_size = 40

const single_square = preload("res://scenes/SingleSquare.tscn")
const Square_tetro = preload("res://scripts/Square.gd")
const Line_tetro = preload("res://scripts/Line.gd")
const L1_tetro = preload("res://scripts/L1.gd")
const L2_tetro = preload("res://scripts/L2.gd")
const S1_tetro = preload("res://scripts/S1.gd")
const S2_tetro = preload("res://scripts/S2.gd")

var grid_matrix = Array()
var current_tetro
var LimitY: int
var LimitX: int

enum Mode {
	SHOW,
	PLAY = -1
}
export(Mode) var mode

enum TetroEnum {
	L1,
	L2,
	S1,
	S2,
	LINE,
	SQUARE,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	createGrid(
		self.rect_size.x, 
		self.rect_size.y)
	clear()
	current_tetro = null
	if mode == Mode.PLAY:
		$WaitTimer.start()

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
			$Timer.stop()
			$WaitTimer.start()
			return
		clear_current_tetro()
		current_tetro.down()
		paint_current_tetro()

func drop_new_tetro(spawn_tetro):
	match spawn_tetro:
		TetroEnum.SQUARE:
			current_tetro = Square_tetro.new(0, int(LimitX/2.0), Color.aqua)
		TetroEnum.LINE:
			current_tetro = Line_tetro.new(0, int(LimitX/2.0), Color.brown)
		TetroEnum.L1:
			current_tetro = L1_tetro.new(0, int(LimitX/2.0), Color.cornsilk)
		TetroEnum.L2:
			current_tetro = L2_tetro.new(0, int(LimitX/2.0), Color.chartreuse)
		TetroEnum.S1:
			current_tetro = S1_tetro.new(0, int(LimitX/2.0), Color.darkgreen)
		TetroEnum.S2:
			current_tetro = S2_tetro.new(0, int(LimitX/2.0), Color.blueviolet)
	paint_current_tetro()
	$Timer.start()

func check_current_tetro_bounds():
	for p in current_tetro.Points:
		# Check if we are at the bottom.
		if p.i + 1 >= LimitY:
			return false
		# Check if we are on top of a tetro.
		if grid_matrix[p.i + 1][p.j].occupied():
			# Check if the overlapping square does not belong to the current tetro.
			if not current_tetro.square_belongs(p.i + 1, p.j):
				return false
	return true

func clear_current_tetro():
	for p in current_tetro.Points:
		grid_matrix[p["i"]][p["j"]].clear()

func paint_current_tetro():
	for p in current_tetro.Points:
		grid_matrix[p["i"]][p["j"]].color = current_tetro.color

func _on_WaitTimer_timeout():
	drop_new_tetro(TetroEnum.values()[randi() % TetroEnum.values().size()])
	$Timer.start()
