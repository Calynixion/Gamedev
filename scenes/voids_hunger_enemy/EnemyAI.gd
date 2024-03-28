extends CharacterBody2D

var Type
var Hp
var Speed
var Points_given
var Challenge = 0
var direction
var rand=RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize()
	if (rand.randi_range(Challenge,15) <= 10):
		Type = "Basic"
		Hp = 10
		Speed = 1.0
		Points_given = 1
	else:
		Type = "Armored"
		Hp = 30
		Speed = .5
		Points_given = 2
	rand.randomize()
	if (rand.randi_range(0,1) == 1):
		direction = 1
	else:
		direction = -1
	print(direction);
	if (direction == 1):
		position.x = 0
	if (direction == -1):
		position.x = 1150
	position.y = rand.randi_range(10,400) #Remeber to change this based on how big the black hole is.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
