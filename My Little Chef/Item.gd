extends Node

enum item_types {INGREDIENT, PREBAKED, BAKED_GOOD, DEFAULT}

class Item:
	var sale_price = 0.00
	var description = ""
	var icon = ""
	var type = item_types.DEFAULT
	var string_item_name = ""
	var id = 0
	
	func _init(p_id, p_string_item_name, p_type, p_icon, p_description, p_sale_price):
		id = p_id
		string_item_name = p_string_item_name
		type = p_type
		icon = p_icon 
		description = p_description
		sale_price = p_sale_price


class ItemData:
	var _dict = {}
	
	func get_item(string_item_name):
		if _dict.has(string_item_name):
			return _dict[string_item_name]
	
	func create_item(string_item_name):
		var p_id = string_item_name["id"]
		#print(p_id)
		var p_icon = string_item_name["icon"]
		#print(p_icon)
		var p_type = string_item_name["type"]
		#print(p_type)
		var p_description = string_item_name["description"]
		#print(p_description)
		var p_sale_price = string_item_name["sale_price"]
		#print(p_sale_price)
		var p_item_name = string_item_name["string_item_name"]
		#print(p_item_name)
		_dict[p_item_name] = Item.new(p_id, p_item_name, p_type, p_icon, p_description, p_sale_price)
		#print("_dict[p_item_name] = ", _dict[p_item_name])



class Inventory:
	var _dict = {}
	var _item_data = null
	
	func _init(item_data_class_instance):
		_item_data = item_data_class_instance
	
	func get_item_count(string_item_name):
		if _dict.has(string_item_name):
			return _dict[string_item_name]
		else:
			return 0
	
	func add_item(string_item_name, n):
		_dict[string_item_name] = get_item_count(string_item_name) + n
	
	func remove_item(string_item_name, n):
		var item_count = get_item_count(string_item_name)
		if item_count:
			if item_count <= n:
				_dict.erase(string_item_name)
			else:
				 _dict[string_item_name] = item_count - n
	
	func get_all_by_type(type_specifier):
		var retval = []
		for string_item_name in _dict.keys():
			var item = _item_data.get_item(string_item_name)
			if item.type == type_specifier:
				retval.append(item)
		return retval
