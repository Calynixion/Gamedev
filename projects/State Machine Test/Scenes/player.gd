class_name Player
extends CharacterBody2D

var speed := 200.0
var jump_impulse := 600.0
var gravity := 3000.0

func _ready():
	$animator.play("idle")
