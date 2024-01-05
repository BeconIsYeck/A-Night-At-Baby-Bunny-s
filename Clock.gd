extends Label

onready var main = get_node("/root/Main")

func _ready():
	while true:
		var t = Timer.new()
		t.set_wait_time(main.hourLen)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		
		main.curTime = main.newHour(main.curTime)
		self.text = str(main.curTime) + " A.M."
