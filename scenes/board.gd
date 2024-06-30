extends ColorRect


@onready var total_card_count = $MarginContainer/HBoxContainer/VBoxContainer/TotalCardCount
@onready var deck_count = $MarginContainer/HBoxContainer/VBoxContainer/DeckCount
@onready var selected_card_count = $MarginContainer/HBoxContainer/VBoxContainer/SelectedCardCount
@onready var grid_container = $MarginContainer/HBoxContainer/GridContainer
@onready var discarded_cards_count = $MarginContainer/HBoxContainer/VBoxContainer/DiscardedCardsCount



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	total_card_count.text = "남은 카드 수: " + str(GameManager.deck.size())
	deck_count.text = "보드판 위의 카드 수: " + str(GameManager.cards_on_board.size())
	selected_card_count.text = "선택된 카드의 수: " + str(GameManager.selected_cards.size())
	discarded_cards_count.text = "SET가 만들어진 카드의 수: " + str(GameManager.discarded_cards.size())
