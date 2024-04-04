extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.material.set_shader_parameter("size",self.scale*self.texture.get_size())
	self.material.set_shader_parameter("as",self.scale)
	self.material.set_shader_parameter("waterSpeed",Vector2(0.072,0.1))
