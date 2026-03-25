extends Node2D

@onready var label_green  = $Panel/VBoxContainer/LabelGreen
@onready var label_orange = $Panel/VBoxContainer/LabelOrange
@onready var label_total  = $Panel/VBoxContainer/LabelTotal
@onready var label_combo = $Panel/VBoxContainer/LabelCombo

func update(green: int, orange: int, combo_name: String) -> void:
	label_green.text  = "Green: "  + str(green)
	label_orange.text = "Orange: " + str(orange)
	label_total.text  = "Total: "  + str(green + orange)
	label_combo.text = "Combo:" + combo_name
