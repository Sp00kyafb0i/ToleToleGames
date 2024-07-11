extends Node2D

@onready var a = $A
@onready var d = $D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	var tween: Tween = create_tween() 
	tween.tween_property(a, "modulate:a", 0, 0.25)
	tween.tween_property(d, "modulate:a", 0, 0.25)
