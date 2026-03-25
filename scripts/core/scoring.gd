extends Node

var last_combo_name: String = "-"
var last_combo_indices: Array = []

func calculate_green(dice_values: Array) -> int:
	var total = 0
	for v in dice_values:
		total += v
	return total

func calculate_orange(dice_values: Array) -> int:
	var combo = _detect_combo(dice_values)
	last_combo_name = combo["name"]
	last_combo_indices = combo["indices"]
	return combo["score"]

func _detect_combo(values: Array) -> Dictionary:
	var sorted_idx = range(values.size())
	sorted_idx.sort_custom(func(a, b): return values[a] < values[b])

	var counts = {}
	for i in values.size():
		var v = values[i]
		if not counts.has(v):
			counts[v] = []
		counts[v].append(i)  # индекс, а не значение

	# Сортируем группы по размеру (убывание)
	var groups = counts.values()
	groups.sort_custom(func(a, b): return a.size() > b.size())

	# Яцзы
	if groups[0].size() == 5:
		return {"name": "Yahtzee!", "score": 50, "indices": groups[0]}

	# Каре
	if groups[0].size() == 4:
		return {"name": "Four of a kind", "score": 40, "indices": groups[0]}

	# Фулл-хаус
	if groups[0].size() == 3 and groups.size() > 1 and groups[1].size() == 2:
		return {"name": "Full House", "score": 25,
				"indices": groups[0] + groups[1]}

	var unique_vals = counts.keys()
	unique_vals.sort()
	var straight5 = _find_straight_indices(unique_vals, counts, 5)
	if straight5.size() > 0:
		return {"name": "Big straight", "score": 40, "indices": straight5}

	var straight4 = _find_straight_indices(unique_vals, counts, 4)
	if straight4.size() > 0:
		return {"name": "Small straight", "score": 30, "indices": straight4}

	# Тройка
	if groups[0].size() == 3:
		return {"name": "Three of a kind", "score": 10, "indices": groups[0]}

	# Две пары
	if groups[0].size() == 2 and groups.size() > 1 and groups[1].size() == 2:
		return {"name": "Two pairs", "score": 5,
				"indices": groups[0] + groups[1]}

	# Пара
	if groups[0].size() == 2:
		return {"name": "Pair", "score": 2, "indices": groups[0]}

	return {"name": "Chance", "score": 0, "indices": []}

func _find_straight_indices(unique_vals: Array, counts: Dictionary, length: int) -> Array:
	for i in range(unique_vals.size() - length + 1):
		var ok = true
		for j in range(1, length):
			if unique_vals[i + j] != unique_vals[i + j - 1] + 1:
				ok = false
				break
		if ok:
			var result = []
			for j in range(length):
				result.append(counts[unique_vals[i + j]][0])
			return result
	return []
