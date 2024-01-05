extends Animatronic

onready var light = main.get_node("Buttons/Lights/LeftVent")

var babyBunny = Animatronic.new()

var jumpscared = false

func _ready():
	babyBunny.setup(self, 360, [ 6, 61, 4, 41, 5, 42, 1, 11, 2 ], self.get_node("Jumpscare"), AILevels.bbAiLvl, 2.3, light, main.get_node("Camera/CameraHolder"), main.get_node("Audio/Jumpscare"), main)
	babyBunny.startMove()
	babyBunny.initVent()
	babyBunny.startPos()

func _process(_dt):
	if jumpscared:
		main.jumpscared = true
		get_tree().change_scene("res://Menu.tscn")
