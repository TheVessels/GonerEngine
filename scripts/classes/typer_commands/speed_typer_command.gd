class_name SpeedTyperCommand extends TyperCommand

func execute_code(params: Array, typer_ref: Typer) -> void:
	var mult: float = float(params[0])
	typer_ref.type_speed = mult
