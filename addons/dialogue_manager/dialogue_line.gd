## A line of dialogue returned from [code]DialogueManager[/code].
class_name DialogueLine extends RefCounted


const _DialogueConstants = preload("./constants.gd")


## The ID of this line
var id: String

## The internal type of this dialogue object. One of [code]TYPE_DIALOGUE[/code] or [code]TYPE_MUTATION[/code]
var type: String = _DialogueConstants.TYPE_DIALOGUE

## The next line ID after this line.
var next_id: String = ""

## The character name that is saying this line.
var character: String = ""

## A dictionary of variable replacements fo the character name. Generally for internal use only.
var character_replacements: Array[Dictionary] = []

## The dialogue being spoken.
var text: String = ""

## A dictionary of replacements for the text. Generally for internal use only.
var text_replacements: Array[Dictionary] = []

## The key to use for translating this line.
var translation_key: String = ""

## A map for bbcodes
var bbcodes: Array = []

## A list of responses attached to this line of dialogue.
var responses: Array = []

## A list of any extra game states to check when resolving variables and mutations.
var extra_game_states: Array = []

## Any #tags that were included in the line
var tags: PackedStringArray = []

## The mutation details if this is a mutation line (where [code]type == TYPE_MUTATION[/code]).
var mutation: Dictionary = {}

## The conditions to check before including this line in the flow of dialogue. If failed the line will be skipped over.
var conditions: Dictionary = {}


func _init(data: Dictionary = {}) -> void:
	if data.size() > 0:
		id = data.id
		next_id = data.next_id
		type = data.type
		extra_game_states = data.get("extra_game_states", [])

		match type:
			_DialogueConstants.TYPE_DIALOGUE:
				character = data.character
				character_replacements = data.get("character_replacements", [] as Array[Dictionary])
				text = data.text
				text_replacements = data.get("text_replacements", [] as Array[Dictionary])
				translation_key = data.get("translation_key", data.text)
				bbcodes = data.get("bbcodes", [])
				tags = data.get("tags", [])

			_DialogueConstants.TYPE_MUTATION:
				mutation = data.mutation


func _to_string() -> String:
	match type:
		_DialogueConstants.TYPE_DIALOGUE:
			return "<DialogueLine character=\"%s\" text=\"%s\">" % [character, text]
		_DialogueConstants.TYPE_MUTATION:
			return "<DialogueLine mutation>"
	return ""


func get_tag_value(tag_name: String) -> String:
	var wrapped := "%s=" % tag_name
	for t in tags:
		if t.begins_with(wrapped):
			return t.replace(wrapped, "").strip_edges()
	return ""
