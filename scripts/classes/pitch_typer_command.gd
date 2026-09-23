class_name PitchTyperCommand extends TyperCommand

func execute_code(params: String, typer_ref: Typer) -> void: 
	var pitch_mult: float = float(params)
	if typer_ref.use_pitch_range:
		typer_ref.upper_limit *= pitch_mult
		typer_ref.lower_limit *= pitch_mult
	else:
		typer_ref.talk_pitch = pitch_mult
