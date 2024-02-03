extends StaticBody2D
const VALUES = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]

const colors = {0: "ff0000", 1: "00ff00", 2: "0000ff", "goal": "e8b923"}

@export var ball_reference: PackedScene


func _ready():
	# rainbow enemy uwu
	# var color_string = ""
	# for i in range(6):
	# 	var rand_color = VALUES.pick_random()
	# 	color_string += rand_color
	var rand_nr = randi_range(0, 10)
	if rand_nr in colors:
		modulate = colors[rand_nr]

	var layout = get_tree().get_first_node_in_group("layout1")
	if global_position == layout.global_position + Vector2(8, 8):
		modulate = colors["goal"]


func spawn_ball():
	var new_ball = ball_reference.instantiate() as Node2D
	var ball = get_tree().get_first_node_in_group("ball")
	if new_ball:
		get_parent().add_child(new_ball)
		new_ball.global_position = global_position


func kill_neighbours():
	for i in range(8):
		var temp_node = create_ray_cast(45 * i)
		if temp_node.is_colliding():
			temp_node.get_collider().queue_free()
			temp_node.queue_free()


func create_ray_cast(angle):
	var node = RayCast2D.new()
	add_child(node)
	node.rotate(deg_to_rad(angle))
	node.collision_mask = 2
	node.force_raycast_update()
	return node


func big_boy():
	var player = get_tree().get_first_node_in_group("player")
	var new_area = StaticBody2D.new()
	var form = ColorRect.new()
	var new_shape = CollisionShape2D.new()
	form.size.x = get_viewport().size.x
	form.size.y = 24
	form.global_position = Vector2(0, 576)
	new_area.collision_mask = 1
	new_area.add_child(form)
	new_area.add_child(new_shape)
	new_shape.shape = RectangleShape2D.new()
	new_shape.shape.size.x = 20
	new_shape.shape.size.y = 640 * 2
	new_shape.global_position = Vector2(640, 576)
	new_shape.rotate(deg_to_rad(90))
	get_parent().owner.add_child(new_area)


func win():
	print("You've win!")
	get_tree().change_scene_to_file("res://UI/ui.tscn")
