extends CharacterBody2D

@onready var boat_rigid_body = $".."
@onready var paddle_left = $PaddleLeft
@onready var paddle_right = $"../Player2/PaddleRight"



func setup(player_data: Statics.PlayerData):
	name = str(player_data.id)
	set_multiplayer_authority(player_data.id)
	

func _input(event: InputEvent) -> void:
	if is_multiplayer_authority():
		if event.is_action_pressed("test"):
			test2.rpc(Game.get_current_player().name)
		if event.is_action_pressed("GoLeft"):
			paddle_left.set_current_state(1)
			send_data.rpc(1)
		if event.is_action_released("GoLeft"):
			paddle_left.set_current_state(0)
			send_data.rpc(0)
@rpc
func test2(name):
	Debug.log("test: " + name)

@rpc
func send_data(state: int):
	paddle_left.set_current_state(state)
	
	
