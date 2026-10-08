# SHAPED TEXT TEST
extends Node2D

var length := 0
var ts: TextServer
var shaped_text: RID
var line_break_lengths: Array[int]

const FONT: FontFile = preload("res://fonts/main_mono.ttf")
const BROTHER_IMAGE: CompressedTexture2D = preload("res://sprites/actors/ralsei/dark/walk/left_1.png")

func draw_one_shaped_text(ts: TextServer, shaped_text: RID, pos: Vector2, font_size: int) -> void:
	var asterisk_width := FONT.get_string_size('* ', HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
	
	ts.shaped_text_draw(shaped_text, get_canvas_item(), pos)
	
	var objects := ts.shaped_text_get_objects(shaped_text)
	for i in range(objects.size()):
		if objects[i]["type"] == "asterisk":
			var asterisk_pos = pos - Vector2(asterisk_width, 0.0)
			draw_string(FONT, asterisk_pos, "* ", HORIZONTAL_ALIGNMENT_LEFT, -1, 32)
		elif objects[i]["type"] == "texture":
			var rect := ts.shaped_text_get_object_rect(shaped_text, objects[i])
			rect.position += pos
			
			var tex: Texture2D = objects[i]["texture"]
			draw_texture_rect(tex, rect, false)

func draw_shaped_text(ts: TextServer, shaped_text: RID, length: int, font_size: int, line_break_lengths: Array[int]) -> void:
	var pos_to_draw := Vector2(100, 100)
	var text_pos := pos_to_draw
	var font_height := FONT.get_height(font_size)
	var start := 0
	
	var the_length := length
	
	for lblen in line_break_lengths:
		if the_length <= 0: break
		
		var one_length := mini(lblen, the_length)
		var sub_shaped_text = ts.shaped_text_substr(shaped_text, start, one_length)
		draw_one_shaped_text(
			ts, sub_shaped_text, text_pos, font_size
		)
		text_pos = Vector2(pos_to_draw.x, text_pos.y + font_height)
		the_length -= lblen
		start += lblen

func _draw() -> void:
	# THIS LINE IS TO SHOW WHERE THE LINE WRAPPING HAPPENS
	draw_rect(Rect2(100, 100-30, 300, 300), Color.DIM_GRAY)
	draw_shaped_text(ts, shaped_text, length, 32, line_break_lengths)

func _ready() -> void:
	ts = TextServerManager.get_primary_interface()
	var font := FONT.get_rids()[0]
	
	shaped_text = ts.create_shaped_text(TextServer.DIRECTION_LTR, TextServer.ORIENTATION_HORIZONTAL)
	var asterisk_item := {
		"type": "asterisk"
	}
	ts.shaped_text_add_object(shaped_text, asterisk_item, Vector2.ZERO)
	ts.shaped_text_add_string(
		shaped_text, "My ",
		[font], 32
	)
	var brother_item := {
		"type": "texture",
		"texture": BROTHER_IMAGE
	}
	ts.shaped_text_add_object(shaped_text, brother_item, BROTHER_IMAGE.get_size())
	ts.shaped_text_add_string(
		shaped_text, " brother has a very very very special attack.",
		[font], 32
	)
	var line_breaks := ts.shaped_text_get_line_breaks(
		shaped_text, 300, 0, TextServer.BREAK_MANDATORY | TextServer.BREAK_WORD_BOUND)
	#print(line_breaks)
	# ts.shaped_text_shape()
	for i in range(line_breaks.size() / 2):
		line_break_lengths.append(line_breaks[(2*i)+1] - line_breaks[2*i])
	
	var max_idx := ts.shaped_text_get_range(shaped_text)[1]
	for i in range(max_idx + 1):
		length = i
		queue_redraw()
		await get_tree().create_timer(1.0/30.0).timeout
