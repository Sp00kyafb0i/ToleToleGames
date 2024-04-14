extends RigidBody2D

@onready var paddle_right = $Player2/PaddleRight
@onready var paddle_left = $Player1/PaddleLeft


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
	
	paddle_left.getInput()
	paddle_right.getInput()

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





