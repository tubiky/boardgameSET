extends Node

signal card_selected
signal card_unselected
signal cards_on_board_changed

var card_background_image = preload("res://images/cardFrame.png")

var shapeProperty = ["Rhombus","Oval", "Peanut"]
var colorProperty = ["Green", "Red", "Purple"]
var shadeProperty = ["Full", "Slash", "Empty"]
var quantityProperty = [1, 2, 3]

# Cards that are shown to players
var cards_on_board = Array()

# 3 Cards that were chosen by a player
var selected_cards = Array()

func _ready():
	card_selected.connect(on_card_selected)
	card_unselected.connect(on_card_unselected)
	cards_on_board_changed.connect(_on_cards_on_board_changed)
	
func on_card_selected():
	print("Card Selected")
	

func on_card_unselected():
	print("Card Unselected")
	

func _on_cards_on_board_changed():
	pass
