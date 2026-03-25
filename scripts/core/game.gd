extends Node2D

const DICE_SCENE   = preload("res://scenes/Dice.tscn")
const DICE_SPACING = 80
const DICE_COUNT   = 5

var dice_pool: Array = []

@onready var scoring     = $Scoring       # Node с scoring.gd
@onready var score_panel = $ScorePanel    # ScorePanel.tscn инстанс

func _ready() -> void:
	_spawn_dice()
	$RollButton.pressed.connect(roll_all)

func _spawn_dice() -> void:
	for i in DICE_COUNT:
		var die = DICE_SCENE.instantiate()
		die.position = Vector2(
			(get_viewport().size.x / 2.0) - ((DICE_COUNT - 1) * DICE_SPACING / 2.0) + i * DICE_SPACING,
			get_viewport().size.y / 2.0
		)
		add_child(die)
		dice_pool.append(die)

func roll_all() -> void:
	for die in dice_pool:
		die.roll()
	_update_score()

func _update_score() -> void:
	var values = dice_pool.map(func(d): return d.current_value)
	var green  = scoring.calculate_green(values)
	var orange = scoring.calculate_orange(values)
	score_panel.update(green, orange, scoring.last_combo_name)
	print("Throw: ", values, " | Green: ", green, " | Orange: ", orange)
	_highlight_dice(scoring.last_combo_indices)
	
func _highlight_dice(combo_indices: Array) -> void:
	for i in dice_pool.size():
		if combo_indices.is_empty():
			dice_pool[i].highlight("normal")
		elif combo_indices.has(i):
			dice_pool[i].highlight("active")
		else:
			dice_pool[i].highlight("inactive")
