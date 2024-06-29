extends Node2D

const WIDTH = 125
const HEIGHT = 160
const MARGIN = 20
const GRIDS = 4


@onready var color_rect = $ColorRect
@onready var grid_container = color_rect.get_node("MarginContainer/HBoxContainer/GridContainer")

@onready var mouse_x_pos = $mouseXPos
@onready var mouse_y_pos = $mouseYPos

@onready var card_position_array = Array()


var deck = Array()
var playing_deck = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	grid_container.columns = 5
	for s in GameManager.shapeProperty:
		for c in GameManager.colorProperty:
			for t in GameManager.shadeProperty:
				for q in GameManager.quantityProperty:
					var card = Card.new(s, c, t, q)
					card.scale = Vector2(0.5, 0.5)
					deck.append(card)

	shuffle()
	
	dealCards(4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	mouse_x_pos.text = str(get_global_mouse_position().x)
	mouse_y_pos.text = str(get_global_mouse_position().y)
	
func shuffle():
	deck.shuffle()
	
func dealCards(num: int):
	set_card_position(GRIDS)
	
	if playing_deck.size() <= 0:
		for i in range(12):
			var card = deck[i]
			
			card.position = card_position_array[i]
			grid_container.add_child(card)


func set_card_position(grid):
	for r in grid:
		for c in grid:
			var card_position = Vector2(r * (WIDTH+MARGIN), c * (HEIGHT+MARGIN))
			card_position_array.append(card_position)
			


func calculate_playing_card_size(card_deck: Array):
	return card_deck.size()


# Function that checks whether the open 12 cards have set or not
# If there is no SET condition, then it should call deal card funtion to open a new card.
func check_set_condition():
	pass
	
