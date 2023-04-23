extends Node

@export var caja:PackedScene

var caja_instancia
var area_1
var area_2
var area_3
var barquito
var area_del_camion_pedorro
signal caja_creada(caja)


func _ready():
	area_1 = get_node("../area_1")
	area_2 = get_node("../area_2")
	area_3 = get_node("../area_3")

func _on_control_barco_aparece_barco(barco):
	barquito = barco
	caja_instancia = caja.instantiate()
	add_child(caja_instancia)
	caja_instancia.position = Vector2(-450,880)
	caja_instancia.connect("se_solto_la_caja", cuando_se_suelta_la_caja)
	emit_signal("caja_creada",caja_instancia)

func cuando_se_suelta_la_caja(cajita):
	#control de posicionamiento de cajas en areas de descanso
	if  area_1.get_overlapping_bodies().size() > 0:
		if area_1.get_overlapping_bodies().size() > 1:
			area_1.get_overlapping_bodies()[1].queue_free()
		area_1.get_overlapping_bodies()[0].position = area_1.position
	
	if area_2.get_overlapping_bodies().size() > 0:
		if area_2.get_overlapping_bodies().size() > 1:
			area_2.get_overlapping_bodies()[1].queue_free()
		area_2.get_overlapping_bodies()[0].position = area_2.position
	
	if area_3.get_overlapping_bodies().size() > 0:
		if area_3.get_overlapping_bodies().size() > 1:
			area_3.get_overlapping_bodies()[1].queue_free()
		area_3.get_overlapping_bodies()[0].position = area_3.position
	
	
	#control de eliminacion de caja por mala posicion
	if (cajita.position != area_1.position) and (cajita.position != area_2.position) and (cajita.position != area_3.position and (cajita.position != area_del_camion_pedorro.global_position)):
		print("cajita no esta donde debe estar")
		$explocion.stop()
		$explocion.global_position = cajita.global_position
		$explocion.visible = true
		$explocion.play()
		cajita.queue_free()
	


func _on_control_camiones_area_del_camion(area):
	area_del_camion_pedorro = area

func _on_explocion_animation_finished():
	$explocion.stop()
	$explocion.visible = false

