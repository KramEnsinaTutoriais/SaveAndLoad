extends Control

var life = 100
var coin = 0
var weapons = {"sword":false,"spear":false,"shield":false}
var skills = {"jump":false,"atakMagic":false}
var itens = []

@onready var lbLife = $%Lb_life
@onready var lbCoin = $%Lb_coin
@onready var lbWeapons = $%Lb_weapons
@onready var lbSkill = $%Lb_skill
@onready var lbItens = $%Lb_itens
@onready var lbSlots = $Lb_saveSlot #new
@onready var slotMenu = %slotButton #new

func _ready():
	
	slotMenu.get_popup().connect("id_pressed", Callable(self, "on_bt_menu_pressed"))#new
	var result = SaveAndload.load_game()
	print(result)
	update_parameters(result[str("slot",SaveAndload.slot_current)]) #new parameter
	
	

#================================================================
#                     events buttons
#================================================================

func _on_bt_reset_save_pressed():
	
	var result = SaveAndload.reset_data()
	update_parameters(result)
	
func _on_bt_load_pressed():
	
	var result = SaveAndload.load_game()
	update_parameters(result[str("slot",SaveAndload.slot_current)])

func _on_bt_save_all_pressed():
	
	SaveAndload.save_all_parameters({
	"life":life, 
	"coin":coin,
	"weapons":weapons,
	"skills":skills,
	"itens":itens
})

func _on_bt_save_life_pressed():
	
	SaveAndload.save_only_life(life)
	
	
func _on_bt_add_life_pressed():
	life += 10
	update_labels_generics()

func _on_bt_sub_life_pressed():
	life -= 10
	update_labels_generics()


func _on_bt_add_coin_pressed():
	coin += 10
	update_labels_generics()


func _on_bt_sub_coin_pressed():
	coin -= 10
	update_labels_generics()

func _on_bt_add_jump_pressed():
	skills.jump = true
	update_label_skills()


func _on_bt_sub_jump_pressed():
	skills.jump = false
	update_label_skills()


func _on_bt_add_apple_pressed():
	itens.append("apple")
	update_label_itens()

func _on_bt_sub_chicken_pressed():
	itens.append("chicken")
	update_label_itens()

func _on_bt_shield_pressed():
	
	weapons.shield = !weapons.shield
	update_label_weapons()

func _on_bt_sword_pressed():
	
	weapons.sword = !weapons.sword
	update_label_weapons()

func _on_bt_spear_pressed():
	
	weapons.spear = !weapons.spear
	update_label_weapons()
#====================================================================
#                   functions 
#====================================================================

func update_label_weapons():
	
	lbWeapons.text = str("Armas: Escudo: ",weapons.shield,", Espada: ",weapons.sword,", Lança: ",weapons.spear)
	
func update_label_itens():
	
	lbItens.text = str("Itens: ",itens)
	
func update_label_skills():
	
	lbSkill.text = str("Hablidade  de  pulo duplo: ",skills)
	
func update_labels_generics():
	
	lbLife.text = str("Vida: ",life)
	lbCoin.text = str("Moedas: ",coin)

func update_parameters(data):
		
	if data.size()>0:#new
		life = data.life 
		coin = data["coin"]
		weapons = data["weapons"]
		skills = data["skills"]
		itens = data["itens"]
		update_labels_generics()
		update_label_itens()
		update_label_skills()
		update_label_weapons()
	else:#new
		life = 100 
		coin = 0
		weapons = {"sword":false,"spear":false,"shield":false}
		skills ={"jump":false,"atakMagic":false}
		itens = []
		update_labels_generics()
		update_label_itens()
		update_label_skills()
		update_label_weapons()
	lbSlots.text = str(SaveAndload.slot_current)
		
func on_bt_menu_pressed(id):#new
	
	#print(slotMenu.get_popup().get_item_text(id))
	lbSlots.text = str(slotMenu.get_popup().get_item_text(id))
	SaveAndload.slot_current = int(slotMenu.get_popup().get_item_text(id))
	var result = SaveAndload.load_game()
	update_parameters(result[str("slot",SaveAndload.slot_current)])
