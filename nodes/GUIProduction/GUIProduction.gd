extends GridContainer

func set_food(value):
	$Food.update_total(0)
	$Food.update_diff(value)

func set_wood(value):
	$Wood.update_total(0)
	$Wood.update_diff(value)

func set_rock(value):
	$Rock.update_total(0)
	$Rock.update_diff(value)

func set_gold(value):
	$Gold.update_total(0)
	$Gold.update_diff(value)