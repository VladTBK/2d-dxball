extends CharacterBody2D

var initial_dir := Vector2(0, 1)
var bonus_acc = Vector2.ZERO
const BALL_SPEED := 300
const PLAYER_OFFSET_POWER := 0.1
const BOTTOM := "BottomBorder"
const GENERALBORDER := "GeneralBorders"
const BIGBOI := "bigboi"
@onready var player = get_tree().get_first_node_in_group("player") as Node2D


func _ready():
	velocity = initial_dir * BALL_SPEED


func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if collider.name == BOTTOM:
			# commit unalive
			queue_free()
			return
		elif collider == player:
			pass
			# bonus_acc = Vector2(player.dx * BALL_SPEED * PLAYER_OFFSET_POWER, 0)
		elif collider.name != GENERALBORDER:
			player.score += 1
			var get_color = []
			for i in range(4):
				get_color.append(int(collider.modulate[i]))
			match get_color:
				[1, 0, 0, 1]:
					collider.spawn_ball()
				[0, 1, 0, 1]:
					collider.kill_neighbours()
				[0, 0, 1, 1]:
					collider.big_boy()
				[0, 0, 0, 1]:
					collider.win()
				_:
					pass
			collider.queue_free()

		# to the bounce velocity.x add a constant base on how much the platform has moved (dx)
		velocity = velocity.bounce(collision_info.get_normal()) + bonus_acc
		bonus_acc = Vector2.ZERO

		# if normal is 0 add a rand direction

		if velocity.x == 0:
			var rand_dir = randi_range(0, 1)
			if rand_dir == 0:
				velocity += Vector2(1, 0) * BALL_SPEED * 2
			else:
				velocity += Vector2(-1, 0) * BALL_SPEED * 2
