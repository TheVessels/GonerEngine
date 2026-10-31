class_name PresetTyperCommand extends TyperCommand

func execute_code(params: Array, typer_ref: Typer) -> void:
	var preset: TyperPreset = Typer.presets_registry.get(params[0])
	
	if typer_ref.caller is TextBox:
		var textbox: TextBox = typer_ref.caller
		textbox.set_face_frames(preset.faces)
		
		if preset.faces:
			var face_int: int = 0
			if params.size() > 1:
				face_int = int(params[1])
			textbox.set_face(face_int)
			textbox.set_face_offset(preset.face_offset)
	
	typer_ref.talk_audio = preset.talk_stream
	typer_ref.talk_volume = preset.talk_volume
	typer_ref.talk_pitch_calc = preset.talk_pitch_calc
	typer_ref.talk_freq = preset.talk_freq
