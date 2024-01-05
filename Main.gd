extends Spatial

export (int) var firstNight = 1
export (int) var lastNight = 7
export (int) var curNight = firstNight

export (int) var maxPow = 100
export (int) var minPow = 0
export (float) var power = maxPow
export (int) var critPower = maxPow / 10
export (float) var usage = 1.6
export (float) var bar = 0.7
export (float) var tick = 0.5

export (bool) var blackout = false

export (int) var begTime = 12
export (int) var endTime = 6
export (int) var curTime = begTime
export (int) var hourLen = 60
export (int) var animTick = 0.01

export (bool) var jumpscared = false

export (float) var rexAgro = 0
export (float) var maxAgro = 3

export (float) var agroBar = 0.25
export (int) var rexAgroDiv = 160

export (bool) var camBroken = false

export (Array, int) var animTicks = [ 
	4.5,
	5.3,
	11.2,
]

export (Array, int) var animTickDec = [
	0.3,
	0.4,
	0.1
]

func playAudio(audio, parent):
	var newAudio = audio.duplicate()
	parent.add_child(newAudio)
	newAudio.play()
	
	var t = Timer.new()
	t.set_wait_time(newAudio.stream.get_length())
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	
	newAudio.queue_free()

func newHour(hour):
	if hour == 12:
		return 1
	else:
		return clamp(hour + 1, 0, 6)

func _ready():
	while true:
		power -= (usage * 3 / power) / 1.25
		
		var t = Timer.new()
		t.set_wait_time(tick)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()

func _process(_dt):
	if curTime == 6:
		get_tree().change_scene("res://Victory.tscn")
	
	if Input.is_action_pressed("restart"):
		if Input.is_action_just_pressed("confirm"):
			get_tree().change_scene("res://Menu.tscn")
	
	if round(power) == 0:
		blackout = true
		usage = 0
		
		for i in self.get_node("Lights").get_children():
			i.visible = false
		
		var t = Timer.new()
		t.set_wait_time(tick * 10)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		
		get_tree().change_scene("res://Menu.tscn")
	
	power = clamp(power, 0.1, maxPow)
