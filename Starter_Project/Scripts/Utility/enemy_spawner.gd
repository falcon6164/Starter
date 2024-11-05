extends Node2D

#引用
@export var spawns: Array[Spawn_info] = []

@onready var player = get_tree().get_first_node_in_group("Player")

var time = 0


func _on_timer_timeout():
	#計時器每一秒timeout)+1
	time += 1

	var enemy_spawns = spawns
	for i in enemy_spawns:
			#檢查計時器的值是否在Start 和 end 之間
			if time >= i.time_start and time <= i.time_end:
				#檢查是否有延遲值(delay counter)
				if i.spawn_delay_counter < i.enemy_spawn_delay:
					i.spawn_delay_counter += 1
				else:
						i.spawn_delay_counter = 0
						var new_enemy = i.enemy
						var counter = 0
						while counter < i.enemy_num:
							var enemy_spawn = new_enemy.instantiate()
							enemy_spawn.global_position = get_random_position()
							add_child(enemy_spawn)
							counter += 1
							
func get_random_position():
	#抓取Viewport 的XY大小(vpr)，再分別抓取四個邊界點的位置
	var vpr = get_viewport_rect().size * randf_range(1.1,1.4)
	var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
	
	#隨機選取四個邊之一
	var pos_side = ["up", "down", "left", "right"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	#根據 pos_side 隨機出來的狀態抓取四個邊界點的兩個，畫出一邊的直線
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
			
	#在選出的邊上亂數決定xy值，作為怪物出生點
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y,spawn_pos2.y)
	#最後回傳 get_random_position 函式 Vector2 的值
	return Vector2(x_spawn, y_spawn)
	
