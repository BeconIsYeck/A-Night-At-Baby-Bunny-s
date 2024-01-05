extends Label

onready var main = get_node("/root/Main")

func _process(_dt):
	self.text = str(main.usage) + " | " + str(main.usage * 3 / main.power)
