class_name SpeedTyperCommand extends TyperCommand

func execute_code(params: String, typer_ref: Typer) -> void:
	var mult: float = float(params)
	typer_ref.type_speed = mult
