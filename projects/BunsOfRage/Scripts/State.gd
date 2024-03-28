@icon("res://Art/Icons/StateSprite.png")
extends Node
class_name State

#NOTE This is the State base-class, all our specific states inherits this logic
# DO NOT CHANGE THIS unless you know what you are doing
var player : CharacterBody2D
@export var animator : AnimationPlayer

signal state_transition

func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta:float):
	pass

func define_player():
	player = get_tree().get_first_node_in_group("Player")

