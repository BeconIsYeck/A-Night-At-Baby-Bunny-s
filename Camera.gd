extends CSGBox

var on = false

onready var camSys = self.get_parent().get_node("CameraSystem")
onready var globCam = self.get_parent().get_parent().get_node("Player/CamSpatial/Camera")
onready var main = get_node("/root/Main")
onready var camSwap = self.get_parent().get_node("CameraSwap")
onready var camOpen = self.get_parent().get_node("CameraOpen")
onready var camClose = self.get_parent().get_node("CameraClose")
onready var camEffects = self.get_parent().get_node("CameraEffects")
onready var camera = main.get_node("Camera")

onready var lblCamPos = camEffects.get_node("lblCamPos")

var cams

var fliped

var camNum = 1
var curCam
var maxCams = 8

var moved = false

var increased = false

func updateCam():
	curCam = cams[camNum - 1]

func setCam():
	curCam.current = true
	globCam.current = false
	
func resetCams():
	curCam.current = false
	globCam.current = true

func _ready():
	cams = [
		camSys.get_node("Cam-1"),
		camSys.get_node("Cam-2"),
		camSys.get_node("Cam-3"),
		camSys.get_node("Cam-4"),
		camSys.get_node("Cam-5"),
		camSys.get_node("Cam-6"),
		camSys.get_node("Cam-7"),
		camSys.get_node("Cam-8")
	]
	
	curCam = cams[camNum - 1]

func _physics_process(_dt):
	if !main.camBroken:
		if main.jumpscared:
			camEffects.visible = false
			camEffects.get_node("CamBlock/CamBlock").visible = false
			camEffects.get_node("Vignette/Vignette").visible = false
			camEffects.get_node("lblCamPos").visible = false
			camEffects.get_node("Restart/Button").visible = false
			camEffects.get_node("Report/Button").visible = false
			resetCams()
		
		if main.blackout:
			camEffects.visible = false
			camEffects.get_node("CamBlock/CamBlock").visible = false
			camEffects.get_node("Vignette/Vignette").visible = false
			camEffects.get_node("lblCamPos").visible = false
			camEffects.get_node("Restart/Button").visible = false
			camEffects.get_node("Report/Button").visible = false
			resetCams() 
		
		if !on:
			camEffects.get_node("CamBlock/CamBlock").visible = false
			camEffects.get_node("Restart/Button").visible = false
			camEffects.get_node("Report/Button").visible = false
		
		lblCamPos.text = str(camNum)
		
		if on:
			if camNum == 7:
				camEffects.get_node("Restart/Button").visible = true
			else:
				camEffects.get_node("Restart/Button").visible = false
			
			if camNum == 8:
				camEffects.get_node("Report/Button").visible = true
			else:
				camEffects.get_node("Report/Button").visible = false
				
			lblCamPos.visible = true
			
			if moved:
				camEffects.get_node("CamBlock/CamBlock").visible = true
			else:
				camEffects.get_node("CamBlock/CamBlock").visible = false
		else:
			lblCamPos.visible = false
		
		fliped = self.get_parent().get_parent().get_node("Player").fliped
		
		if Input.is_action_just_pressed("camClose"):
			if not main.blackout and !main.camBroken:
				if not fliped:
					on = not on
					
					if on:
						setCam()
						
						main.playAudio(camOpen, camera)
						
						if not increased:
							main.usage += main.bar
							increased = true
					else:
						resetCams()
						main.usage -= main.bar
						increased = false
						
						main.playAudio(camClose, camera)
		
		if on and Input.is_action_just_pressed("cycleCams"):
			if not main.blackout:
				if not fliped:
					if camNum == maxCams:
						camNum = 1
						updateCam()
						setCam()
					else:
						camNum += 1
						updateCam()
						setCam()
					
					main.playAudio(camSwap, camera)
		
		if on and Input.is_action_just_pressed("cycleCamsBack"):
			if not main.blackout:
				if not fliped:
					if camNum == 1:
						camNum = maxCams
						updateCam()
						setCam()
					else:
						camNum -= 1
						updateCam()
						
					main.playAudio(camSwap, camera)
					
					setCam()
