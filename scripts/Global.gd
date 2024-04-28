extends Node

var score = 0
var frames = 0
# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frames +=1
	if (frames == 60):
		score += 10
		frames = 0
