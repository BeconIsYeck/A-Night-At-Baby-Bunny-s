class_name Animatronic

extends Spatial

onready var main = get_node("/root/Main")

var model = null
var moveOp = null
var maxOp = null
var cams = null
var jumpscare = null
var aiLvl = null
var tick = null
var vent = null
var camHolder = null
var jmpAudio = null
var mainSpatial = null
var atEntry = false
var blocked = false

var curCam = null
var movePos = 0
var canJumpscare = true

func changeCamMove():
	camHolder.moved = true
	
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	model.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	
	camHolder.moved = false
	

func setup(pModel, pMoveOp, pCams, pJumpscare, pAiLvl, pTick, pVent, pCamHolder, pjmpAudio, pMainSpatial):
	model = pModel
	moveOp = pMoveOp
	cams = pCams
	jumpscare = pJumpscare
	aiLvl = pAiLvl
	maxOp = pMoveOp
	tick = pTick
	vent = pVent
	camHolder = pCamHolder
	jmpAudio = pjmpAudio
	mainSpatial = pMainSpatial

func startMove():
	while true:
		if vent.shocked:
			blocked = true
		else:
			blocked = false
		
		moveOp = clamp(moveOp - 1, 0, maxOp)
		
		if moveOp == 0:
			var t = Timer.new()
			t.set_wait_time(tick)
			t.set_one_shot(true)
			model.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			
			if aiLvl >= floor(rand_range(1, 20)):
				print("Move!")
				mainSpatial.playAudio(mainSpatial.get_node("Audio/Footsteps"), model)
				
				changeCamMove()
				
				if !movePos == len(cams) - 1:
					canJumpscare = true
					movePos += 1
					curCam = cams[movePos]
					model.transform.origin = model.get_parent().get_node(str(cams[movePos])).transform.origin
					model.rotation = model.get_parent().get_node(str(cams[movePos])).rotation
					print(curCam)
				else:
					print("At vent!")
					
					atEntry = true
					model.transform.origin = model.get_parent().get_node("Entry").transform.origin
					model.rotation = model.get_parent().get_node("Entry").rotation
					
					t = Timer.new()
					t.set_wait_time(5)
					t.set_one_shot(true)
					model.add_child(t)
					t.start()
					yield(t, "timeout")
					t.queue_free()
					
					if aiLvl >= floor(rand_range(1, 20)):
						if !blocked and !vent.shocked:
							if canJumpscare and !mainSpatial.jumpscared:
								print("Jumpscare!")
								
								model.visible = true
								
								jumpscare.play("Jumpscare")
								jmpAudio.play()
								mainSpatial.jumpscared = true
								
								t = Timer.new()
								t.set_wait_time(jmpAudio.stream.get_length() + 0.1)
								t.set_one_shot(true)
								model.add_child(t)
								t.start()
								yield(t, "timeout")
								t.queue_free()
								
								model.jumpscared = true
								return true
						else:
							movePos = 0
							curCam = cams[movePos]
					else:
						print("Again!")
			else:
				print("Fail!")
			
			moveOp = maxOp
			
		var t = Timer.new()
		t.set_wait_time(0.01)
		t.set_one_shot(true)
		model.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()

func initVent():
	while true:
		if atEntry and vent.shocked:
			blocked = true
			canJumpscare = false
			
			movePos = 0
			curCam = cams[movePos]
			print("Returning!")
			
			var start = model.get_parent().get_node(str(cams[0]))
			
			model.transform.origin = start.transform.origin
			model.rotation = start.rotation
			
			atEntry = false
			blocked = false
		
		if atEntry and vent.visible and !vent.shocked and not mainSpatial.jumpscared:
			model.visible = true
		elif atEntry and !vent.visible and !vent.shocked and not mainSpatial.jumpscared:
			model.visible = false
			
		if !atEntry:
			model.visible = true
		
		var t = Timer.new()
		t.set_wait_time(0.01)
		t.set_one_shot(true)
		model.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()

func startPos():
	var start = model.get_parent().get_node(str(cams[0]))
	
	model.transform.origin = start.transform.origin

func startJumpscare(dis):
	model.transform.origin = dis
	jumpscare.play()
