class_name ShakeTyperEffect extends TyperEffect

func effect_char(char: Typer.Char, params: Dictionary, time: int) -> Typer.Char:
	var connected = params.get("connected", "0")
	var level_string: String = params.get("level", "1.0")
	var level = float(level_string)
	
	if connected == "1":
		char.pos_offset = get_unified_offset(level, time)
	else:
		char.pos_offset = Vector2(randf_range(-level, level), randf_range(-level, level))
	
	return char

func get_unified_offset(level: float, time: int) -> Vector2:
	var rng := RandomNumberGenerator.new()
	rng.seed = time
	return Vector2(rng.randf_range(-level, level), rng.randf_range(-level, level))
