extends MarginContainer


onready var Heart1 = $HBoxContainer/Bars/Count
onready var Heart2 = $HBoxContainer/Bars/Count2
onready var Heart3 = $HBoxContainer/Bars/Count3

onready var playerNode =  get_node("../../../Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playerNode.life == 3:
		Heart1.visible = true
		Heart2.visible = true
		Heart3.visible = true
	if playerNode.life == 2:
		Heart1.visible = false
		Heart2.visible = true
		Heart3.visible = true
	if playerNode.life == 1:
		Heart1.visible = false
		Heart2.visible = false
		Heart3.visible = true
	if playerNode.life == 0:
		Heart1.visible = false
		Heart2.visible = false
		Heart3.visible = false
			

	pass
