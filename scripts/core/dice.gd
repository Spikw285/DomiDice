extends Node2D

@export var config: DiceConfig
var current_value: int = 1

@onready var sprite = $Sprite2D 

const COLOR_NORMAL = Color(1.0, 1.0, 1.0, 1.0)
const COLOR_ACTIVE = Color(1.0, 0.85, 0.2, 1.0)
const COLOR_INACTIVE = Color(0.45, 0.45, 0.45, 1.0)

func roll():
	if config:
		current_value = config.get_random_face()
		update_visuals(current_value)

func update_visuals(value: int):
	print("Roll: ", value)
	
	if config.regions.has(value):
		sprite.region_rect = config.regions[value]
		
func highlight(state: String) -> void:
	match state:
		"active":   sprite.modulate = COLOR_ACTIVE
		"inactive": sprite.modulate = COLOR_INACTIVE
		_:          sprite.modulate = COLOR_NORMAL
