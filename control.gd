extends Control

const PORT: int = 10805
const MAX_CLIENTS: int = 2

var peer: ENetMultiplayerPeer

@onready var ip_input: LineEdit = $VBoxContainer/IPInput
@onready var status_label: Label = $VBoxContainer/Status

func _ready() -> void:
	status_label.text = "Välj om du vill starta server eller ansluta."


func _on_host_button_pressed() -> void:
	peer = ENetMultiplayerPeer.new()
	var err := peer.create_server(PORT, MAX_CLIENTS)
	if err != OK:
		push_error("create_server() failed, error: %s" % err)
		status_label.text = "Kunde inte starta server (fel %d)." % err
		return

	# Sätt multiplayer peer först efter att servern skapats
	multiplayer.multiplayer_peer = peer

	# Bekräfta att vi är server
	if multiplayer.is_server():
		status_label.text = "Server startad! Väntar på klienter..."
	else:
		status_label.text = "Startade peer men blev inte server (okänd anledning)."
func _on_join_button_pressed() -> void:
	var ip = ip_input.text.strip_edges()
	if ip == "":
		status_label.text = "Ange en IP-adress!"
		return
	
	peer = ENetMultiplayerPeer.new()
	var result = peer.create_client(ip, PORT)
	if result != OK:
		status_label.text = "Kunde inte ansluta till %s:%s" % [ip, PORT]
		return
	
	multiplayer.multiplayer_peer = peer
	status_label.text = "Försöker ansluta till %s..." % ip # Replace with function body.
