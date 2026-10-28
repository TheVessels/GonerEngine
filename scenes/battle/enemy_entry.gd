@tool
extends SoulButton

var enemy: Enemy = null

func _ready() -> void:
	super._ready()
	
	if enemy != null:
		text = enemy.chara.name
		$HPBar.value = 100.0 * enemy.get_hp()
		$MercyBar.value = 100.0 * enemy.get_mercy()
