class_name HeroAction extends RefCounted
## Used to store what action a hero will perform during the battle.

class Attack extends HeroAction:
	var target_enemy: Enemy
class Act extends HeroAction:
	pass
class Item extends HeroAction:
	pass
class Spare extends HeroAction:
	pass
class Defend extends HeroAction:
	pass
