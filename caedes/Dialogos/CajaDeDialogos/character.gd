extends Control

func add_character(pers):
	var characterPath:String = "res://assets/PerDialogos/%s/character/0.png" % pers.id
	if FileAccess.file_exists(characterPath):
		$image.texture = load(characterPath)
	else:
		$image.texture = null
	
func  add_character_id(id:String):
	var characterPath:String = "res://assets/PerDialogos/%s/character/0.png" % id
	if FileAccess.file_exists(characterPath):
		$image.texture = load(characterPath)
	else:
		$image.texture = null

func remove_character():
	$ColorRect.color = null
	$image.texture = null
	
	
