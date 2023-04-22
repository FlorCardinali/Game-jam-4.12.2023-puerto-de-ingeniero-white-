extends Node

var nivel = 1
var fallos = 0
var puntos = 0

func _ready():
	pass
	
func _process(delta):
	#condicion de victoria
	if  puntos >= 1:
		nivel+=1
		$Ganaste.visible = true
		get_tree().paused = true


func _on_control_camiones_puntos(punto):
	if punto == 1:
		puntos+=1
	else:
		fallos+=1
