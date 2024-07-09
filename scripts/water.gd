extends Node
@onready var camera_2d = $"../Camera2D"
@export var boat:boat
var value:float = 0.0;
@export var escalaGlobal:float;

# Called when the node enters the scene tree for the first time.
func _ready():
	if (is_instance_valid(boat)):
		boat.healthChanged.connect(update)
		update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var screenSize =  get_viewport().get_visible_rect().size
	var screenCenter = screenSize/2
	if (is_instance_valid(boat)):
		camera_2d.global_position.x = boat.global_position.x
		self.position.x = clamp(camera_2d.global_position.x,camera_2d.limit_left,camera_2d.limit_right-screenSize.x);
		self.position.y = clamp(camera_2d.global_position.y,camera_2d.limit_top,camera_2d.limit_bottom-screenSize.y);
	else:
		self.position.x = 0
		self.position.y = 0
	self.position -= screenCenter;
	self.material.set_shader_parameter("cameraPosition",self.position)
	self.material.set_shader_parameter("screenSize",self.scale*self.texture.get_size())
	self.material.set_shader_parameter("waterSpeed",Vector2(0.072,0.03))
	self.material.set_shader_parameter("damage",value)
	self.material.set_shader_parameter("escalaGlobal",escalaGlobal)
	


func update():
	if (is_instance_valid(boat)):
		value = 1.0 - float(boat.healthPoints)/boat.maxHp
