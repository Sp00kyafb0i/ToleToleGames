extends RigidBody2D

class_name boat

signal healthChanged

@onready var paddle_right = $BoatCollisionShape/Player2/PaddleRight
@onready var paddle_left = $BoatCollisionShape/Player1/PaddleLeft
@onready var a = $HowToPlay/A
@onready var d = $HowToPlay/D
@onready var panel = $"../Camera2D/GameOver"

@onready var desired_stearing_left = $BoatCollisionShape/DesiredStearingLeft
@onready var desired_stearing_right = $BoatCollisionShape/DesiredStearingRight
var stearingHeadingLeft;
var stearingHeadingRight;
var stearingTorque = 30000;
var stearingForce = 100;
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
	var tween: Tween = create_tween() 
	if direction == 1:
		apply_force(stearingHeadingLeft * stearingForce)
		tween.tween_property(d, "modulate:a", 0, 0.25)
	else:
		apply_force(stearingHeadingRight * stearingForce)
		tween.tween_property(a, "modulate:a", 0, 0.25)
	
func takeDamage(damage):
	healthPoints-=damage
	healthChanged.emit()
	isVulnerable = false
	print("Ouch")





