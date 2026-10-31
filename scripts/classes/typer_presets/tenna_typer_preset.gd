class_name TennaTyperPreset extends DefaultTyperPreset

func _init() -> void:
	talk_stream = load("res://sounds/voice/tenna.tres")
	talk_volume = 0.7
	talk_freq = 3
	font = load("res://fonts/main.ttf")

func talk_pitch_calc() -> float:
	var pitch = (0.86 + randf_range(0.0, 0.35))
	return pitch
