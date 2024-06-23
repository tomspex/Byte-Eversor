extends Node3D

var is_body_entered = false

@onready var animation_player = $AnimationPlayer
@onready var close_timer = $CloseTimer
@onready var open_sfx = $SFX/Open
@onready var close_sfx = $SFX/Close

func interact():
	animation_player.play("open")
	open_sfx.play()
	close_timer.start()

func _on_area_body_entered(_body):
	is_body_entered = true

func _on_area_body_exited(_body):
	is_body_entered = false

func _on_close_timer_timeout():
	if !is_body_entered:
		animation_player.play_backwards("open")
		close_sfx.play()
	else:
		close_timer.start()
