extends Node

var seconds := 0

func _ready():

	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	seconds += 1
	var label = $"."  # Assumes your Label node is a direct child and named "Label"
	label.text = str(seconds) + " seconds"
