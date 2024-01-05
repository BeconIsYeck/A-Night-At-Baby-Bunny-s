extends Spatial

var muted

func _ready():
	get_node("Message").set_bus("Message")
	
	print(get_node("Message").get_bus())
	print(AudioServer.get_bus_name(1) + "a")
	
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	
	if !muted:
		get_node("Ring").play()
		
		t = Timer.new()
		t.set_wait_time(get_node("Ring").stream.get_length() + 1)
		t.set_one_shot(true)
		add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		
		get_node("Ring").play()
		
		t = Timer.new()
		t.set_wait_time(get_node("Ring").stream.get_length() + 2.5)
		t.set_one_shot(true)
		add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		
		get_node("Message").play()

func _process(_dt):
	if Input.is_action_just_pressed("mute"):
		get_node("Ring").playing = false
		get_node("Message").playing = false
		
		muted = true
	
	if muted:
		get_node("Ring").playing = false
		get_node("Message").playing = false
