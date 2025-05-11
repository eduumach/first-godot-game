extends Control

@export var Address = "127.0.0.1"
@export var Port = 8910
var peer
var spawn_points = []
var players = {}
var connected_peers = []

func _ready() -> void:
    multiplayer.peer_connected.connect(peer_connected)
    multiplayer.peer_disconnected.connect(peer_disconnected)
    multiplayer.connected_to_server.connect(connected_to_server)
    multiplayer.connection_failed.connect(connection_failed)

func peer_connected(id):
    print("Player connected: " + str(id))
    connected_peers.append(id)

func peer_disconnected(id):
    print("Player desconnected: " + str(id))
    connected_peers.erase(id)
    if players.has(id):
        players[id].queue_free()
        players.erase(id)

func connected_to_server():
    print("Connected to server!")

func connection_failed():
    print("Connection failed!")

func _on_host_button_down() -> void:
    peer = ENetMultiplayerPeer.new()
    var error = peer.create_server(Port, 2)
    if error != OK:
        print("Cannot host: " + str(error))
        return
    peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
    multiplayer.set_multiplayer_peer(peer)
    print("Waiting For Players")
    # Add host to connected peers
    connected_peers.append(multiplayer.get_unique_id())

func _on_join_button_down() -> void:
    peer = ENetMultiplayerPeer.new()
    var error = peer.create_client(Address, Port)
    if error != OK:
        print("Cannot join: " + str(error))
        return
    peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
    multiplayer.set_multiplayer_peer(peer)

@rpc("any_peer", "call_local")
func spawn_player(id: int, pos: Vector2):
    var player_scene = load("res://player/player.tscn").instantiate()
    player_scene.name = str(id)
    player_scene.set_multiplayer_authority(id)
    players[id] = player_scene
    player_scene.position = pos
    get_tree().root.add_child(player_scene)

@rpc("any_peer", "call_local")
func start_game():
    var scene = load("res://levels/level_0.tscn").instantiate()
    get_tree().root.add_child(scene)
    
    # Spawn all players
    var spawn_x = 100
    for peer_id in connected_peers:
        spawn_player.rpc(peer_id, Vector2(spawn_x, 100))
        spawn_x += 100  # Space players apart horizontally
    
    self.hide()

func _on_start_game_button_down() -> void:
    start_game.rpc()
