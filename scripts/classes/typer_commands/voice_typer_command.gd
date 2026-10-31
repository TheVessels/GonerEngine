class_name VoiceTyperCommand extends TyperCommand

func execute_code(params: Array, typer_ref: Typer) -> void:
	var voice_name: String = params[0]
	var voice_stream: AudioStream
	
	for extension in ["wav", "tres", "ogg", "mp3"]:
		if voice_stream != null:
			break
		voice_stream = load("res://sounds/voice/%s.%s" % [voice_name, extension])
	
	typer_ref.talk_audio = voice_stream
