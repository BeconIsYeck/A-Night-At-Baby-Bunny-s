extends CSGBox

var down = false
var on = false

onready var main = get_node("/root/Main")
onready var lights = self.get_parent().get_node("Lights")

var direction

func _ready():
	if self.name.substr(0, 5) == "Right":
		direction = "Right"
	elif self.name.substr(0, 4) == "Left":
		direction = "Left"

func _on_LightArea_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if not main.blackout and !main.jumpscared:
			down = not down
			
			if down:
				on = not on
				
				if on:
					lights.get_node(direction + "Vent").visible = true
					
					if not lights.get_node(direction + "Vent").get_node("LightBuzz").playing:
						lights.get_node(direction + "Vent").get_node("LightBuzz").playing = true
	
					
					main.usage += main.bar
				else:
					lights.get_node(direction + "Vent").visible = false
					if lights.get_node(direction + "Vent").get_node("LightBuzz").playing:
						lights.get_node(direction + "Vent").get_node("LightBuzz").playing = false
	
					
					main.usage -= main.bar

func _process(_dt):
	if main.jumpscared:
		lights.get_node(direction + "Vent").get_node("LightBuzz").playing = false
	
	if main.blackout:
		lights.get_node(direction + "Vent").visible = false
		lights.get_node(direction + "Vent").get_node("LightBuzz").playing = false
