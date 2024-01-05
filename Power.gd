extends Label

onready var main = get_node("/root/Main")

func _process(_dt):
	self.text = str(round(main.power)) + "% " + str(Engine.get_frames_per_second())
	
	if round(main.power) <= main.critPower:
		self.self_modulate = Color(1, 0, 0)
	else:
		self.self_modulate = Color(1, 1, 1)
