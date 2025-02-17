extends CharacterBody2D

##################################################
const MOVING_SPEED = 50.0
# 움직임 속도

var direction: Vector2 = Vector2(-1.0, 0.0)
# 이동 방향. 좌인지 우인지
var anim_sprite_node
# AnimatedSprite2D 노드

##################################################
func _ready() -> void:
	anim_sprite_node = $AnimatedSprite2D
	# anim_sprite_node 설정
	
	add_to_group("Enemy")
	# Enemy 그룹에 추가. bullet.gd에서 충돌 확인을 하기 위함

##################################################
func _physics_process(delta: float) -> void:
	if is_on_floor():
	# 지면에 있을 때
		velocity = direction * MOVING_SPEED
		# velocity 설정
	
	if is_on_wall():
	# 벽에 닿으면
		direction *= -1
		# 방향 전환
		velocity = direction * MOVING_SPEED
		# velocity 설정
	
	if direction == Vector2(-1.0, 0.0):
		anim_sprite_node.flip_h = true
	else:
		anim_sprite_node.flip_h = false
	# 방향에 따라 스프라이트 좌우 반전

	move_and_slide()
	# 물리 적용
