@icon("uid://bw0iqumaar5ok")
@tool
class_name TextBox extends Control
## A Control node for a DELTARUNE dialogue box.
## 
## [b]Note:[/b] Not meant to be instantiated directly.
## [br]
## Instead, use [method TextBox.start_dialogue] (or [method TextBox.create] if you only need a [b]TextBox[/b] node).

@export var dynamic_box: bool = false

@onready var face_sprite: AnimatedSprite2D = $TalkSprite
var has_face: bool = true
var face_default_pos: Vector2
var face_offset: Vector2 = Vector2(0.0, 0.0)
		
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

@export_group("Talking Sound")
@export var talk_audio: AudioStream
@export_range(0.1, 2.0, 0.1) var talk_pitch: float = 1.0

@onready var dark_box: NinePatchRect = $DarkBox
@onready var light_box: NinePatchRect = $LightBox

const textbox_scene: PackedScene = preload("uid://c5nrska6i801g")

static var has_textbox := false

var animating: bool = false
var pause: int = 0
var text_index: int = 0

var face_default_position: Vector2 = Vector2(69.0, 350.0)
var current_face: int

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
	face_default_pos = face_sprite.position
	
	dia_typer.caller = self
	dia_typer.destroy_caller = true
	dia_typer.text = text
	dia_typer.visible_characters = 0
	dia_typer.talk_audio = talk_audio
	dia_typer.talk_pitch = talk_pitch
	dia_typer.start_processing.emit()
	
	if Engine.is_editor_hint(): return
	
	has_textbox = true
	
	match Global.world_type:
		Global.WorldTypes.WORLD_LIGHT:
			dark_box.visible = false
			light_box.visible = true
		Global.WorldTypes.WORLD_DARK:
			dark_box.visible = true
			light_box.visible = false

func _process(_delta: float) -> void:
	if Engine.is_editor_hint() or !is_node_ready():
		return
	
	if dynamic_box:
		match Global.world_type:
			Global.WorldTypes.WORLD_LIGHT:
				dark_box.visible = false
				light_box.visible = true
			Global.WorldTypes.WORLD_DARK:
				dark_box.visible = true
				light_box.visible = false

func set_face_frames(frames: SpriteFrames) -> void:
	if !frames and has_face:
		dia_typer.position.x -= 116.0
		dia_typer.size.x += 116.0
		has_face = false
	if frames and !has_face:
		dia_typer.position.x += 116.0
		dia_typer.size.x -= 116.0
		has_face = true
	face_sprite.sprite_frames = frames

func set_face(face: int) -> void:
	face_sprite.frame = face

func set_face_offset(offset: Vector2) -> void:
	face_offset = offset
	face_sprite.position = face_default_pos + face_offset
