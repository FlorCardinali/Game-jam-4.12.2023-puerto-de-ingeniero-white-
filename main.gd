extends Node
@export var barco:PackedScene 
@export var caja:PackedScene

var nivel = 1

#barco
var barco_instancia
var hay_barco = false
var vector_barco = Vector2(10,0)
var colision_barco
 #caja
var caja_instancia

func _ready():
	pass
	
func _process(delta):
	if hay_barco == false:
		barco_instancia = barco.instantiate()
		caja_instancia = caja.instantiate()
		add_child(barco_instancia)
		barco_instancia.position = Vector2(-1000,750)
		add_child(caja_instancia)
		caja_instancia.position = Vector2(20,400)
		hay_barco = true
	elif hay_barco == true and $timer_barco.timeout:
		recorrer_mapa(barco_instancia)

func recorrer_mapa(barco):
	colision_barco = barco_instancia.move_and_collide(vector_barco)
	print(barco_instancia.position)
	if barco_instancia.position.x == 2000:
		barco_instancia.queue_free()
		hay_barco= false
	if colision_barco!=null:
		if colision_barco.get_collider().name == "caja":
			caja_instancia.empujar(vector_barco)
