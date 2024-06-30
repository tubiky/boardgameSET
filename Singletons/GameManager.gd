extends Node

signal card_selected(Card)
signal card_unselected
signal cards_on_board_changed

signal set_found
signal set_not_found

var card_background_image = preload("res://images/cardFrame.png")

var shapeProperty = ["Rhombus","Oval", "Peanut"]
var colorProperty = ["Green", "Red", "Purple"]
var shadeProperty = ["Full", "Slash", "Empty"]
var quantityProperty = [1, 2, 3]

var deck = Array()

# Cards that are shown to players
var cards_on_board = Array()

# 3 Cards that were chosen by a player
var selected_cards = Array()

# Collection of cards that made SET
var discarded_cards = Array()

# Collection of position info of cards that made SET
var discarded_cards_positions = Array()

func _ready():
	card_selected.connect(on_card_selected)
	card_unselected.connect(on_card_unselected)

	for s in GameManager.shapeProperty:
		for c in GameManager.colorProperty:
			for t in GameManager.shadeProperty:
				for q in GameManager.quantityProperty:
					var card = Card.new(s, c, t, q)
					card.scale = Vector2(1, 1)
					deck.append(card)
	
	
func _process(_delta):
	pass
	
func on_card_selected(card: Card):
	if selected_cards.size() < 2:
		selected_cards.append(card)
		print("Card Selected: ", card.figureColor, " ", card.figureQuantity, " ", card.figureShade, " ", card.figureShape, card.position)
	
	else:
		selected_cards.append(card)
		print("Card Selected: ", card.figureColor, " ", card.figureQuantity, " ", card.figureShade, " ", card.figureShape, card.position)
		var cards_attributes = await extract_card_attributes(selected_cards)
		await is_set(cards_attributes)	


func on_card_unselected():
	var unselected_card = selected_cards.pop_back()
	var grid_cont = get_node("/root/Main/ColorRect/MarginContainer/HBoxContainer/GridContainer")
	grid_cont.add_child(unselected_card)
	unselected_card.emit_unselected_signal()
	
	print("Card Unselected")
	

func _on_cards_on_board_changed():
	pass


func extract_card_attributes(three_cards: Array):
	var first_card_attributes = []
	var second_card_attributes = []
	var third_card_attributes = []
	
	first_card_attributes.append(three_cards[0].figureShade)
	first_card_attributes.append(three_cards[0].figureColor)
	first_card_attributes.append(three_cards[0].figureShade)
	first_card_attributes.append(three_cards[0].figureQuantity)
	
	second_card_attributes.append(three_cards[1].figureShade)
	second_card_attributes.append(three_cards[1].figureColor)
	second_card_attributes.append(three_cards[1].figureShade)
	second_card_attributes.append(three_cards[1].figureQuantity)
	
	third_card_attributes.append(three_cards[2].figureShade)
	third_card_attributes.append(three_cards[2].figureColor)
	third_card_attributes.append(three_cards[2].figureShade)
	third_card_attributes.append(three_cards[2].figureQuantity)
	
	return [first_card_attributes, second_card_attributes, third_card_attributes]


func is_set(attributes: Array):
	# card format: [number, shape, color, shading]
	for i in range(4):
		if (attributes[0][i] == attributes[1][i] && attributes[1][i] == attributes[2][i]) or (attributes[0][i] != attributes[1][i] && attributes[1][i] != attributes[2][i] && attributes[0][i] != attributes[2][i]):
			pass  # Matching or all different in one attribute
		else:
			set_not_found.emit()
			return  # Not a set
	
	set_found.emit()
	return  # All attributes match or all are different
	

