extends Node2D

##################################################
const EARTHWORM_SCENE: PackedScene = \
preload("res://scenes/enemies/earthworm/earthworm.tscn")
const BLUE_BEE: PackedScene =\
preload("res://scenes/enemies/blue_bee/blue_bee.tscn")
# 두 가지 적 씬 미리 불리오기

##################################################
func _ready() -> void:
	for i in range(2):
		var earthworm_instance = EARTHWORM_SCENE.instantiate()
		add_child(earthworm_instance)
		# 반복하며 earthworm_instance 두 개 생성
	
		if i == 0:
			earthworm_instance.global_position = Vector2(1790.0, 1400.0)
		else:
			earthworm_instance.global_position = Vector2(2530.0, 1400.0)
		# 각 earthworm_instance 좌표 설정

	for i in range(3):
		var blue_bee_instance = BLUE_BEE.instantiate()
		add_child(blue_bee_instance)
		# 반복하며 blue_bee_instance 세 개 생성
		
		if i == 0:
			blue_bee_instance.start_position = Vector2(1480.0, 690.0)
			blue_bee_instance.global_position = Vector2(1480.0, 690.0)
		elif i == 1:
			blue_bee_instance.start_position = Vector2(1640.0, 690.0)
			blue_bee_instance.global_position = Vector2(1640.0, 690.0)
		else:
			blue_bee_instance.start_position = Vector2(1800.0, 690.0)
			blue_bee_instance.global_position = Vector2(1800.0, 690.0)
		# 각 blue_bee_instance 좌표 설정
