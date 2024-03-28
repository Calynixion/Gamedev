extends Node2D
signal got_angry(character_id)

var rng = RandomNumberGenerator.new()

@export var id = 0

var is_angry = false
var order = [rng.randi_range(1, 4), rng.randi_range(1, 4), rng.randi_range(1, 4)]
var time = rng.randi_range(30, 120)
var done = false
var healed = false

@onready var anger_timer = $anger_timer


func _ready():
	anger_timer.wait_time = time
	anger_timer.start()


func _on_anger_timer_timeout():
	if done == false:
		is_angry = true
	got_angry.emit(id)
	anger_timer.stop()
