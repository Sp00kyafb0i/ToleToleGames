extends Node2D

@onready var boat = $Boat


func _ready(): 
	var paddle_left = boat.get_child(1)
	var paddle_right = boat.get_child(2)
	for player_data in Game.players:
		if player_data.role == Statics.Role.ROLE_A:
			paddle_left.setup(player_data)
		if player_data.role == Statics.Role.ROLE_B:
			paddle_right.setup(player_data)
	
