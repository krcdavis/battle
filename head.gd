extends Node3D

#current map and temp map
var cmap
var tmap

@onready var mmap = $forestgrass

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$btlw1on1.deactivate()
	$you/Camera3D.make_current()
	
	$you.head = self
	$btlw1on1.head = self
	
	
	if FileAccess.file_exists("user://partysave.txt"):
		print("there it is")
		#read file then setup party
		var file = FileAccess.open("user://partysave.txt", FileAccess.READ)
		#file.get_line() into volume
		$pausehud/HSlider.set_value(float(file.get_line()))
		party.partyin.clear()
		for n in range(0,3):
			party.partyin.append([file.get_line(), int(file.get_line()), -1])
		print(party.partyin)
		file.close()
		party.setup_party(party.partyin)
	else:
		print("there it isn't")
		#setup party then write file
		party.setup_party(party.partyin)
		var file = FileAccess.open("user://partysave.txt", FileAccess.WRITE)
		file.store_line('.75')
		for ay in party.partyin:
			file.store_line(ay[0])
			file.store_line(str(ay[1]))
		file.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#not used in this demo (:
func changemap(mapdata):#[map tscn name, point name]- point can be ignored for now (:
	#everything is in one folder right now
	var temp = load("res://" + mapdata[0] + ".tscn")
	tmap = temp.instantiate()
	add_child(tmap)
	var snee = tmap.get_node(mapdata[1])
	$you.position = snee.position
	#queue free cmap
	if cmap:
		cmap.queue_free()
	cmap = tmap

#hm
var index = 0
const wilds = [["flyder",10],["magnut",12],["lileaf",12],["slowcone",9],["shleep",11]]

func init_battle():
	#pause and hide current map, change global mode...
	index = g.rng.randi_range(0, wilds.size()-1)
	$btlw1on1.newbattle(wilds[index])
	mmap.visible = false

func endbattle():
	pass
	#undo init-battle
	mmap.visible = true
	$you/Camera3D.make_current()
	g.mode = "you"
	#do something to (you) to reset grasstimer

func saveparty():#and volume
	#this but get live deytah
		var file = FileAccess.open("user://partysave.txt", FileAccess.WRITE)
		file.store_line(str($pausehud/HSlider.value))
		for mon in party.party:#species_id, level
			file.store_line(mon.species_id)
			file.store_line(str(mon.level))
		file.close()

func pause():
	$pausehud.visible = true
	g.mode = "paused"

func _on_button_pressed():
	saveparty()



func _on_button_4_pressed():#unpause
	pass # Replace with function body.
	$pausehud.visible = false
	g.mode = "you"
