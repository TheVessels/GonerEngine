class_name ShadowTyperEffect extends TyperEffect

func effect_char(char: Typer.Char, params: Dictionary, time: int) -> Typer.Char:
	var shadow_string = params.get("shadow", "1")
	char.shadow = bool(int(shadow_string))
	return char
