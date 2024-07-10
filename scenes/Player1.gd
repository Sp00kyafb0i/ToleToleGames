extends CharacterBody2D

@onready var boat_rigid_body = $"../.."
@onready var paddle_left = $PaddleLeft
@onready var paddle_right = $"../Player2/PaddleRight"
var pos_1
var rot_1
var paddle_rot1
var paddle_rot2
var role


func setup(player_data: Statics.PlayerData):
	name = str(player_data.id)
	role = player_data.role
	set_multiplayer_authority(player_data.id)
	
func _physics_process(_delta):
	if get_multiplayer_authority() == 1:
		pos_1 = boat_rigid_body.position
		rot_1 = boat_rigid_body.rotation
		paddle_rot1 = paddle_left.rotation
		paddle_rot2 = paddle_right.rotation
		send_pos.rpc(pos_1,rot_1,paddle_rot1,paddle_rot2)
		

func _input(event: InputEvent) -> void:
	if is_multiplayer_authority():
		if get_multiplayer_authority() == 1:

			if event.is_action_pressed("GoLeft"):
				paddle_left.set_current_state(1)
			if event.is_action_released("GoLeft"):
				paddle_left.set_current_state(0)
		else:
		
			if event.is_action_pressed("GoLeft"):	
				send_data.rpc(1)
			if event.is_action_released("GoLeft"):
				send_data.rpc(0)
			
@rpc
func test2(name):
	Debug.log("test: " + name)

@rpc
func send_data(state: int):
	paddle_left.set_current_state(state)
		
@rpc
func send_pos(pos,rot,paddle_rot1,paddle_rot2):
	boat_rigid_body.position = pos
	boat_rigid_body.rotation = rot
	paddle_left.rotation = paddle_rot1
	paddle_right.rotation = paddle_rot2
