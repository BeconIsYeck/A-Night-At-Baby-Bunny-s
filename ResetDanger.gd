extends Button

var reset = false

var normText = self.text
var sucText = "SUCCESS..."

func _on_Button_pressed():
	if !reset:
		reset = true
		
		if round(rand_range(1, 2)) == 1:
			self.get_parent().get_parent().get_parent().get_parent().rexAgro = 0
			
			self.text = sucText
			get_node("/root/Main/Audio/Click").play()
			
			var t = Timer.new()
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			
			self.text = "ERROR...@CALM.CPP--L:" + str(round(rand_range(100, 200))) + "--'FAILED_TO_FIND_REX'"
			get_node("/root/Main/Audio/Error").play()
			
			t = Timer.new()
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			
			self.text = normText
			
			reset = false
		else:
			self.text = "ERROR...@CALM.CPP--L:" + str(round(rand_range(200, 400))) + "--'DISRUPTION_OCCURRED'"
			get_node("/root/Main/Audio/Error").play()
			
			var t = Timer.new()
			t.set_wait_time(3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			
			self.text = normText
			
			reset = false
