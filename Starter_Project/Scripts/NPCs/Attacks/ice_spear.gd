extends Area2D

@export var level = 1
@export var hp = 1
@export var speed = 100
@export var damage = 5
@export var knockback_amount = 100
@export var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	# 判斷 taret 的位置，算normalized 的向量方向。target_to 的效果和(b - a).normalized()是一樣的意思 (Ice spear 的 global position to target)
	angle = global_position.direction_to(target)
	#根據angle 的向量來轉向。向量轉化成角度值。
	rotation = angle.angle() + deg_to_rad(225)
	match level:
		1:
			hp = 1
			speed = 100
			damage = 5
			knockback_amount = 100
			attack_size = 1.0
			
func _physics_process(delta):
	#計算位移
	global_position += angle*speed*delta
	
func enemy_hit(charge = 1):
	hp -= charge
	if hp < 0:
		queue_free()

func _on_decay_timer_timeout():
	queue_free()
