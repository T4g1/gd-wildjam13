extends Timer
class_name ResourcesTimer

export(float) var base_delay := 6.0
export(float) var min_delay := 0.7
export(float) var acc := 0.9

func _ready():
	init()
	
func init():
	wait_time = base_delay

func speed_up():
	stop()
	wait_time = max(min_delay, wait_time * acc)
	start()

