extends Node2D
@export var main:PackedScene


func _ready():
	pass

func _process(delta):
	pass

func _on_play_pressed():
	get_tree().change_scene_to_packed(main)

	
