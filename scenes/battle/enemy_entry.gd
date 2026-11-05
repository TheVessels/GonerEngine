@tool
extends SoulButton

var enemy: Enemy = null
var bc: BattleController
@onready var enemy_list: Control = get_node("../../")

func _ready() -> void:
	super._ready()
	
	if enemy != null:
		text = enemy.chara.name
		$HPBar.value = 100.0 * enemy.get_hp()
		$MercyBar.value = 100.0 * enemy.get_mercy()

func _on_pressed() -> void:
	var action: HeroAction = enemy_list.action
	if action is HeroAction.Attack:
		(action as HeroAction.Attack).target_enemy = enemy
	
	bc.set_current_hero_action(action)
	enemy_list.close()

func _on_focus_entered() -> void:
	enemy.set_flash(true)


func _on_focus_exited() -> void:
	enemy.set_flash(false)
