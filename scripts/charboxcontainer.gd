@tool
extends Container

const CHARBOX_SCENE: PackedScene = preload("uid://7r3lp84po220")

func activate(charbox_idx: int = 0) -> void:
	for i in range(get_child_count()):
		if i == charbox_idx:
			get_child(i).activate()
		else:
			get_child(i).deactivate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	make_charboxes()
	Signals.party_changed.connect(make_charboxes)

func make_charboxes() -> void:
	for child in get_children():
		child.queue_free()
	
	for party_member in PartyMember.party_list:
		var charbox := CHARBOX_SCENE.instantiate()
		charbox.party_member = party_member
		add_child(charbox)

func _notification(what: int) -> void:
	if what == NOTIFICATION_SORT_CHILDREN:
		var xpos: Array[int]
		var count := get_child_count()
		if count == 3:
			xpos = [0, 213, 426]
		elif count == 2:
			xpos = [108, 322]
		elif count == 1:
			xpos = [213]
		elif count == 0:
			return
		else:
			push_error("You have more than 3 children! IDK what to do here lol")
			return
		
		for i in range(count):
			get_child(i).position.x = xpos[i]
			get_child(i).position.y = 0.0
