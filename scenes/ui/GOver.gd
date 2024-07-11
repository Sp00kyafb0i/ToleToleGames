extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$CreditsScreen.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_credits_pressed():
	$GameOverScreen.hide()
	$CreditsScreen.show()


func _on_back_pressed():
	$CreditsScreen.hide()
	$GameOverScreen.show()


func _on_lobby_pressed():
	get_tree().quit()
	
