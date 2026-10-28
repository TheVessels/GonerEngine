extends Control

const enemy_entry_scene: PackedScene = preload("uid://novrldco8cny")

var bc: BattleController

func _ready() -> void:
	if bc == null:
		$VBoxContainer.get_child(0).grab_focus.call_deferred()
		return
	
	for child in $VBoxContainer.get_children():
		child.free()

	var entries := []
	for enemy in bc.enemies:
		var entry := enemy_entry_scene.instantiate()
		entry.enemy = enemy
		$VBoxContainer.add_child(entry)
		entries.append(entry)
	
	entries[0].focus_neighbor_top = entries[-1].get_path()
	entries[-1].focus_neighbor_bottom = entries[0].get_path()
	
	entries[0].grab_focus.call_deferred()
