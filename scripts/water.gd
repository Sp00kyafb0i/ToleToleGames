extends Node
@onready var camera_2d = $"../Boat/Camera2D"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var screenSize =  get_viewport().get_visible_rect().size
	var screenCenter = screenSize/2

	self.position.x = clamp(camera_2d.global_position.x,camera_2d.limit_left,camera_2d.limit_right-screenSize.x);
	self.position.y = clamp(camera_2d.global_position.y,camera_2d.limit_top,camera_2d.limit_bottom-screenSize.y);
	
	self.position -= screenCenter;
	self.material.set_shader_parameter("cameraPosition",self.position)
	self.material.set_shader_parameter("screenSize",self.scale*self.texture.get_size())
	self.material.set_shader_parameter("waterSpeed",Vector2(0.072,0.03))

