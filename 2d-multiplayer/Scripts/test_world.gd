extends Node

@onready var main_menu = $CanvasLayer/MainMenu
@onready var address_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/AddressEntry
@onready var BG = $BG

const Player = preload("res://Scenes/player.tscn")
const PORT = 9999
const MAX_CLIENTS = 1

var enet_peer = ENetMultiplayerPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BG.visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_host_pressed() -> void:
	main_menu.hide()
	BG.visible = true
	enet_peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	
	add_player(multiplayer.get_unique_id())

func _on_join_pressed() -> void:
	main_menu.hide()
	BG.visible = true
	var ip = address_entry.text.strip_edges()
	if ip == "":
		return
	enet_peer.create_client(ip, PORT)
	multiplayer.multiplayer_peer = enet_peer
	
func add_player(peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)
	
func remove_player(peer_id):
	var player = get_node_or_null(str(peer_id))
	if player:
		player.queue_free()



	
	
	
	
	
	
	
