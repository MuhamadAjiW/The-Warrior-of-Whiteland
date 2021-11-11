extends Area2D

onready var scene_tree: = get_tree()
onready var text_overlay: = $CanvasLayer/ColorRect

var condition = false

func _input(event):
	if overlaps_body($"/root/Global".player):
		if event.is_action_pressed("dive"):
			if condition == true:
				get_tree().paused = false
				text_overlay.visible = false
				condition = false
				$"/root/Global".player.Pause._on_restore_pause()
			elif get_tree().paused == false:
				condition = true
				get_tree().paused = true
				scene_tree.set_input_as_handled()
				text_overlay.visible = true
				$"/root/Global".player.Pause._on_pause_disable()
				$"/root/Global".player.takeHealing($"/root/Global".player.max_health)
		
		if event.is_action_pressed("pause") and condition == true:
			get_tree().paused = false
			text_overlay.visible = false
			condition = false
			yield(get_tree().create_timer(0.1), "timeout")
			$"/root/Global".player.Pause._on_restore_pause()


func _on_Choice_1_button_up():
	var new_max_health = $"/root/Global".player.max_health + 1
	$"/root/Global".player._set_max_health(new_max_health)

func _on_Choice_2_button_up():
	var new_regenSpeed= $"/root/Global".player.regenSpeed + 0.1*$"/root/Global".player.regenSpeed
	$"/root/Global".player.regenSpeed = new_regenSpeed

func _on_Choice_3_button_up():
	var new_max_energy = $"/root/Global".player.max_energy + 50
	$"/root/Global".player._set_max_energy(new_max_energy)
