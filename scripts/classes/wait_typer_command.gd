class_name WaitTyperCommand extends TyperCommand

func execute_code(params: String, typer_ref: Typer) -> void:
	var frames: int = int(params)
	typer_ref.pause = frames
