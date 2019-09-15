extends Control

func show_ghost(polymino):
	if is_valid_placement(polymino):
		# TODO: Green visual
		pass
	else:
		# TODO: Red visual
		pass

# Merge the given polymino with the player city
# Return false on failed merge and does not modify anything in that case
func merge(polymino):
	if is_valid_placement(polymino):
		# TODO: Do the merge
		return true
	else:
		return false

func is_valid_placement(polymino):
	# TODO: Implement
	return false