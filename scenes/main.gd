extends Node2D

const WIDTH = 250
const HEIGHT = 350
const HORIZONTAL_MARGIN = 40
const VERTICAL_MARGIN = 50


@onready var color_rect = $ColorRect
@onready var grid_container = color_rect.get_node("MarginContainer/HBoxContainer/GridContainer")

@onready var mouse_x_pos = $mouseXPos
@onready var mouse_y_pos = $mouseYPos

@onready var card_position_array = Array()


var deck = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.set_found.connect(on_set_found)
	GameManager.set_not_found.connect(on_set_not_found)
	
	for s in GameManager.shapeProperty:
		for c in GameManager.colorProperty:
			for t in GameManager.shadeProperty:
				for q in GameManager.quantityProperty:
					var card = Card.new(s, c, t, q)
					card.scale = Vector2(1, 1)
					deck.append(card)

	shuffle()
	
	basic_game_setting()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	mouse_x_pos.text = str(get_global_mouse_position().x)
	mouse_y_pos.text = str(get_global_mouse_position().y)
	
func shuffle():
	deck.shuffle()
	
func basic_game_setting():
	set_card_position(4, 3)
	
	if GameManager.cards_on_board.size() <= 0:
		for i in range(12):
			var card = deck.pop_front()
			GameManager.cards_on_board.append(card)
			
			card.position = card_position_array[i]
			grid_container.add_child(card)


func set_card_position(row_num: int, column_num: int):
	for r in row_num: # 0, 1, 2, 3
		for c in column_num: # 0, 1, 2
			var card_position = Vector2(r * (WIDTH+HORIZONTAL_MARGIN), c * (HEIGHT+HORIZONTAL_MARGIN))
			card_position_array.append(card_position)



func calculate_playing_card_size(card_deck: Array):
	return card_deck.size()


func on_set_found():
	GameManager.selected_cards.clear()
	print("Set Found")
	
	
func on_set_not_found():
	await on_set_not_found_deferred()
	GameManager.selected_cards.clear()
	print("Set Not Found")
	
func on_set_not_found_deferred():
	for c in GameManager.selected_cards:
		c.is_selected = false
		c.visible = true

