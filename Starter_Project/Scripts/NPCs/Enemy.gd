extends CharacterBody2D

@export var movement_speeed = 20
@export var hp = 10

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var Sprite = $AnimatedSprite2D

func _physics_process(delta):
		var direction = global_position.direction_to(player.global_position)
		velocity = direction*movement_speeed
		move_and_slide()
		
		if direction.x > 0.1:
			Sprite.flip_h = true
		elif direction.x < 0.1:
			Sprite.flip_h = false
			
			if direction != Vector2.ZERO:
				Sprite.play()
			else:
				Sprite.stop()	

func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
	if hp <= 0:
		queue_free()
