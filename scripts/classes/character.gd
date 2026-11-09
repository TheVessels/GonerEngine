class_name Character extends Resource
## A Resource for storing the info for a character.
##
## In Deltarune, examples of Characters include
## Kris, Susie, Ralsei, Noelle, Queen, Flowery, Tasque, Nubert, etc.

@export var name: String
@export var caterpillar_offset: Vector2

@export var states: Dictionary[String, SpriteFrames]

# TODO this should be an extended class, but it's gonna be like this for now.
## These properties are used for party members in GonerEngine.
@export_group("Party Member")
## The color shown in the menu and in battle.
@export var color: Color
## The texture for the character's name, shown in the menu and in battle.
@export var name_image: Texture2D
## The default stats for the character (HP, ATK, etc.).
@export var default_stats: CharacterStats

@export_subgroup("Additional Colors")
@export var attack_background_color: Color = color
@export var attack_target_color: Color = color

@export_subgroup("Battle Heads", "battle_head_")
## The head texture shown in the menu and in battle.
@export var battle_head_normal: Texture2D
## The head shown when hit in battle.
@export var battle_head_hurt: Texture2D
## The head shown when attacking in battle.
@export var battle_head_attack: Texture2D
## The head shown when acting in battle.
@export var battle_head_act: Texture2D
## The head shown when using magic in battle (unused for Kris).
@export var battle_head_magic: Texture2D
## The head shown when using an item in battle.
@export var battle_head_item: Texture2D
## The head shown when sparing in battle.
@export var battle_head_spare: Texture2D
## The head shown when defending in battle.
@export var battle_head_defend: Texture2D

# @export var animation: SpriteFrames

# `state` is blank for default state.
func get_animation(state: String) -> SpriteFrames:
	var suffix := "" if state == "" else "_" + state
	var worldtype_str := "dark" if Global.is_dark() else "light"
	if states.has(worldtype_str + suffix):
		return states.get(worldtype_str + suffix)
	elif states.has(state):
		return states.get(state)
	else:
		return states.get(states.keys()[0])
