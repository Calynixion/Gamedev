extends Area2D

@export var speed = 400
var screen_size
var direction

@onready var animator = $animator
@onready var attack_hitbox = $attack/attack_hitbox
@onready var attack_sprite = $attack/attack_sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$attack.monitorable = false
	attack_hitbox.disabled = true
	attack_sprite.visible = false

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if Input.is_action_just_pressed("action_1"):
		animator.play("attack")

