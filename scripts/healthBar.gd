extends ProgressBar
@export var player: boat

# Called when the node enters the scene tree for the first time.

func _ready():
	player.healthChanged.connect(update)
	update()
func update():
	value = player.healthPoints*100/player.maxHp
