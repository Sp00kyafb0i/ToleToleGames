extends Camera2D
@export var boatBeingFollowed :boat

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = max(590,boatBeingFollowed.global_position.x)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_instance_valid(boatBeingFollowed)):
		position.x = max(590,boatBeingFollowed.global_position.x)
