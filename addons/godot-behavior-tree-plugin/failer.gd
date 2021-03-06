extends "res://addons/godot-behavior-tree-plugin/bt_base.gd"

const BehvError = preload("res://addons/godot-behavior-tree-plugin/error.gd")

#Decorator node - Always returns FAILED if not running or errored
func tick(tick):
	if get_child_count() > 1:
		return BehvError.new(self, "ERROR BehaviorFailer has more than one child")

	# 0..1 children
	for c in get_children():
		var result = c._execute(tick)

		if (typeof(result) == TYPE_OBJECT and result is BehvError) or result == ERR_BUSY:
			return result

		return FAILED
