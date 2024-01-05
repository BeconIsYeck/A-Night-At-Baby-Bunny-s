tool
extends Viewport

func _process(_dt):
	self.size = self.get_child(0).rect_size
