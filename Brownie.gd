extends Animatronic

onready var light = main.get_node("Buttons/Lights/RightVent")

var brownie = Animatronic.new()

var jumpscared = false

func _ready():
	self.get_node("JumpscareLight").visible = false
	
	brownie.setup(self, 500, [ 5, 4, 41, 1, 11, 12, 3 ], self.get_node("Jumpscare"), AILevels.bAiLvl, 0.7, light, main.get_node("Camera/CameraHolder"), main.get_node("Audio/Jumpscare"), main)
	brownie.startMove()
	brownie.initVent()
	brownie.startPos()

func _process(_dt):
	if jumpscared:
		main.jumpscared = true
		get_tree().change_scene("res://Menu.tscn")
