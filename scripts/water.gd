extends Node
@onready var camera_2d = $"../Boat/Camera2D"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var screenCenter = get_viewport().get_visible_rect().size/2;
	self.position = camera_2d.global_position-screenCenter;
	self.material.set_shader_parameter("cameraPosition",self.position)
	self.material.set_shader_parameter("screenSize",self.scale*self.texture.get_size())
	self.material.set_shader_parameter("waterSpeed",Vector2(0.072,0.1))
	self.material.set_shader_parameter("gridSize",70)
