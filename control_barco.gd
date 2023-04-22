extends Node

@export var barco:PackedScene 

var barco_instancia
var hay_barco = false
signal aparece_barco(barco)
var colision_barco
var vector_barco = Vector2(10,0)
var caja_barco

func _process(delta):
	if not hay_barco:
		barco_instancia = barco.instantiate()
		add_child(barco_instancia)
		barco_instancia.position = Vector2(-800,650)
		emit_signal("aparece_barco", barco_instancia)
		hay_barco = true

	if hay_barco and $timer_barco.timeout:
		recorrer_mapa_barco(barco_instancia)

func recorrer_mapa_barco(par_barco):
	
	colision_barco = par_barco.move_and_collide(vector_barco)

	#eliminacion del barco
	if par_barco.global_position.x >= 2500:
		par_barco.queue_free()
		hay_barco = false
	#control de seguimiento caja a barco
	if colision_barco!=null:
		if colision_barco.get_collider().is_in_group("cajas") and caja_barco.global_position.x <= 1930:
			caja_barco.empujar(vector_barco)
		#eliminacion de la caja por derecha
		elif caja_barco.global_position.x >= 1930:
			caja_barco.queue_free()

func _on_control_cajas_caja_creada(caja):
	caja_barco = caja
