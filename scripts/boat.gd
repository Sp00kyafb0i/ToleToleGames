extends RigidBody2D

class_name boat

signal healthChanged

@onready var paddle_right = $BoatCollisionShape/Player2/PaddleRight
@onready var paddle_left = $BoatCollisionShape/Player1/PaddleLeft
@onready var panel = $"../Camera2D/GameOver"

@onready var desired_stearing_left = $BoatCollisionShape/DesiredStearingLeft
@onready var desired_stearing_right = $BoatCollisionShape/DesiredStearingRight
var stearingHeadingLeft;
var stearingHeadingRight;
var stearingTorque = 10000;
var stearingForce = 1000;
var maxHp = 20
var healthPoints = 20;
var isVulnerable = true;
var countDown = 60;
var death = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	panel.visible = false
	
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

	if death and healthPoints <= 0:
		get_tree().paused = true
		self.visible = false
		panel.visible = true

	if healthPoints <= 0:
		death = true
		print("Dead")
	


func apply_stearing(direction):
	apply_torque(stearingTorque * direction)
	if direction == 1:
		apply_force(stearingHeadingLeft * stearingForce)
	else:
		apply_force(stearingHeadingRight * stearingForce)
	
func takeDamage(damage):
	healthPoints-=damage
	healthChanged.emit()
	isVulnerable = false
	print("Ouch")





