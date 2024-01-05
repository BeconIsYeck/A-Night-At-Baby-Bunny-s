extends Node2D

func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()

func _on_btnNewGame_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_btnExit_pressed():
	get_tree().quit()

func _on_btnCustomize_pressed():
	get_tree().change_scene("res://CustomNight.tscn")


func _on_btnControls_pressed():
	get_tree().change_scene("res://Contols.tscn")
