@abstract
class_name TyperCommand extends RefCounted

@abstract
# sorry params will always be strings and it's your job to evaluate them
# into different types
func execute_code(params: String, typer_ref: Typer)
