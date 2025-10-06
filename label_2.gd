extends Label

var coins_collected = 0
var body_entered = false 

func _ready() -> void:
	visible = false

	for coin in get_tree().get_nodes_in_group("coins"):
		coin.connect("tree_exited", Callable(self, "_on_coin_collected"))
