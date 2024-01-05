extends KinematicBody

onready var main = get_node("/root/Main")

var camRot = 1

var minAng = 35
var maxAng = -35
var screenDiv = 5

var fliped = false
var flipDiv = 5

var inCams

var flipedMaxAng = 0
var flipedMinAng = 10

func _physics_process(_dt):
	inCams = self.get_parent().get_node("Camera/CameraHolder").on
	
	var windowSize = OS.get_real_window_size()
	var origin = windowSize / 2
	
	var mousePos = get_viewport().get_mouse_position()
	var cam = $CamSpatial
	var mouseDis = mousePos - origin
	
	if main.jumpscared and main.rexAgro >= main.maxAgro:
		cam.rotation_degrees.y = 0
	
	if mouseDis.x > windowSize.x / screenDiv:
		if not fliped:
			cam.rotation_degrees.y = clamp(cam.rotation_degrees.y - camRot, maxAng, INF)
	elif mouseDis.x < -windowSize.x / screenDiv:
		if not fliped:
			cam.rotation_degrees.y = clamp(cam.rotation_degrees.y + camRot, maxAng, minAng)
		
	if Input.is_action_just_pressed("flip") and not inCams:
		fliped = not fliped
		
		if fliped:
			cam.rotation_degrees.y = 180
		else:
			cam.rotation_degrees.y = 0
			
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
