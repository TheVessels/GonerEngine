class_name ColorTyperEffect extends TyperEffect

func effect_char(char: Typer.Char, params: Dictionary, time: int) -> Typer.Char:
	var color_string: String = params.get("color", "white")
	var color_names_array: Array = Array(color_string.split(","))
	
	var colors_array: Array[Color] = []
	for col_name in color_names_array:
		var col = Color.from_string(col_name, Colors.c_black)
		colors_array.append(col)
	
	char.color = colors_array
	return char
