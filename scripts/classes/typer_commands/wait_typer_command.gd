class_name WaitTyperCommand extends TyperCommand

func execute_code(params: Array, typer_ref: Typer) -> void:
	var frames: int = int(params[0])
	typer_ref.pause = frames
	print("wait ran: ", frames)
