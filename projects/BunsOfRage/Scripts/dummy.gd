extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_dummy_hitbox_body_entered(body):
	$sprite.color = Color("#ff0000")


func _on_dummy_hitbox_area_entered(area):
	$sprite.color = Color("#ff0000")
