extends Sprite2D
@onready var boatToMove = $"../.."

var padSpeed=0.1;
var padRepositionSpeed=0.1;

var padMaxAngle = 2.3;
var padMinAngle = 0.3;

var moving = false;
var rotationSense;
var current_state = 0;
	
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
		
		
func set_current_state(state):
	current_state = state
	
func getInput():
	if current_state == 1:
		movePaddle()
	if current_state == 0:				
		letGoPaddle()
			
func movePaddle():
	moving = true;

func letGoPaddle():
	moving = false;

	
