extends Node


var file_path = "user://saveData.sav"

var slot_current = 1#new
var slots={"slot1":{},"slot2":{},"slot3":{}}#new
const KEY_HASH = ""#new

func _ready():#new
	
	var pathexe = OS.get_executable_path().get_base_dir()#new
	file_path = pathexe + "/saveData.sav"#new

var save_data = {
	
	"life":100, 
	"coin":0,
	"weapons":{"sword":false,"spear":false,"shield":false},
	"skills":{"jump":false,"atakMagic":false},
	"itens":[]
}

func save_game():
	
	var file_save = FileAccess.open(file_path, FileAccess.WRITE)
	print(file_path)
	file_save.store_var(slots)
	file_save.close()
	
func load_game():
	
	if FileAccess.file_exists(file_path):
		var fileLoad = FileAccess.open(file_path, FileAccess.READ)
		var save_return = fileLoad.get_var()
		slots = save_return#new 
		return slots
	else:
		print("File Not Found")
		return slots
		
func save_all_parameters(data:Dictionary):
	
	save_data = data
	slots[str("slot",slot_current)] = save_data #new 

	save_game()
	
func save_only_life(life:int):
	
	if save_data.has("life"):
		save_data.life = life
		slots[str("slot",slot_current)]["life"] = save_data.life#new parameter
		save_game()
	else:
		print("Life not found")
	
func reset_data():
	
	var data_default = {
	"life":100, 
	"coin":0,
	"weapons":{"sword":false,"spear":false,"shield":false},
	"skills":{"jump":false,"atakMagic":false},
	"itens":[]
}
	save_data = data_default.duplicate(true)
	slots[str("slot",slot_current)] = save_data#new
	save_game()
	return slots[str("slot",slot_current)]#new return
