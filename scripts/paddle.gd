extends Sprite2D
@export var boatToMove: RigidBody2D
var padSpeed=0.1;
var padRepositionSpeed=0.1;

var padMaxAngle = 2.3;
var padMinAngle = 0.3;

var moving = false;
var rotationSense;

# Called when the node enters the scene tree for the first time.
func _ready():
	rotationSense = (float(flip_v)-0.5)*2;
	padSpeed *=rotationSense;
	padRepositionSpeed *=rotationSense;

func _physics_process(delta):
	if moving:
		if rotation * rotationSense < padMaxAngle:
			rotate(padSpeed)
			boatToMove.apply_stearing(rotationSense)
		else:
			moving = false
	elif (rotation*rotationSense > padMinAngle):
		rotate(-padRepositionSpeed);
		
func movePaddle():
	moving = true;

func letGoPaddle():
	moving = false;
