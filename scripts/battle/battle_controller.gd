class_name BattleController extends Node2D
## Manages everything in a battle.

const battle_controller_scene: PackedScene = preload("uid://bsn3lnx86eo3e")
const enemy_list_scene: PackedScene = preload("uid://oj1cx36ou5oj")

var old_moveable: bool
var old_party_z: int
var old_party_positions: Array[Vector2] = []
var old_party_facings: Array[Enums.Facing] = []

var enemies: Array[Enemy] = []

@onready var charbox_container: Container = $UI/Foreground/Container

# For now, BattleController will be added as a child of Room
# because it is the most convenient.
# TODO should we add BattleController to a room like this?
static func spawn() -> BattleController:
	var bc: BattleController = battle_controller_scene.instantiate()
	var room: Room = Global.get_tree().get_first_node_in_group("room")
	room.add_child(bc)
	return bc

func get_hero_pos(idx: int, n_members: int) -> Vector2:
	const hero_x := 80.0
	var hero_y: float
	
	if n_members == 3:
		hero_y = [50.0, 130.0, 210.0][idx]
	elif n_members == 2:
		hero_y = [100, 180][idx]
	elif n_members == 1:
		hero_y = 140
	else:
		push_error("Could not find battle Y position for %d party members", n_members)
		hero_y = 140
	
	return global_position + Vector2(hero_x, hero_y)

func _ready() -> void:
	if Global.in_battle:
		queue_free()
		return
	
	Global.in_battle = true
	old_moveable = Global.moveable
	Global.moveable = false
	
	global_scale = Vector2.ONE
	global_position = WorldCamera.get_pos()
	
	var party_list := get_party_list_node()
	old_party_z = party_list.z_index
	party_list.z_index = 1000
	party_list.z_as_relative = false

	for member in PartyMember.party_list:
		old_party_positions.append(member.global_position)
		old_party_facings.append(member.facing)
	
	Signals.battle_add_enemy.connect(add_enemy)
	Signals.battle_end.connect(end_battle)
	Signals.battle_open_enemy_list.connect(open_enemy_list)
	Signals.battle_start.emit()

	battle_intro()

func get_party_list_node() -> Node2D:
	return PartyMember.party_list[0].get_parent()

func battle_intro() -> void:
	await Cutscene.run(BattleIntro.new(self))
	Signals.battle_focus_charbox.emit(PartyMember.party_list[0])

func add_enemy(enemy: Enemy) -> void:
	add_child(enemy)
	enemies.append(enemy)

func end_battle() -> void:
	await Cutscene.run(BattleOutro.new(self))
	
	Global.moveable = old_moveable
	Global.in_battle = false
	
	Signals.battle_end_end.emit()
	
	var party_list := get_party_list_node()
	party_list.z_as_relative = true
	party_list.z_index = old_party_z
	queue_free()

func open_enemy_list() -> void:
	var enemy_list: Control = enemy_list_scene.instantiate()
	enemy_list.bc = self
	$UI/Content.add_child(enemy_list)

func _process(_delta: float) -> void:
	global_position = WorldCamera.get_pos()
