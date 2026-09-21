extends Node
@warning_ignore_start("unused_signal")

# Custom global signals for GonerEngine
# TODO PLEASE make the casing consistent!
signal changeMusic(music, gain, pitch)
signal changeRoom(room, instantiate: bool)
signal room_change_finished
signal warpParty(marker_id, facing)
signal changeBorder(border_texture, fade_frames)
signal ToggleBorder(enable)
signal toggleMenu()
signal fadeMusic(gain, time)
signal startDialogue(text)
signal fadeFader(start, end, time)
signal fadeEnd

## Emitted when the party is changed (members are added, removed, or reordered).
signal party_changed

# For battle
signal battle_start
## To start the battle ending animation.
signal battle_end
## Emitted once the battle has actually ended.
signal battle_end_end
signal battle_focus_charbox(party_member: PartyMember)
## Emitted to open EnemyList.
signal battle_open_enemy_list
## Emitted when an enemy has been chosen.
signal battle_enemy_chosen(enemy: Enemy)
signal battle_open_hero_list
signal battle_hero_chosen
signal battle_set_hero_action(party_member: PartyMember, action: HeroAction)

# For dialogue
signal change_face
signal change_voice
signal change_typer_char
