class_name DebugProperty
extends Node

enum DisplayOption { DEFAULT, LENGTH, ROUNDED }

var num_format = "%4.2f"
var object: Node  # The object being tracked.
var property: NodePath  # The property to display (NodePath).
var label_ref: Label  # A reference to the Label.
var display: DisplayOption  # Display option (rounded, etc.)


func _init(_object, _property, _label, _display):
	object = _object
	property = _property
	label_ref = _label
	display = _display


func set_label():
	# Sets the label's text.
	var label_text = object.name + "/" + property.get_concatenated_names() + " : "
	var property_value = object.get_indexed(property)
	match display:
		DisplayOption.DEFAULT:
			label_text += str(property_value)
		DisplayOption.LENGTH:
			label_text += num_format % property_value.length()
		DisplayOption.ROUNDED:
			match typeof(property_value):
				TYPE_INT, TYPE_FLOAT:
					label_text += num_format % property_value
				TYPE_VECTOR2, TYPE_VECTOR3:
					label_text += str(property_value.round())
	label_ref.text = label_text
