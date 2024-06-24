extends Control

signal _return



func _on_return_pressed():
	_return.emit()
	queue_free()

func _on_one_scale_pressed():
	SceneManager.set_quantization(1)

func _on_two_scale_pressed():
	SceneManager.set_quantization(2)

func _on_four_scale_pressed():
	SceneManager.set_quantization(4)

func _on_eight_scale_pressed():
	SceneManager.set_quantization(8)
