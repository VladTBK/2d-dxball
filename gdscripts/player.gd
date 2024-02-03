extends StaticBody2D

var slide_factor = 10

@export var dx := 0
@export var score := 0


func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	# var shape = $bigboishape
	# var shape_center = shape.shape.size.y * 0.5
	# if shape.global_position.x <= shape_center:
	# 	global_position.x += 2
	# 	return
	# elif shape.global_position.x >= get_viewport().size.x - shape_center:
	# 	global_position.x -= 2
	# 	return
	var pos_x = clamp(mouse_pos.x, mouse_pos.x, get_viewport_rect().size.x)
	var temp_pos = global_position
	global_position = global_position.lerp(
		Vector2(mouse_pos.x, global_position.y), 1.0 - exp(-delta * slide_factor)
	)
	# global_position = global_position.lerp(mouse_pos, 1.0 - exp(-delta * slide_factor))
	dx = global_position.x - temp_pos.x
	move_and_collide(Vector2.ZERO * delta)
