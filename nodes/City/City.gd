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
	var cell_position = get_cell_position(polymino)
	
	# Check placement
	var is_valid = true
	for x in range(polymino.TETROMINO_SIZE):
		for y in range(polymino.TETROMINO_SIZE):
			if !polymino.get_node("Grid").is_free(x, y):
				var city_position = Vector2(cell_position.x + x, cell_position.y + y)
				if city_position.x >= 0 and  \
					city_position.x < $Grid.grid_size and \
					city_position.y >= 0 and  \
					city_position.y < $Grid.grid_size:
					is_valid = is_valid and $Grid.is_free(cell_position.x + x, cell_position.y + y)
				else:
					is_valid = false
	
	if is_valid:
		print("valid")
	else:
		print("not valid")
		
	return is_valid

# At which cells over the city is the most upper-left cell of the polymino 
func get_cell_position(polymino):
	# Compute upper left corner position of city (position is in the center of the grid)
	var city_size = $Grid.grid_size * $Grid.cell_size
	var upper_left = get_global_position() - (city_size / 2)
	
	# Compute upper left corner position of polymino (position is in the center of the grid)
	var polymino_size = polymino.TETROMINO_SIZE * $Grid.cell_size
	var polymino_upper_left = polymino.get_global_position() - (polymino_size / 2)
	
	var delta = polymino_upper_left - upper_left
	
	return (delta / $Grid.cell_size).floor()