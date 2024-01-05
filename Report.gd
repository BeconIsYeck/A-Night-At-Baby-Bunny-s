extends Button

var normText = text
var errorTxt = "ERROR...@REPORT.CPP--L:" + str(round(rand_range(1, 350))) + "--'FAILED_TO_FIND_DESK'"

var clicked = false

func _on_Button_pressed():
	if !clicked:
		clicked = true
		
		if round(rand_range(1, 4)) != 1:
			get_node("/root/Main/Animatronics/Exploded/Exploded/").disabled = true
			get_node("/root/Main").power -= 1
			get_node("/root/Main/Audio/Click").play()
			clicked = false
		else:
			text = errorTxt
			get_node("/root/Main/Audio/Error").play()
			
			var t = Timer.new()
			t.set_wait_time(5)
			t.set_one_shot(true)
			add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			
			text = normText
			clicked = false
