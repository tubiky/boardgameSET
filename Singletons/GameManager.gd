extends Node

signal card_selected(Card)
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
	
	
func _process(_delta):
	pass
	
func on_card_selected(card: Card):
	if selected_cards.size() < 3:
		selected_cards.append(card)
		print("Card Selected: ", card.figureColor, " ", card.figureQuantity, " ", card.figureShade, " ", card.figureShape, card.position)
		
	else:
		for c in selected_cards:
			pass
	


func on_card_unselected():
	print("Card Unselected")
	

func _on_cards_on_board_changed():
	pass
