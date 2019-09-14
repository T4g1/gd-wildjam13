extends Node2D
class_name Bloc

signal consume
signal produce

export(int) var production := 2
export(int) var consumption := 1
export(int, "FOOD","IRON","WATER") var prod_type: int = 0

var active := false
  
func _ready():
  pass

func consume_and_produce():
  for res_type in range(0, 3):
    if res_type == prod_type:
      emit_signal("produce", res_type, production)
    else:
      emit_signal("consume", res_type, consumption)
  