extends Node
@export var barco:PackedScene 
@export var caja:PackedScene

var nivel = 1

#barco
var barco_instancia
var hay_barco = false
var vector_barco = Vector2(10,0)
var vector_caja = Vector2(11,0)
var colision_barco
 #caja
var caja_instancia

func _ready():
	pass
	
func _process(delta):
	if not hay_barco:
		barco_instancia = barco.instantiate()
		caja_instancia = caja.instantiate()
		add_child(barco_instancia)
		barco_instancia.position = Vector2(-800,750)
		add_child(caja_instancia)
		caja_instancia.position = Vector2(-350,780)
		hay_barco = true
	elif hay_barco and $timer_barco.timeout:
		recorrer_mapa(barco_instancia, caja_instancia)


func recorrer_mapa(barco, caja):
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
	
