class_name FaceTyperCommand extends TyperCommand

func execute_code(params: Array, typer_ref: Typer) -> void:
	if typer_ref.caller is not TextBox:
		push_error("Caller is not a TextBox")
		return
	
	
	var caller: TextBox = typer_ref.caller
	var face_frame: int = int(params[0])
	
	if params[0] == "none":
		caller.set_face_frames(null)
		return
	
	if params.size() == 1:
		caller.set_face(face_frame)
	elif params.size() > 1:
		var faces_name: String = params[1]
		var frames_path: String =\
		"res://sprites/faces/{name}/{name}_faces.tres".format({"name": faces_name})
		var frames: SpriteFrames = load(frames_path)
		
		# Handle setting a custom offset
		if params.size() > 2:
			var custom_offset: Vector2 = params[2]
			caller.set_face_frames(frames)
			caller.set_face(face_frame)
			caller.set_face_offset(custom_offset)
			return
		
		caller.set_face_frames(frames)
		caller.set_face(face_frame)
