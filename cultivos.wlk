import wollok.game.*

class Maiz {
	var property position
	var property image = "corn_baby.png"
	var fueRegada = false

	method seRiega(){
		if (not fueRegada){
			image = "corn_adult.png"  // Si no fue regada antes, se riega
			fueRegada = true
		}
	}

	method esCosechable(){
		return fueRegada
	}

	method valor(){
		return 150
	}
}

class Trigo {
	var property position
	var vecesRegada = 0
	method image() = "wheat_" + vecesRegada + ".png"

	method seRiega(){
		if (vecesRegada < 3){	//Veces regada es lo mismo que etapa de evolucion
			vecesRegada += 1
		}
		else {
			vecesRegada = 0
		}
	}

	method esCosechable(){
		return vecesRegada >= 2
	}

	method valor(){
		return (vecesRegada - 1) * 100
	}
}

class Tomaco {
	var property position
	method image(){
		return "tomaco.png"
	}

	method seRiega(){
		self.validarRegar()  // Si hay algo arriba suyo, no puede subir
		if(position != game.at(position.x(), game.height()-1)){  // Si no está en el borde, que suba
			position = position.up(1)
		}
		else{
			position = game.at(position.x(), 0)		// Si llega al borde, pasa abajo de todo
		}
	}

	method validarRegar(){
		const cosasArriba = game.getObjectsIn(position.up(1))
		if(not cosasArriba.isEmpty()){    // Si hay algo arriba suyo, no sube
			self.error("")
		}
	}

	method esCosechable(){
		return true
	}

	method valor(){
		return 80
	}
}