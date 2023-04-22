extends Node2D
@export var main:PackedScene

var en_creditos 
var en_ayuda

func _ready():
	en_ayuda = false
	en_creditos = false
	$pantalla_creditos.visible = false

func _process(delta):
	if en_creditos:
		if Input.is_action_just_pressed("click_izquierdo"):
			en_creditos = false
			
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
				print("paso a 1")
			elif $pantalla_ayuda.get_animation() == "segundo_paso":
				$pantalla_ayuda.set_animation("tercer_paso")
				print("paso a 2")
			elif $pantalla_ayuda.get_animation() == "tercer_paso" :
				en_ayuda = false
				
				$Play.disabled = false
				$Ayuda.disabled = false
				$Creditos.disabled =false
				$Salir.disabled =false
				
				$pantalla_ayuda.visible = false
			

func _on_play_pressed():
	get_tree().change_scene_to_packed(main)


func _on_creditos_pressed():
	$pantalla_creditos.visible = true
	$pantalla_creditos.play()
	
	$Play.disabled =true
	$Ayuda.disabled =true
	$Creditos.disabled =true
	$Salir.disabled =true
	
	en_creditos = true

func _on_ayuda_pressed():
	$pantalla_ayuda.visible = true
	
	$Play.disabled =true
	$Ayuda.disabled =true
	$Creditos.disabled =true
	$Salir.disabled =true
	
	$pantalla_ayuda.set_animation("primer_paso")
	en_ayuda = true


func _on_salir_pressed():
	get_tree().quit()
	
