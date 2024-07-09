extends Node2D
@export var playerTrapped : boat
@onready var top_wall = $TopWall
@onready var bottom_wall = $BottomWall

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	top_wall.position.x = playerTrapped.position.x-570
	bottom_wall.position.x = playerTrapped.position.x-570
