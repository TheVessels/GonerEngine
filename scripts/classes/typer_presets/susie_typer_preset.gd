class_name SusieTyperPreset extends DefaultTyperPreset

func _init() -> void:
	faces = load("res://sprites/faces/susie/susie_faces.tres")
	face_offset = Vector2(-5, 0)
	talk_stream = load("res://sounds/voice/tenna.tres")

func talk_pitch_calc() -> float:
	return 1.0
