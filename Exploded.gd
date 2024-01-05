extends MeshInstance

onready var ventPos = self.get_parent().get_node("Vent")
onready var ventLight = self.get_parent_spatial().get_parent_spatial().get_parent_spatial().get_node("Buttons/Lights/RightVent")
onready var ventLight2 = self.get_parent_spatial().get_parent_spatial().get_parent_spatial().get_node("Buttons/Lights/LeftVent")

var inVent = false

var attacked = false
var disabled = false

func _ready():
	transform.origin = self.get_parent().get_node("Return").transform.origin
	rotation_degrees = self.get_parent().get_node("Return").rotation_degrees
	
	var t = Timer.new()
	add_child(t)
	t.connect("timeout", self, "check")
	t.set_wait_time(round(rand_range(30, 60)))
	t.set_one_shot(false)
	t.start()

func _process(_dt):
	if disabled:
		inVent = false
		attacked = false
		transform.origin = self.get_parent().get_node("Return").transform.origin
		rotation_degrees = self.get_parent().get_node("Return").rotation_degrees
		
	
	if ventLight.visible and !ventLight.shocked and inVent and !disabled or ventLight2.visible and !ventLight2.shocked and inVent and !disabled:
		if !attacked:
			attacked = true
			
			get_node("/root/Main/Audio/VentEntry").play()
			
			print("At vent!")
			get_node("/root/Main").camBroken = true
			
			var t = Timer.new()
			t.set_wait_time(round(rand_range(18, 20)))
			t.set_one_shot(true)
			add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			
			get_node("/root/Main").camBroken = false
			
			transform.origin = self.get_parent().get_node("Return").transform.origin
			rotation_degrees = self.get_parent().get_node("Return").rotation_degrees
			
			inVent = false
			attacked = false

func check():
	if AILevels.eAiLvl >= round(rand_range(1, 20)):
		print("Move!")
		
		disabled = false
		
		transform.origin = self.get_parent().get_node("Vent").transform.origin
		rotation_degrees = self.get_parent().get_node("Vent").rotation_degrees
		
		inVent = true
