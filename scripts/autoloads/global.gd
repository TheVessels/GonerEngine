extends Node

# @onready var fps_counter: Label = $FPS_COUNTER

var music_player: AudioStreamPlayer

var mus_track_position: float

var moveable := true
var in_battle := false
var battle_controller: BattleController = null

# Documentation is here:
# https://store.steampowered.com/app/1671210/DELTARUNE/
enum WorldTypes {WORLD_LIGHT, WORLD_DARK}
var world_type = WorldTypes.WORLD_DARK

#var is_fullscreen := DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN

# var border_enabled := false
#enum BorderModes {
	#DYNAMIC,
	#SIMPLE,
	#NONE
#}
#var border_mode := BorderModes.DYNAMIC
const BORDER_NONE = preload("res://sprites/borders/border_none.png")
const BORDER_SIMPLE = preload("res://sprites/borders/border_simple.png")
var current_dynamic_border: Texture2D = preload("res://sprites/borders/border_none.png")
# signal changeBorder(border_texture)

var currentRoom: Node

# change this to undefined later its 0 for testing pur's
var currentHero = 0

var tension := 0
var maxtension := 250
var asp := AudioStreamPlayer.new()

var ui_menumove := preload("res://sounds/ui/menumove.wav")

func _init() -> void:
	# Set up the music player before game is ready
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.set_script(load("res://scripts/music_player.gd"))

func _ready():
	setup_discord_rpc()

func _physics_process(_delta: float) -> void:
	#fps_counter.text = "FPS: " + str(int(Engine.get_frames_per_second()))
	pass

func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("fullscreen"):
		#toggle_fullscreen()
	if Input.is_key_pressed(KEY_F2):
		get_tree().reload_current_scene()
	mus_track_position = music_player.get_playback_position()

## Fades the opacity of the black transition screen from [param start] opacity to [param end] opacity
## in a given [param time].
## [br][br]
## [b]Note:[/b] You can use [code]await[/code] to wait for the fader to finish before the code proceeds.
## [codeblock]
## await Global.fader_fade(0.0, 1.0, 10)
##
## Global.fader_fade(1.0, 0.0, 10)
## [/codeblock]
func fader_fade(start: float, end: float, time: float) -> void:
	Signals.fadeFader.emit(start, end, time)
	await Signals.fadeEnd

## Fades the global music to a given [param gain] in a provided [param time]frame.
## [br][br]
## [b]Note:[/b] [param gain] is in linear energy.
## [codeblock]
## Global.fade_music(0.0, 20)
## [/codeblock]
func fade_music(gain: float, time: float) -> void:
	Signals.fadeMusic.emit(gain, time)

func setup_discord_rpc():
	pass
	#DiscordRPC.app_id = 1416858009635913738
	#DiscordRPC.details = 'Playing GonerEngine'
	#DiscordRPC.state = 'Somewhere in GonerEngine'
	#DiscordRPC.large_image = 'gonerenginelogo'
	#DiscordRPC.large_image_text = 'Gaster!!!'
	#DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	#DiscordRPC.refresh()

## Plays a ui sound from the 'res://sounds/ui/' directory of a given [param sound_name],
## which is provided as the file name without the file extension.
## [codeblock]
## Global.play_ui_sound("menumove")
## [/codeblock]
func play_ui_sound(sound_name: String, volume: float = 1.0) -> void:
	play_sound("ui/" + sound_name, volume)

func play_sound(sound_name: String, volume: float = 1.0) -> void:
	var stream = load("res://sounds/" + sound_name + ".wav")
	var temp_sound_player = AudioStreamPlayer.new()
	temp_sound_player.name = "StupidAudioPlayer"
	temp_sound_player.volume_linear = volume
	temp_sound_player.finished.connect(
		func():
			temp_sound_player.queue_free()
	)
	temp_sound_player.stream = stream
	add_child(temp_sound_player)
	temp_sound_player.play()

## Returns whether the current global world type defined in [member Global.world_type]
## is the dark world or not. If [member Global.world_type] is not equal to
## [member Global.WorldTypes.WORLD_DARK] (for example, it might be equal to [member Global.WorldTypes.WORLD_LIGHT]), this method will then return [code]false[/code].
## If [member Global.world_type] IS equal to [member Global.WorldTypes.WORLD_DARK], it will then
## finally return [code]true[/code], confirming that, indeed, [member Global.world_type] is currently the dark world.
## [codeblock]
## Global.is_dark()
## [/codeblock]
func is_dark() -> bool:
	return world_type == WorldTypes.WORLD_DARK

#func toggle_fullscreen():
	#if is_fullscreen:
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		#if !border_enabled:
			#get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED
			#get_window().content_scale_stretch = Window.CONTENT_SCALE_STRETCH_INTEGER
			#
			#get_window().size = Vector2(640, 480)
		#else:
			#get_window().size = Vector2(960, 540)
		#is_fullscreen = false
	#else:
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		#if !border_enabled:
			#get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
			#get_window().content_scale_stretch = Window.CONTENT_SCALE_STRETCH_FRACTIONAL
		#is_fullscreen = true
