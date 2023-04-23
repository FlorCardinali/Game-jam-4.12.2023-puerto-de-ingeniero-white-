extends Node

var nivel = 1
var fallos = 0
var puntos = 0
var inicio
var se_reprodujo =false

func _ready():
	$musica_de_fondo.play()
	$texto_ganaste.visible = false
	$texto_perdiste.visible = false
	$Pausa.visible = false
	inicio = load("res://menu_inicio.tscn")
func _process(delta):
	#condicion de victoria
	if  puntos == 2*nivel:
		$texto_ganaste.visible = true
		get_tree().paused = true

	if fallos == 2 and not se_reprodujo:
		$perdiste.play()
		$texto_perdiste.visible = true
		get_tree().paused = true
		se_reprodujo = true

#el camion me avisa si tenia caja o no
func _on_control_camiones_puntos(punto):
	if punto == 1:
		puntos+=1
	else:
		fallos+=1

#atado con alllllaaaammbbree
func _on_musica_de_fondo_finished():
	$musica_de_fondo.play()


func _on_boton_pausa_pressed():
	$Pausa.visible = true
	get_tree().paused = true
	
#control de reanudar
func _on_reanudar_pressed():
	$Pausa.visible = false
	get_tree().paused = false


func _on_reintentar_pressed():
	se_reprodujo =false
	puntos = 0
	fallos = 0
	nivel = 1
	get_tree().paused = false
	_ready()


func _on_sig_nivel_pressed():
	puntos = 0
	fallos = 0
	nivel+=1
	get_tree().paused = false
	_ready()


func _on_salir_boton_pressed():
	get_tree().quit()


func _on_volver_perdiste_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(inicio)
	
