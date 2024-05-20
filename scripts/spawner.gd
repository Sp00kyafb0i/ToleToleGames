extends Node2D


@onready var obstacles = [preload("res://scenes/obstaculo_1.tscn"), preload("res://scenes/obstaculo_2.tscn")]
@onready var spawnerNode = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_SpawnTimer_timeout():
	var spawn = randf_range(0, obstacles.size())
	var scene = obstacles[spawn].instantiate()
	scene.position = spawnerNode.position
	add_child(scene)
