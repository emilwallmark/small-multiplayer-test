extends Control


func _on_server_pressed() -> void:
	HighLevelNetworkHandler.start_server() # Replace with function body.
	$"..".hide()


func _on_client_pressed() -> void:
	HighLevelNetworkHandler.start_client() # Replace with function body.
	$"..".hide()
