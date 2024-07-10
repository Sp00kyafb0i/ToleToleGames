extends Sprite2D
const BLACKHOLE_RIM_2 = preload("res://resources/BlackholeRim2.png")
const BLACKHOLE_RIM_2_2 = preload("res://resources/BlackholeRim_2_2.png")
const BLACKHOLE_RIM_3_2 = preload("res://resources/BlackholeRim_3_2.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	if (randf() > 0.33):
		texture = BLACKHOLE_RIM_2
	elif (randf() > 0.66):
		texture = BLACKHOLE_RIM_2_2
	else:
		texture = BLACKHOLE_RIM_3_2
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
