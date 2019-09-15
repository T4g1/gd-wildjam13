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
	# Compute upper left corner position of city (position is in the center of the grid)
	var city_size = $Grid.grid_size * $Grid.cell_size
	var upper_left = get_global_position() - (city_size / 2)
	
	# Compute upper left corner position of polymino (position is in the center of the grid)
	var polymino_size = polymino.TETROMINO_SIZE * $Grid.cell_size
	var polymino_upper_left = polymino.get_global_position() - (polymino_size / 2)
	
	# At which cells is the most upper-left cell of the polymino 
	var delta = polymino_upper_left - upper_left
	var cell_position = (delta / $Grid.cell_size).floor()
	
	print(cell_position)
	
	return false