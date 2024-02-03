extends Line2D

var queue := []
const length := 12


func _process(delta):
	global_position = Vector2(0, 0)
	var point = get_parent().global_position
	queue.push_front(point)
	if len(queue) > length:
		queue.pop_back()

	clear_points()
	for pnt in queue:
		add_point(pnt)
