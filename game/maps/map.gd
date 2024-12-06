class_name Map extends Node2D

var chilren = Array()
var paused_chilren = LinkedList.new()
var prev_modes = LinkedList.new()
var player: Player
var last_player_pos: Vector2 = Vector2(0,0)

const threshold = 600

func _ready() -> void:
	player = GlobalPlayerManager.player

func pause():
	for child in get_children():
		
		if child.process_mode == PROCESS_MODE_WHEN_PAUSED:
			continue
		
		if child is Node2D:
			var distance = child.global_position.distance_to(player.global_position)
			if distance > threshold:
				paused_chilren.push_back(child)
				prev_modes.push_back(child.process_mode)
				child.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
				
func unpause():
	var index_to_pop = Array()
	
	var link_child = paused_chilren.first
	var link_prev_modes = prev_modes.first
	while true:
		if not link_child or not link_prev_modes:
			break
		
		var child = link_child.data
		var distance = child.global_position.distance_to(player.global_position)
		
		if distance <= threshold:
			child.process_mode = link_prev_modes.data
			paused_chilren.pop(link_child)
			prev_modes.pop(link_prev_modes)
			
		link_child = link_child.next
		link_prev_modes = link_prev_modes.next

func _process(_delta: float) -> void:
	if player.global_position == last_player_pos:
		return
		
	last_player_pos = player.global_position
	pause()
	unpause()
	
class LinkedList extends Object:
	var first : Link = null
	var last : Link = null
	
	func push_back( 
		_object : Variant
	):
		var _link = Link.new( _object )
		
		if last == null:
			first = _link
			last = _link
			return
			
		last.next = _link
		_link.prev = last
		_link.next = null
		last = _link
		
	func pop(link: Link):
		if link == first:
			first = link.next
		
		if link == last:
			last = link.prev
		
		if link.prev:
			link.prev.next = link.next
			
		if link.next:	
			link.next.prev = link.prev
			
		return link.data

class Link extends Object:
	var data: Variant
	var next: Link = null
	var prev: Link = null
	
	func _init(_data: Variant) -> void:
		data = _data
