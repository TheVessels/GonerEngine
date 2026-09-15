class_name Actor extends CharacterBody2D
## Anyone who can be controlled
## by a cutscene.

@export var chara: Character

var sprite: AnimatedSprite2D = null

# An actor dict to store all the actors.
static var actor_dict: Dictionary[String, Actor] = {}

func _enter_tree() -> void:
	# print('NAME IS ', name, ' CHARA IS ', chara)
	actor_dict[chara.name] = self

func _exit_tree() -> void:
	if actor_dict[chara.name] == self:
		actor_dict[chara.name] = null

func _ready() -> void:
	global_scale = 2.0 * Vector2.ONE

	if sprite == null and has_node("AnimatedSprite2D"):
		sprite = get_node("AnimatedSprite2D")

	sprite.offset = chara.caterpillar_offset
	sprite.sprite_frames = chara.get_animation("")

static func get_by_name(actor_name: String) -> Actor:
	print(actor_dict)
	return actor_dict.get(actor_name)

static func get_all() -> Array[Actor]:
	return actor_dict.values()

static func exists(actor_name: String) -> bool:
	return actor_dict.has(actor_name)

# Returns the walk speed in FPS.
func calc_walk_fps(point: Vector2, time: float) -> float:
	# Supposed to be 1 for light and 2 for dark worlds
	# But we need to figure out this later
	var dw := 2
	var px_per_sec := position.distance_to(point) / time
	var speed := px_per_sec / (10 * dw)
	return clamp(speed, 7.5, 15.0)

# Set the actual FPS of the animatedsprite2d
# TODO should we actually do this? I think
# we should set the speed scale here just like Deltarune
# does. The only reason I'm not doing it is because
# it would mess with character walking.
func set_fps(fps: float):
	print('SETTING FPS TO ', fps)
	var sf: SpriteFrames = sprite.sprite_frames
	var anim_fps := sf.get_animation_speed(sprite.animation)
	sprite.speed_scale = fps / anim_fps

func walk_to_point(point: Vector2, time: float):
	var direction := point - position
	var facing: Enums.Facing = Enums.facing_from_dir(direction)
	var anim_name: String = "walk_" + Enums.facing_to_string(facing)
	sprite.play(anim_name)
	set_fps(calc_walk_fps(point, time))
	# $AnimatedSprite2D.speed_scale
	
	var tween := create_tween()
	tween.tween_property(self, "position", point, time / 30.0)
	tween.tween_callback(sprite.stop)
	await tween.finished

func get_current_texture() -> Texture2D:
	var frames: SpriteFrames = sprite.sprite_frames
	return frames.get_frame_texture(sprite.animation, sprite.frame)

func get_sprite_offset() -> Vector2:
	return sprite.offset
