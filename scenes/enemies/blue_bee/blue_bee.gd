extends CharacterBody2D

##################################################
const MOVING_SPEED = 100.0
# 움직임 속도
const MOVING_DISTANCE = 300.0
# 상하 이동 거리

var start_position
# 시작 위치. 이 위치가 설정돼야 MOVING_DISTANCE 만큼 상하 이동을 함
var direction: Vector2 = Vector2(0.0, -1.0)
# 이동 방향. 위인지 아래인지
var anim_sprite_node
# AnimatedSprite2D 노드

##################################################
func _ready() -> void:	
	anim_sprite_node = $AnimatedSprite2D
	# anim_sprite_node 설정
	anim_sprite_node.flip_h = true
	# 좌측을 보도록 스프라이트 좌우 반전
	
	add_to_group("Enemy")
	# Enemy 그룹에 추가. bullet.gd에서 충돌 확인을 하기 위함

##################################################
func _physics_process(delta: float) -> void:
	if start_position.y - MOVING_DISTANCE >= global_position.y:
		direction = Vector2(0.0, 1.0)
	elif start_position.y <= global_position.y:
		direction = Vector2(0.0, -1.0)
	# 상하 이동 제한으로 일정 거리 이내에서 움직이도록 함
	
	velocity = direction * MOVING_SPEED
	# velocity 설정
	
	move_and_slide()
	# 물리 적용
