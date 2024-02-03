extends TileMap

const tilemap_x = 80
const tilemap_y = 43
const radius_big := 16
const offset = 4
var enemy_list = []


func _ready():
	# tilemap uof
	# for i in range(get_viewport().size.x):
	# 	for j in range(get_viewport().size.y):
	# 		if get_cell_source_id(0, Vector2i(i, j)) != -1:
	# 			print(get_cell_atlas_coords(0, Vector2i(i, j)))

	# draw full background
	# for i in range(tilemap_x):
	# 	for j in range(tilemap_y):
	# 		set_cell(0, Vector2i(i, j), 0, Vector2i(0, 0))

	# draw circle
	# set_cell(0, center, 0, Vector2i(0, 0))
	enemy_generator()

	# for enemy in enemy_list:
	# 	set_cell(0, enemy, 0, Vector2i(0, 0))


func draw_side(dir_x, dir_y, rad, offset):
	var x = rad
	var y = 0
	var P = 1 - rad
	set_cell(0, Vector2i(dir_x * x + offset, dir_y * y), 0, Vector2i(0, 0))
	while x > y:
		y += 1
		if P <= 0:
			P = P + 2 * y + 1
		else:
			x -= 1
			P = P + 2 * y - 2 * x + 1
		set_cell(0, Vector2i(dir_x * x + offset, dir_y * y), 0, Vector2i(0, 0))
	while abs(x) > 0:
		if x > 0:
			x -= 1
		else:
			x += 1
		set_cell(0, Vector2i(dir_x * x + offset, dir_y * y), 0, Vector2i(0, 0))


func enemy_generator():
	for i in range(0, 5):
		draw_side(1, -1, radius_big - 4 * i, 0)
		draw_side(1, 1, radius_big - 4 * i, 0)
		draw_side(-1, -1, radius_big - 4 * i, 0)
		draw_side(-1, 1, radius_big - 4 * i, 0)

	for i in range(0, 7):
		draw_side(1, -1, radius_big, offset * i)
		draw_side(1, 1, radius_big, offset * i)
		draw_side(-1, -1, radius_big, -offset * i)
		draw_side(-1, 1, radius_big, -offset * i)
