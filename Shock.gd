extends CSGBox

onready var main = get_node("/root/Main")
onready var lights = self.get_parent().get_node("Lights")
onready var uses = main.bar * 25

var ventLight

var down = false
var on = false
var triggered = false

var direction

func _ready():
	if self.name.substr(0, 5) == "Right":
		direction = "Right"
	elif self.name.substr(0, 4) == "Left":
		direction = "Left"
		
	ventLight = self.get_parent().get_node(direction + "Light")

func _on_RightArea_input_event(_camera, event, _position, _normal, _shape_idx):
	var light = lights.get_node(direction + "Vent")
	
	if event is InputEventMouseButton:
		if not main.blackout and !main.jumpscared:
			
			down = not down
			
			if down:
				if not triggered:
					triggered = true
					
					light.light_energy = 16
					light.visible = true
					light.shocked = true
					
					main.usage += uses
					main.power -= 3
					main.rexAgro += main.agroBar
					
					light.get_node("LightBuzz").playing = false
					
					var t = Timer.new()
					t.set_wait_time(main.tick / 5)
					t.set_one_shot(true)
					self.add_child(t)
					t.start()
					yield(t, "timeout")
					t.queue_free()
					
					light.shocked = false
					light.light_energy = 1
					light.visible = false
					
					if ventLight.on == true:
						ventLight.on = false
						main.usage -= main.bar
					
					main.usage -= uses
					
					t = Timer.new()
					t.set_wait_time(main.tick * 4)
					t.set_one_shot(true)
					self.add_child(t)
					t.start()
					yield(t, "timeout")
					t.queue_free()
					
					triggered = false
