class_name DefaultTyperPreset extends TyperPreset

func _init() -> void:
	faces = null
	face_offset = Vector2.ZERO
	talk_stream = null
	talk_speed = 1.0
	talk_volume = 1.0
	talk_freq = 1
	font = load("res://fonts/main.ttf")

func talk_pitch_calc() -> float:
	return 1.0
