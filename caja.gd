extends CharacterBody2D


var esta_adentro = false
var distancia_al_click = Vector2.ZERO
var colision
var colisionador
	
func _physics_process(delta):
	if esta_adentro:
		colision = move_and_collide(get_global_mouse_position() - distancia_al_click - position)

func empujar(velocidad):
	move_and_collide(velocidad)

func _on_area_click_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click_izquierdo"):
		distancia_al_click = get_global_mouse_position() - self.position
		esta_adentro = true
		print("se clikio")
	if event.is_action_released("click_izquierdo"):
		esta_adentro = false
		print("se solto el click")
