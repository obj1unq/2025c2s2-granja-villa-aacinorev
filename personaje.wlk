import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"
	method cultivosAqui () {
		const cultivos = game.getObjectsIn(self.position())
		cultivos.remove(self)
		return cultivos
	}
	method cultivoAqui(){
		return self.cultivosAqui().first()
	}
	method sembrarMaiz(){
		self.validarSembrado()
		const nuevoMaiz = new Maiz (position = self.position())
		game.addVisual(nuevoMaiz)
	}

	method sembrarTrigo(){
		self.validarSembrado()
		const nuevoTrigo = new Trigo (position = self.position())
		game.addVisual(nuevoTrigo)
	}

	method sembrarTomaco(){
		self.validarSembrado()
		const nuevoTomaco = new Tomaco (position = self.position())
		game.addVisual(nuevoTomaco)
	}

	method regar(){
		self.cultivoAqui().seRiega()
	}

	method validarSembrado(){
		if (not self.cultivosAqui().isEmpty()){
			self.error("Ya hay un cultivo ahi!")
		}
	}
}