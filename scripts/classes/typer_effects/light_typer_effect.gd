class_name LightTyperEffect extends TyperEffect

func effect_char(char: Typer.Char, params: Dictionary, time: int) -> Typer.Char:
	char.dark = false
	char.shadow = false
	return char
