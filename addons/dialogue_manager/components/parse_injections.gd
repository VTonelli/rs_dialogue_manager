extends Object

const LOCALS_PREFIX = &'__locals'

static func inject_call_for_functions(tokens, i):
	var args = tokens[i][&"value"]
	var fn_name = tokens[i][&"function"]
	tokens[i] = { &"type": &"variable", &"value": fn_name }
	tokens.insert(i+1, { &"type": &"dot" })
	tokens.insert(i+2, { &"function": "call", &"type": &"function", &"value": args, &"injected": true})
	return i-1
	
static func inject_locals_for_assignment(tokens, i):
	tokens[i][&"injected"] = true
	tokens.insert(i, { &"type": &"dot" })
	tokens.insert(i, { &"type": &"variable", &"value": LOCALS_PREFIX, &"injected": true })
	return i-1
