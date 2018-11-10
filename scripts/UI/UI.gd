extends HBoxContainer

var root

func _ready():
	root = get_tree().get_root().get_node("Root")
	
func _draw():
	if root.running:
		return

	var inv = get_global_transform().inverse()
	#draw_set_transform(inv.get_origin(), inv.get_rotation(), inv.get_scale())
	#var basePos = get_viewport_transform().origin + Vector2(50, 150)
	var basePos = Vector2(150, 40)
	var width = 20
	var height = 60
	draw_rect(Rect2(basePos, Vector2(width, height)), Color(255))
	basePos += Vector2(width*1.5, 0)
	draw_rect(Rect2(basePos, Vector2(width, height)), Color(255))

func _process(delta):
	update()