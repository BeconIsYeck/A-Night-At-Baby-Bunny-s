extends Node2D

func _on_Back_pressed():
	get_tree().change_scene("res://Menu.tscn")

func _process(_dt):
	if Input.is_action_just_pressed("ui_accept"):
		var main = preload("res://Main.tscn").instance()
		
		AILevels.bbAiLvl = float(get_node("TextBoxes/BabyBunnyAiLvl").text)
		AILevels.bAiLvl = float(get_node("TextBoxes/BrownieAiLvl").text)
		AILevels.rAiLvl = float(get_node("TextBoxes/RexyAiLvl").text)
		AILevels.eAiLvl = float(get_node("TextBoxes/ExplodedAiLvl").text)
