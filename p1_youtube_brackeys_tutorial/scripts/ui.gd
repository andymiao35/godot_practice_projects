extends CanvasLayer

var score = 0
@onready var score_counter: Label = $Score_counter


func add_point():
	score +=  1
	score_counter.text = "Coins collected: " + str(score) + "/15"
