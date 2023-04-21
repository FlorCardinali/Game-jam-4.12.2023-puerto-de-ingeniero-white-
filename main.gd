extends Node

@export var barco:PackedScene 
@export var caja:PackedScene
@export var camion:PackedScene

var escena_caja = load("res://caja.tscn")
var nivel = 1
var puntos = 0

#barco
var barco_instancia
var hay_barco = false
var vector_barco = Vector2(10,0)
var vector_caja = Vector2(11,0)
var colision_barco
 #caja
var caja_instancia
var cant_cajas = 0
#camion
var camion_instancia #donde se guarda la copia del camion
var hay_camion = false #lo que controla que haya un solo camion
var colision_camion #donde se guarda el movimiento del camion
var vector_camion = Vector2(-7,0) #velocidad a la que va el camion
var area_camioncito

func _ready():
	pass

func cuando_se_suelta_la_caja(cajita):
	if  $area_1.get_overlapping_bodies().size() > 0:
#		print("area 1: ",$area_1.get_overlapping_bodies())
		if $area_1.get_overlapping_bodies().size() > 1:
			$area_1.get_overlapping_bodies()[1].queue_free()
		$area_1.get_overlapping_bodies()[0].position = $area_1.position
	
	if $area_2.get_overlapping_bodies().size() > 0:
#		print("area 2:", $area_2.get_overlapping_bodies())
		if $area_2.get_overlapping_bodies().size() > 1:
			$area_2.get_overlapping_bodies()[1].queue_free()
		$area_2.get_overlapping_bodies()[0].position = $area_2.position
	
	if $area_3.get_overlapping_bodies().size() > 0:
#		print("area 3: ", $area_3.get_overlapping_bodies())
		if $area_3.get_overlapping_bodies().size() > 1:
			$area_3.get_overlapping_bodies()[1].queue_free()
		$area_3.get_overlapping_bodies()[0].position = $area_3.position
	
	
	
	if (cajita.position != $area_1.position) and (cajita.position != $area_2.position) and (cajita.position != $area_3.position and (cajita.position != area_camioncito.global_position)):
		print("cajita no esta donde debe estar")
		cajita.queue_free()
	

func _process(delta):
#	if  get_tree().get_nodes_in_group("cajas").size() > 0:
#		cant_cajas = get_tree().get_nodes_in_group("cajas").size()
		
	
	if not hay_camion:
		camion_instancia = camion.instantiate()
		add_child(camion_instancia)
		camion_instancia.position = Vector2(2300,250)
		hay_camion = true

	if hay_camion and $Timer_general.timeout:
		recorrer_mapa_camion(camion_instancia)
	
	if not hay_barco:
		barco_instancia = barco.instantiate()
		add_child(barco_instancia)
		barco_instancia.position = Vector2(-800,750)
		
		caja_instancia = caja.instantiate()
		cant_cajas += 1
		add_child(caja_instancia)
		caja_instancia.position = Vector2(-450,780)
		caja_instancia.connect("se_solto_la_caja", cuando_se_suelta_la_caja)
		
		
		hay_barco = true

	if hay_barco and $Timer_general.timeout:
		recorrer_mapa_barco(barco_instancia, caja_instancia)


func recorrer_mapa_camion(par_camion):
	colision_camion = par_camion.move_and_collide(vector_camion)
	area_camioncito = par_camion.get_node("area_camion")
#	print(area_camioncito.global_position)
	if area_camioncito.get_overlapping_bodies().size() > 0:
		if area_camioncito.get_overlapping_bodies()[0].name == "caja" or area_camioncito.get_overlapping_bodies()[0].name == ("@caja@"+ str(cant_cajas)):
			area_camioncito.get_overlapping_bodies()[0].position = area_camioncito.global_position
		print(area_camioncito.get_overlapping_bodies())
	elif area_camioncito.get_overlapping_bodies().size() > 1:
		#problema, si hay mas de un objeto en el arreglo
		print("hay ams de unaaaaaaaaa")
		print(area_camioncito.get_overlapping_bodies())
	
	if par_camion.position.x <= -400:
		if area_camioncito.get_overlapping_bodies().size() > 0:
			area_camioncito.get_overlapping_bodies()[0].queue_free() #eliminacion de caja
			puntos += 1
			print(puntos)
		par_camion.queue_free()
		hay_camion = false


func recorrer_mapa_barco(barco, caja):
	colision_barco = barco.move_and_collide(vector_barco)
#	print(barco.position)
	if barco.position.x >= 2500:
		barco.queue_free()
		hay_barco= false

	if colision_barco!=null:
		if colision_barco.get_collider().is_in_group("cajas") and caja.position.x <= 1930:
			caja.empujar(vector_caja)
		elif caja.position.x >= 1930:
			caja.queue_free()
