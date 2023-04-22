extends Node

@export var camion:PackedScene 

var hay_camion = false #lo que controla que haya un solo camion
var camion_instancia #donde se guarda la copia del camion
var area_camioncito
var vector_camion = Vector2(-5,0) #velocidad a la que va el camion
signal area_del_camion(area)
signal puntos(punto)

func _process(delta):
	if not hay_camion:
		camion_instancia = camion.instantiate()
		add_child(camion_instancia)
		camion_instancia.position = Vector2(2300,250)
		hay_camion = true

	if hay_camion and $timer_camion.timeout:
		recorrer_mapa_camion(camion_instancia)
		


func recorrer_mapa_camion(par_camion):
	par_camion.move_and_collide(vector_camion)
	#detector de cajas camion
	area_camioncito = par_camion.get_node("area_camion")
	emit_signal("area_del_camion",area_camioncito)
	if area_camioncito.get_overlapping_bodies().size() == 1:
		area_camioncito.get_overlapping_bodies()[0].position = area_camioncito.global_position
	elif area_camioncito.get_overlapping_bodies().size() > 1:
		#problema, si hay mas de un objeto en el arreglo
		print("hay ams de unaaaaaaaaa")
		
	#eliminacion de camion y caja por izquierda
	if par_camion.position.x <= -400:
		if area_camioncito.get_overlapping_bodies().size() > 0:
			area_camioncito.get_overlapping_bodies()[0].queue_free() #eliminacion de caja
			emit_signal("puntos",1)
		else:
			emit_signal("puntos",0)
		par_camion.queue_free()
		hay_camion = false

