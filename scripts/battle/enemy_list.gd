extends Control

const enemy_entry_scene: PackedScene = preload("uid://novrldco8cny")

var bc: BattleController
var action: HeroAction

func close() -> void:
	bc.focus_previous()
	queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		close()

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
		entry.bc = bc
		$VBoxContainer.add_child(entry)
		entries.append(entry)
	
	entries[0].focus_neighbor_top = entries[-1].get_path()
	entries[-1].focus_neighbor_bottom = entries[0].get_path()
	
	entries[0].grab_focus.call_deferred()
