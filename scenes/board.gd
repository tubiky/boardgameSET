extends ColorRect


@onready var total_card_count = $MarginContainer/HBoxContainer/VBoxContainer/TotalCardCount
@onready var deck_count = $MarginContainer/HBoxContainer/VBoxContainer/DeckCount
@onready var selected_card_count = $MarginContainer/HBoxContainer/VBoxContainer/SelectedCardCount
@onready var grid_container = $MarginContainer/HBoxContainer/GridContainer



# Called when the node enters the scene tree for the first time.
func _ready():
	grid_container.columns = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#total_card_count.text = GameManager.
	deck_count.text = "보드판 위의 카드 수: " + str(GameManager.cards_on_board.size())
	selected_card_count.text = "선택된 카드의 수: " + str(GameManager.selected_cards.size())
