extends Node

#enum (括號內的選項對應數字，左至右從0開始計算)
@export_enum("Cooldown", "Hitonce", "DisableHitBox") var HurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var disabletimer = $DisableTimer

signal hurt(damage)

func _on_area_entered(area):
	#區域碰撞時判斷區域的群組，如果群組是 Attack 則做對應動作
	if area.is_in_group("Attack"):
		if not area.get("damage") == null:
				match HurtBoxType:
						0: #Cooldown
							collision.call_deferred("set","disabled",true)
							disabletimer.start()
						1: #Hitonce
							pass
						2:	#DisableHitBox 判斷碰撞的區域是否有 tempdisable 方法，若有，暫時取消碰撞判斷
							if area.has_method("tempdisable"):
									area.tempdisable()
									print("tempdisable_called,", area.name)
				#放出信號並傳出傷害值參數
				var damage = area.damage
				emit_signal("hurt", damage)
				print(area.name, "attack ", get_parent().name)
					

func _on_disable_timer_timeout():
		collision.call_deferred("set","disabled",false)
