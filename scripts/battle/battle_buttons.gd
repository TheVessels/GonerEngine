extends HBoxContainer

@onready var charbox: Control = get_node("../")

var last_focused: Control = null

func activate() -> void:
	$Fight.grab_focus.call_deferred()

#func _ready():
#	for child: TextureButton in get_children():
#		child.focus_exited.connect(func(): Global.play_ui_sound('menumove'))
#		child.pressed.connect(func(): Global.play_ui_sound('select'))

func _ready():
	for child: TextureButton in get_children():
		child.focus_exited.connect(
			func():
				last_focused = child
		)
		child.focus_entered.connect(
			func():
				if last_focused != null:
					Global.play_ui_sound("menumove")
		)
		child.pressed.connect(func(): Global.play_ui_sound("select"))
	
	Signals.battle_focus_charbox.connect(
		func(pm: PartyMember):
			if charbox.party_member == pm:
				activate()
	)

func _process(_delta: float) -> void:
	last_focused = null

func _on_fight_pressed() -> void:
	#Signals.battle_open_enemy_list.emit()
	#var enemy: Enemy = await Signals.battle_enemy_chosen
	var action := HeroAction.Attack.new()
	Global.battle_controller.last_focused = $Fight
	Global.battle_controller.open_enemy_list(charbox.get_index(), action)

func _on_act_tech_pressed() -> void:
	pass # Replace with function body.

func _on_item_pressed() -> void:
	pass # Replace with function body.

func _on_spare_pressed() -> void:
	pass # Replace with function body.

func _on_defend_pressed() -> void:
	var current_pm_idx := PartyMember.party_list.find(charbox.party_member)
	var next_pm_idx := current_pm_idx + 1
	if next_pm_idx > PartyMember.party_list.size() - 1:
		Signals.battle_end.emit()
	else:
		Signals.battle_focus_charbox.emit(PartyMember.party_list[next_pm_idx])
