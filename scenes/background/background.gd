extends Node2D

##################################################
var tile_map_layer_node
# background 노드의 자식 노드

##################################################
func _ready() -> void:
	tile_map_layer_node = $TileMapLayer
	# tile_map_layer_node 변수 설정
	tile_map_layer_node.add_to_group("Background")
	# Background 그룹에 추가. bullet.gd에서 충돌 확인을 하기 위함
