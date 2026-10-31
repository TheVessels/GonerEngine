class_name PitchTyperCommand extends TyperCommand

func execute_code(params: Array, typer_ref: Typer) -> void: 
	var pitch: float = float(params[0])
	typer_ref.talk_pitch = pitch
