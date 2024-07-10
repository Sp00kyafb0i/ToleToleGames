extends ProgressBar
@export var player: boat
@onready var node_2d = $Node2D

# Called when the node enters the scene tree for the first time.

func _ready():
	player.healthChanged.connect(update)
	update()
	
func update():
	value = player.healthPoints*100/player.maxHp
	node_2d.scale.x=value/100
