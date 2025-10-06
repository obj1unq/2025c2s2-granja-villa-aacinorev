import wollok.game.*
import cultivos.*
import bonus.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"
	var property cosechasParaVenta = []
	var property oro = 0
	var property aspersoresPuestos = []

	method cultivosAqui () {
		const cultivos = game.getObjectsIn(self.position())
		cultivos.remove(self)
		return cultivos
	}

	method cultivoAqui(){
		return self.cultivosAqui().first()
	}

	method sembrarMaiz(){
		self.validarPoner()
		const nuevoMaiz = new Maiz (position = self.position())
		game.addVisual(nuevoMaiz)
	}

	method sembrarTrigo(){
		self.validarPoner()
		const nuevoTrigo = new Trigo (position = self.position())
		game.addVisual(nuevoTrigo)
	}

	method sembrarTomaco(){
		self.validarPoner()
		const nuevoTomaco = new Tomaco (position = self.position())
		game.addVisual(nuevoTomaco)
	}

	method validarPoner(){
		if (not self.cultivosAqui().isEmpty()){
			self.error("Ya hay algo acá!")
		}
	}

	method regar(){
		self.cultivoAqui().seRiega()
	}

	method cosechar(){
		self.validarCosechado()
		if(self.cultivoAqui().esCosechable()){				//Si es cosechable...
			cosechasParaVenta.add(self.cultivoAqui())	    //Recordar lo que voy a cosechar
			game.removeVisual(self.cultivoAqui())   		//Cosecharlo
		}
		else{
			self.error("No está listo para cosechar!")
		}
	}
	
	method validarCosechado(){
		if (self.cultivosAqui().isEmpty()){
			self.error("No hay un cultivo para cosechar!")
		}
	}

	method vender(){
		cosechasParaVenta.forEach({planta => oro += planta.valor()})
		cosechasParaVenta.clear()
	}

	method estadoActual(){
		return "Tengo " + oro + " monedas, y " + cosechasParaVenta.size() + " plantas para vender."
	}

	method ponerAspersor(){
		const nuevoAspersor = new Aspersor (position = self.position())
		game.addVisual(nuevoAspersor)
		aspersoresPuestos.add(nuevoAspersor)
	}

	method seRiega(){
        // No hace nada, no es regable
    }
}