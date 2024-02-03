extends Control

@onready var timer := $Timer
@onready var label_dict := [1, 2, 3]
@onready var label1 := %Label1
@onready var label2 := %Label2
@onready var label3 := %Label3
var timer_start := false


func _process(delta):
	if timer_start:
		var time_elapsed = int(floor(timer.wait_time - timer.time_left))
		match time_elapsed:
			0:
				label3.visible = true
			1:
				label3.visible = false
				label2.visible = true
			2:
				label3.visible = false
				label2.visible = false
				label1.visible = true
			3:
				get_tree().change_scene_to_file("main.tscn")


func _on_play_pressed():
	timer.start()
	timer_start = true
	$MarginContainer.queue_free()
	pass  # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
	pass  # Replace with function body.


func _on_timer_timeout():
	pass  # Replace with function body.
