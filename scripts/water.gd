extends Node
@onready var camera_2d = $"../Camera2D"
@onready var boat = $"../Boat"
var value:float = 0.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	boat.healthChanged.connect(update)
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var screenSize =  get_viewport().get_visible_rect().size
	var screenCenter = screenSize/2
	
	camera_2d.global_position.x = boat.global_position.x

	self.position.x = clamp(camera_2d.global_position.x,camera_2d.limit_left,camera_2d.limit_right-screenSize.x);
	self.position.y = clamp(camera_2d.global_position.y,camera_2d.limit_top,camera_2d.limit_bottom-screenSize.y);
	
	self.position -= screenCenter;
	self.material.set_shader_parameter("cameraPosition",self.position)
	self.material.set_shader_parameter("screenSize",self.scale*self.texture.get_size())
	self.material.set_shader_parameter("waterSpeed",Vector2(0.072,0.03))
	self.material.set_shader_parameter("damage",value)


func update():
	value = 1.0 - float(boat.healthPoints)/boat.maxHp
