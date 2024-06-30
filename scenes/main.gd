extends Node2D

signal set_check_finished

const X_OFFSET = 100
const Y_OFFSET = 120
const WIDTH = 250
const HEIGHT = 275
const HORIZONTAL_MARGIN = 90
const VERTICAL_MARGIN = 12


@onready var color_rect = $ColorRect
@onready var grid_container = color_rect.get_node("MarginContainer/HBoxContainer/GridContainer")

@onready var mouse_x_pos = $mouseXPos
@onready var mouse_y_pos = $mouseYPos

@onready var card_position_array = Array()


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.set_found.connect(on_set_found)
	GameManager.set_not_found.connect(on_set_not_found)
	set_check_finished.connect(on_set_check_finished)

	shuffle()
	
	basic_game_setting()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	mouse_x_pos.text = str(get_global_mouse_position().x)
	mouse_y_pos.text = str(get_global_mouse_position().y)
	
func shuffle():
	GameManager.deck.shuffle()
	
func basic_game_setting():
	set_card_position(4, 3)
	
	if GameManager.cards_on_board.size() <= 0:
		for i in range(12):
			var card = GameManager.deck.pop_front()
			GameManager.cards_on_board.append(card)
			
			card.position = card_position_array[i]
			grid_container.add_child(card)

func deal_card(card_deck: Array, dealt_card_num: int):
	for n in dealt_card_num:
		var new_card = card_deck.pop_back()
		GameManager.cards_on_board.append(new_card)
		new_card.position = GameManager.discarded_cards_positions.pop_back()
		grid_container.add_child(new_card)


func set_card_position(row_num: int, column_num: int):
	for r in row_num: # 0, 1, 2, 3
		for c in column_num: # 0, 1, 2
			var card_position = Vector2(r * (WIDTH+HORIZONTAL_MARGIN), c * (HEIGHT+HORIZONTAL_MARGIN)+Y_OFFSET)
			card_position.x += X_OFFSET
			card_position_array.append(card_position)


func discard_three_cards_in_set(three_cards_in_set: Array, cards_on_board: Array):
	for card_in_set in three_cards_in_set:
		GameManager.discarded_cards_positions.append(card_in_set.position)
		if card_in_set in cards_on_board:
			var card_idx = cards_on_board.find(card_in_set)
			cards_on_board.remove_at(card_idx)


func calculate_playing_card_size(card_deck: Array):
	return card_deck.size()


func on_set_found():
	discard_three_cards_in_set(GameManager.selected_cards, GameManager.cards_on_board)
	
	for set_card in GameManager.selected_cards:
		GameManager.discarded_cards.append(set_card)
		set_card.queue_free()
	GameManager.selected_cards.clear()
	
	deal_card(GameManager.deck, 3)
	
	
func on_set_not_found():
	for c in GameManager.selected_cards:
		await c.toggle_is_selected()
		await c.set_visible_true()
		await c.toggle_is_area_monitoring()
	GameManager.selected_cards.clear()
	print("Set Not Found")
	set_check_finished.emit()
	print("Signal Emitted")
	on_set_check_finished()
	print("On Set Check Finished has been executed")
	
func on_set_check_finished():
	"Method has been called"
	await set_check_finished
	for card in grid_container.get_children():
		print("Check Card visibility")
		if card.visible == false:
			print("invisible card found")
			card.visible = true


