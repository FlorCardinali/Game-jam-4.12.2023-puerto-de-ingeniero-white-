extends Node

@export var barco:PackedScene 
@export var caja:PackedScene
@export var camion:PackedScene

var nivel = 1
#derrota
var fallos = 0
#victoria
var puntos = 0


var vector_caja = Vector2(11,0)


func _ready():
	pass
	


func _process(delta):
	
	#condicion de victoria
	if  puntos >= 2*nivel:
		nivel+=1
		$Ganaste.visible = true
#		get_tree().paused

