@icon("uid://bw0iqumaar5ok")
@tool
class_name TextBox extends Control
## A Control node for a DELTARUNE dialogue box.
## 
## [b]Note:[/b] Not meant to be instantiated directly.
## [br]
## Instead, use [method TextBox.start_dialogue] (or [method TextBox.create] if you only need a [b]TextBox[/b] node).

@onready var dia_typer: Typer = $DialogueText
@export_multiline("monospace") var text: Array[String] = [""]:
	set(new):
		if is_node_ready():
			text = new
			dia_typer.text = new
		else:
			await ready
			text = new
			dia_typer.text = new

@onready var dark_box: NinePatchRect = $DarkBox
@onready var light_box: NinePatchRect = $LightBox

@export var dynamic_box: bool = false

const textbox_scene: PackedScene = preload("uid://c5nrska6i801g")

static var has_textbox := false

var animating: bool = false
var pause: int = 0
var text_index: int = 0

# this is actually called a `paragraph` in `RichTextLabel`
# because each line here means includes wrapped lines
var line_starts_with_asterisk: Array[bool] = []
var has_asterisks: bool

static func start_dialogue(text: Array) -> void:
	Signals.startDialogue.emit(text)

# Creates a new textbox.
static func create(text: Array) -> TextBox:
	var textbox_inst: TextBox = textbox_scene.instantiate()
	#textbox_inst.text = text
	# append_array needed otherwise godot is weird
	textbox_inst.text.clear()
	textbox_inst.text.append_array(text)
	return textbox_inst

func _exit_tree() -> void:
	has_textbox = false

func _ready():
	dia_typer.text = text
	dia_typer.visible_characters = 0
	
	if Engine.is_editor_hint(): return
	
	has_textbox = true
	
	match Global.world_type:
		Global.WorldTypes.WORLD_LIGHT:
			dark_box.visible = false
			light_box.visible = true
			$TalkSprite.set_position(Vector2(64.0, 350.0))
		Global.WorldTypes.WORLD_DARK:
			dark_box.visible = true
			light_box.visible = false
			$TalkSprite.set_position(Vector2(69.0, 350.0))

func _process(_delta: float) -> void:
	if Engine.is_editor_hint() or !is_node_ready():
		return
	
	if dynamic_box:
		match Global.world_type:
			Global.WorldTypes.WORLD_LIGHT:
				dark_box.visible = false
				light_box.visible = true
				$TalkSprite.set_position(Vector2(64.0, 350.0))
			Global.WorldTypes.WORLD_DARK:
				dark_box.visible = true
				light_box.visible = false
				$TalkSprite.set_position(Vector2(69.0, 350.0))
