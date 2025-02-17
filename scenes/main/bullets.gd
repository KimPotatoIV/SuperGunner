extends Node2D

##################################################
func _ready() -> void:
	add_to_group("Bullets")
	# Bullets 그룹에 추가. bullet들을 이 그룹 자식 노드로 추가하기 위해 설정
