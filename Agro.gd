extends Label

onready var main = get_node("/root/Main")
onready var maxAgro = main.maxAgro

func _process(_dt):
	var agro = main.rexAgro
	
	if agro <= maxAgro / 5:
		self.self_modulate = Color(0, 1, 0)
	elif agro <= maxAgro / 3.5:
		self.self_modulate = Color(0, 0, 1)
	elif agro <= maxAgro / 3:
		self.self_modulate = Color(0, 0.5, 0.5)
	elif agro <= maxAgro / 2:
		self.self_modulate = Color(1, 0.25, 0)
	elif agro <= maxAgro / 1:
		self.self_modulate = Color(1, 0, 0)
	
	self.text = "Danger: " + str(agro)
