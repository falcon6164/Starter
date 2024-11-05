extends Node

@export var damage = 1
@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableHItBoxTimer

func tempdisable():
		collision.call_deferred("set", "disabled", true)
		disableTimer.start()
		

func _on_disable_h_it_box_timer_timeout():
	collision.call_deferred("set", "disabled", false)
