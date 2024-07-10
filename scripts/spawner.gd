extends Node2D

@export var player: boat
@export var camera: Node2D
@onready var obstacles = [preload("res://scenes/obstaculo_1.tscn"), preload("res://scenes/obstaculo_2.tscn")]
@onready var spawnerNode = get_parent()
@onready var counter = 0
@onready var spawn = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_SpawnTimer_timeout():
	if counter == 0:
		spawn = randf_range(0, obstacles.size())
		counter = 1
	else:
		var scene = obstacles[spawn].instantiate()
		scene.position = self.global_position
		Debug.log(self.global_position)
		spawnerNode.add_child(scene)
		counter = 0
