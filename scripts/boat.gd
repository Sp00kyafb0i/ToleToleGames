extends RigidBody2D

@onready var paddle_left = $PaddleLeft
@onready var paddle_right = $PaddleRight

@onready var desired_stearing_left = $DesiredStearingLeft
@onready var desired_stearing_right = $DesiredStearingRight
var stearingHeadingLeft;
var stearingHeadingRight;
var stearingTorque = 30000;
var stearingForce = 100;
var healthPoints = 10;
var isVulnerable = true;
var countDown = 60;



# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (countDown > 0):
		countDown -= 1
	elif (countDown == 0):
		isVulnerable = true
		countDown = 60
	stearingHeadingLeft = (desired_stearing_left.global_position-global_position).normalized()
	stearingHeadingRight = (desired_stearing_right.global_position-global_position).normalized()
	
	if Input.is_action_just_pressed("GoLeft"):
		paddle_left.movePaddle()
	if Input.is_action_just_released("GoLeft"):
		paddle_left.letGoPaddle()
		
	if Input.is_action_just_pressed("GoRight"):
		paddle_right.movePaddle()
	if Input.is_action_just_released("GoRight"):
		paddle_right.letGoPaddle()
	if healthPoints <= 0:
		print("Dead")

func apply_stearing(direction):
	apply_torque(stearingTorque * direction)
	if direction == 1:
		apply_force(stearingHeadingLeft * stearingForce)
	else:
		apply_force(stearingHeadingRight * stearingForce)
	
func takeDamage(damage):
	healthPoints-=damage
	isVulnerable = false
	print("Ouch")
