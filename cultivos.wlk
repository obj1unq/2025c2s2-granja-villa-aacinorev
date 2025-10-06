import wollok.game.*

class Maiz {
	var property position = game.at(1,1)
	var property image = "corn_baby.png"
	var fueRegada = false

	method seRiega(){
		if (not fueRegada){
			image = "corn_adult.png"  // Si no fue regada antes, se riega
			fueRegada = true
		}
	}
}

class Trigo {
	var property position = game.at(2,1)
	method image(){
		return "wheat_0.png"
	}
}

class Tomaco {
	var property position = game.at(3,1)
	method image(){
		return "tomaco.png"
	}
}