tool
extends Control
class_name ConsumeBar

var SIZE := 64
var value : float = 0.1

func _ready():
	pass
	
func update_value(v: float):
	value = v
	update()
	
func _draw():
	draw_circle_arc_poly(Vector2(SIZE / 2, SIZE / 2),
	SIZE/ 2,
	0, 360 - 360 * value,
	Color(1,1,1,0.7))

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])

	for i in range(nb_points + 1):
			var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
			points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)