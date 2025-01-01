extends RefCounted

var text: String = ""
var bbcodes: Array

func _init(data: Dictionary) -> void:
	text = data.text
	bbcodes = data.bbcodes
