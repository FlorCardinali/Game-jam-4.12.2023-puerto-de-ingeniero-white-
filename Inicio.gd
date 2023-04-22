extends Node2D
@export var main:PackedScene

var en_creditos 
var en_ayuda
var rand = RandomNumberGenerator.new()
var numero_random 

func _ready():
	en_ayuda = false
	en_creditos = false
	$pantalla_creditos.visible = false
	$musica_menu.play()

func _process(delta):
	if en_creditos:
		
		if Input.is_action_just_pressed("click_izquierdo"):
			en_creditos = false
			$son_creditos/Ttimer_sonido_creditos.stop()
			$Play.disabled = false
			$Ayuda.disabled = false
			$Creditos.disabled =false
			$Salir.disabled =false
			
			$pantalla_creditos.visible = false
			$pantalla_creditos.stop()
	
	if en_ayuda:
		if Input.is_action_just_pressed("click_izquierdo"):
			
			if $pantalla_ayuda.get_animation() == "primer_paso":
				$pantalla_ayuda.set_animation("segundo_paso")
				$obrero.play()
				print("paso a 1")
			elif $pantalla_ayuda.get_animation() == "segundo_paso":
				$pantalla_ayuda.set_animation("tercer_paso")
				$obrero2.play()
				print("paso a 2")
			elif $pantalla_ayuda.get_animation() == "tercer_paso" :
				en_ayuda = false
				
				$Play.disabled = false
				$Ayuda.disabled = false
				$Creditos.disabled =false
				$Salir.disabled =false
				
				$pantalla_ayuda.visible = false
			

func _on_play_pressed():
	$botones.play()
	get_tree().change_scene_to_packed(main)


func _on_creditos_pressed():
	$botones.play()
	$son_creditos/Ttimer_sonido_creditos.start()
	$pantalla_creditos.visible = true
	$pantalla_creditos.play()
	
	$Play.disabled =true
	$Ayuda.disabled =true
	$Creditos.disabled =true
	$Salir.disabled =true
	
	en_creditos = true

func _on_ayuda_pressed():
	$botones.play()
	$pantalla_ayuda.visible = true
	$obrero2.play()
	$Play.disabled =true
	$Ayuda.disabled =true
	$Creditos.disabled =true
	$Salir.disabled =true
	
	$pantalla_ayuda.set_animation("primer_paso")
	en_ayuda = true


func _on_salir_pressed():
	$botones.play()
	$botones/timer_salir.start()


func _on_timer_salir_timeout():
	get_tree().quit()


func _on_musica_menu_finished():
	$musica_menu.play()


func _on_ttimer_sonido_creditos_timeout():
	numero_random = rand.randi_range(1,3)
	$son_creditos/Ttimer_sonido_creditos.wait_time = numero_random
	$son_creditos.play()
