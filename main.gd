extends Node

@export var barco:PackedScene 
@export var caja:PackedScene
@export var camion:PackedScene

var nivel = 1

#barco
var barco_instancia
var hay_barco = false
var vector_barco = Vector2(10,0)
var vector_caja = Vector2(11,0)
var colision_barco
 #caja
var caja_instancia
var hay_caja_en_1 = false
var hay_caja_en_2 = false
var hay_caja_en_3 = false
#camion
var camion_instancia #donde se guarda la copia del camion
var hay_camion = false #lo que controla que haya un solo camion
var colision_camion #donde se guarda el movimiento del camion
var vector_camion = Vector2(-10,0) #velocidad a la que va el camion

func _ready():
	pass
	
func _process(delta):
	if not hay_camion:
		camion_instancia = camion.instantiate()
		add_child(camion_instancia)
		print("hayu uncamion anda a saber donde")
		camion_instancia.position = Vector2(2300,250)
		print(camion_instancia.position)
		hay_camion = true
	if hay_camion and $Timer_general.timeout:
		recorrer_mapa_camion(camion_instancia)
	
	if not hay_barco:
		barco_instancia = barco.instantiate()
		add_child(barco_instancia)
		barco_instancia.position = Vector2(-800,750)
		
		caja_instancia = caja.instantiate()
		add_child(caja_instancia)
		caja_instancia.position = Vector2(-350,780)
		
		hay_barco = true
		
	if hay_barco and $Timer_general.timeout:
		recorrer_mapa_barco(barco_instancia, caja_instancia)


func recorrer_mapa_camion(par_camion):
	colision_camion = par_camion.move_and_collide(vector_camion)
	#se va en -500
	if par_camion.position.x <= -500:
		hay_camion = false
		par_camion.queue_free()



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
			caja.position = Vector2(2500,2500)





func _on_area_1_area_entered(area):
	hay_caja_en_1=true
	print("entro en 1")

func _on_area_1_area_exited(area):
	hay_caja_en_1= false
	print("salio de 1")
