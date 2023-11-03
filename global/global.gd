extends Node
#accessible as g.whatever

const project = "monstars"

var lspecies
var species
var lmoves
var moves
#type rels, ...

var rng

var datapath = "res:/"#/data/default"
const mtscnpath = "/montscns/"

var n = .4#stat something blend value

var mode = "you"

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	
	#load data/project/species, moves, etc
	#loldatapath
	
	lspecies = load(datapath + "/species.gd").new()#ok
	species = lspecies.species#????
	
	print(lspecies.getname("lileaf"))#this is... ok i guess
	
	lmoves = load(datapath + "/moves.gd").new()
	moves = lmoves.moves
	
	print(moves["nutshot"])
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
