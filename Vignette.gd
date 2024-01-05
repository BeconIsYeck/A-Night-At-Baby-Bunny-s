extends ColorRect

onready var cam = self.get_parent().get_parent().get_parent().get_node("CameraHolder")

func _ready():
	self.visible = false

func _physics_process(_dt):
	if cam.on:
		self.visible = true
	else:
		self.visible = false
	
	if get_node("/root/Main").jumpscared:
		self.visible = false
