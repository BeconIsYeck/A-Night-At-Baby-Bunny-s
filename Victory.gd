extends Node2D

func _ready():
	var t = Timer.new()
	t.set_wait_time(7.5)
	t.set_one_shot(true)
	add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	
	get_tree().change_scene("res://Menu.tscn")
