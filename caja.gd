extends CharacterBody2D

var click_esta_adentro = false
var distancia_al_click = Vector2.ZERO
var colision
var se_solto_caja = false


func _physics_process(delta):
	if click_esta_adentro:
#		print("mask: ", get_collision_mask())
		#la caja empiesa en 1 y lo seteas a 2 cuando agarras la caja
		collision_layer = 2
#		print("layer: ", get_collision_layer())
		colision = move_and_collide(get_global_mouse_position() - distancia_al_click - position)

func empujar(velocidad):
	move_and_collide(velocidad)

func _on_area_click_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click_izquierdo"):
		distancia_al_click = get_global_mouse_position() - self.position
		click_esta_adentro = true
		print("se clikio")
	if event.is_action_released("click_izquierdo"):
		click_esta_adentro = false
		se_solto_caja = true
		print("se solto el click")

 
