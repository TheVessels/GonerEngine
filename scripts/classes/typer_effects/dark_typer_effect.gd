class_name DarkTyperEffect extends TyperEffect

func effect_char(char: Typer.Char, params: Dictionary, time: int) -> Typer.Char:
	char.dark = true
	char.shadow = true
	return char
