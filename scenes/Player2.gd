
extends CharacterBody2D


@onready var boat_rigid_body = $".."
@onready var paddle_right = $PaddleRight
@onready var paddle_left = $"../Player1/PaddleLeft"

var pos_1
var rot_1
var role


func setup(player_data: Statics.PlayerData):
	name = str(player_data.id)
	role = player_data.role
	set_multiplayer_authority(player_data.id)

func _physics_process(_delta):
	if get_multiplayer_authority() == 1:
		pos_1 = boat_rigid_body.position
		rot_1 = boat_rigid_body.rotation
		send_pos.rpc(pos_1,rot_1)
	
func _input(event: InputEvent) -> void:
	if is_multiplayer_authority():
		if get_multiplayer_authority() != 1:
			Debug.log("cliente derecha")
			if event.is_action_pressed("GoRight"):	
				send_data.rpc(1)
			if event.is_action_released("GoRight"):
				send_data.rpc(0)
		else:
			Debug.log("server derecha")
			if event.is_action_pressed("GoRight"):
				paddle_right.set_current_state(1)
			if event.is_action_released("GoRight"):
				paddle_right.set_current_state(0)


func test2(name):
	Debug.log("test: " + name)

@rpc
func send_data(state: int):
	paddle_right.set_current_state(state)

@rpc
func send_pos(pos,rot):
	boat_rigid_body.position = pos
	boat_rigid_body.rotation = rot



