class_name DebugOverlay
extends MarginContainer

var props: Array[DebugProperty]


func _process(_delta):
	if not visible:
		return

	for prop in props:
		prop.set_label()


func add_property(
	object: Node,
	property: NodePath,
	_display: DebugProperty.DisplayOption = DebugProperty.DisplayOption.DEFAULT
):
	var label = Label.new()
	$VBoxContainer.add_child(label)
	props.append(DebugProperty.new(object, property, label, _display))


func remove_property(object: Node, property: NodePath):
	for prop in props:
		if prop.object == object and prop.property == property:
			props.erase(prop)
