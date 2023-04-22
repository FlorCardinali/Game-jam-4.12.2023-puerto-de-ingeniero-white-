extends Node

@export var barco:PackedScene 
@export var caja:PackedScene
@export var camion:PackedScene

var nivel = 1
#derrota
var fallos = 0
#victoria
var puntos = 0


#barco
var barco_instancia
var hay_barco = false
var vector_barco = Vector2(10,0)
var vector_caja = Vector2(11,0)
var colision_barco
#caja
var caja_instancia
#camion
var camion_instancia #donde se guarda la copia del camion
var hay_camion = false #lo que controla que haya un solo camion
var colision_camion #donde se guarda el movimiento del camion
var vector_camion = Vector2(-5,0) #velocidad a la que va el camion
var area_camioncito



func _ready():
	pass
	

func cuando_se_suelta_la_caja(cajita):
	#control de posicionamiento de cajas en areas de descanso
	if  $area_1.get_overlapping_bodies().size() > 0:
		if $area_1.get_overlapping_bodies().size() > 1:
			$area_1.get_overlapping_bodies()[1].queue_free()
		$area_1.get_overlapping_bodies()[0].position = $area_1.position
	
	if $area_2.get_overlapping_bodies().size() > 0:
		if $area_2.get_overlapping_bodies().size() > 1:
			$area_2.get_overlapping_bodies()[1].queue_free()
		$area_2.get_overlapping_bodies()[0].position = $area_2.position
	
	if $area_3.get_overlapping_bodies().size() > 0:
		if $area_3.get_overlapping_bodies().size() > 1:
			$area_3.get_overlapping_bodies()[1].queue_free()
		$area_3.get_overlapping_bodies()[0].position = $area_3.position
	
	
	#control de eliminacion de caja por mala posicion
	if (cajita.position != $area_1.position) and (cajita.position != $area_2.position) and (cajita.position != $area_3.position and (cajita.position != area_camioncito.global_position)):
		print("cajita no esta donde debe estar")
		$explocion.stop()
		$explocion.global_position = cajita.global_position
		$explocion.visible = true
		$explocion.play()
		cajita.queue_free()
	

func _process(delta):
	
	#condicion de victoria
	if  puntos >= 2*nivel:
		nivel+=1
		$Ganaste.visible = true
#		get_tree().paused
		
	
	
	#creador de camiones
	if not hay_camion:
		camion_instancia = camion.instantiate()
		add_child(camion_instancia)
		camion_instancia.position = Vector2(2300,250)
		hay_camion = true

	if hay_camion and $Timer_general.timeout:
		recorrer_mapa_camion(camion_instancia)
		
	#creador de barcos y cajas
	if not hay_barco:
		barco_instancia = barco.instantiate()
		add_child(barco_instancia)
		barco_instancia.position = Vector2(-800,750)
		
		caja_instancia = caja.instantiate()
		add_child(caja_instancia)
		caja_instancia.position = Vector2(-450,780)
		caja_instancia.connect("se_solto_la_caja", cuando_se_suelta_la_caja)
		
		hay_barco = true

	if hay_barco and $Timer_general.timeout:
		recorrer_mapa_barco(barco_instancia, caja_instancia)


func recorrer_mapa_camion(par_camion):
	
	colision_camion = par_camion.move_and_collide(vector_camion)
	
	#detector de cajas camion
	area_camioncito = par_camion.get_node("area_camion")
	if area_camioncito.get_overlapping_bodies().size() == 1:
		area_camioncito.get_overlapping_bodies()[0].position = area_camioncito.global_position
	elif area_camioncito.get_overlapping_bodies().size() > 1:
		#problema, si hay mas de un objeto en el arreglo
		print("hay ams de unaaaaaaaaa")
		
	#eliminacion de camion y caja por izquierda
	if par_camion.position.x <= -400:
		if area_camioncito.get_overlapping_bodies().size() > 0:
			area_camioncito.get_overlapping_bodies()[0].queue_free() #eliminacion de caja
			#contado de puntos
			puntos += 1
			print("puntos: ", puntos)
		else:
			fallos+=1
			print("fallos: ", fallos)
		par_camion.queue_free()
		hay_camion = false


func recorrer_mapa_barco(barco, caja):
	
	colision_barco = barco.move_and_collide(vector_barco)
	
	#eliminacion del barco
	if barco.position.x >= 2500:
		barco.queue_free()
		hay_barco= false
	#control de seguimiento caja a barco
	if colision_barco!=null:
		if colision_barco.get_collider().is_in_group("cajas") and caja.position.x <= 1930:
			caja.empujar(vector_caja)
		#eliminacion de la caja por derecha
		elif caja.position.x >= 1930:
			caja.queue_free()

#animacion de explocion
func _on_explocion_animation_finished():
	$explocion.stop()
	$explocion.visible = false
