extends RigidBody2D

var damage = 5
var speed = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x -= speed*delta
	if self.position.x < -3000:
		self.free()


func _on_body_entered(body):
	print("Body entered")
	if body.is_in_group("Boat") and body.isVulnerable:
		body.takeDamage(damage)
