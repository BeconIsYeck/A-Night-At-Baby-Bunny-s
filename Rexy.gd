extends MeshInstance

onready var main = get_node("/root/Main")

onready var aiLvl = AILevels.rAiLvl

var jumpscared = false
var correctionDis = 2

func _ready():
	self.transform.origin.z -= correctionDis
	
	aiLvl = clamp(aiLvl, 0, 20)
	
	var t = Timer.new()
	add_child(t)
	t.connect("timeout", self, "aggravate")
	t.set_wait_time(1)
	t.set_one_shot(false)
	t.start()

func _process(_dt):
	if main.rexAgro >= main.maxAgro:
		if !jumpscared and !main.jumpscared:
			jumpscared = true
			main.jumpscared = true
			main.get_node("Player").fliped = false
			
			main.get_node("Audio/Jumpscare").play()
			
			get_node("Jumpscare").play("Jumpscare")
			
			var t = Timer.new()
			t.set_wait_time(main.get_node("Audio/Jumpscare").stream.get_length())
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			
			get_tree().change_scene("res://Menu.tscn")
			jumpscared = false

func aggravate():
	if aiLvl != 0:
		main.rexAgro += (aiLvl / main.rexAgroDiv)
