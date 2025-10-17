import wollok.game.*
import cultivos.*
import bonus.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"
	var property cosechasParaVenta = []
	var property oro = 0
	var property aspersoresPuestos = []

	method cosasAqui () {
		const cultivos = game.getObjectsIn(self.position())
		cultivos.remove(self)
		return cultivos
	}

	method cosaAqui(){
		return self.cosasAqui().first()
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
		if (not self.cosasAqui().isEmpty()){
			self.error("Ya hay algo acá!")
		}
	}

	method regar(){
		self.validarRegar()
		self.cosaAqui().seRiega()
	}

	method validarRegar(){
		if (self.cosasAqui().isEmpty()){
			self.error("No puedo regar la nada!")
		}
	}

	method cosechar(){
		self.validarCosechado()
		if(self.cosaAqui().esCosechable()){				//Si es cosechable...
			cosechasParaVenta.add(self.cosaAqui())	    //Recordar lo que voy a cosechar
			game.removeVisual(self.cosaAqui())   		//Cosecharlo
		}
		else{
			self.error("No está listo para cosechar!")
		}
	}
	
	method validarCosechado(){
		if (self.cosasAqui().isEmpty()){
			self.error("No hay un cultivo para cosechar!")
		}
	}
	
	method valorDeCosechas(){		
		return cosechasParaVenta.sum({planta => planta.valor()})
	}

	method vender(){
		self.validarVenta()
		self.cosaAqui().comprar(cosechasParaVenta, self.valorDeCosechas())
		oro += self.valorDeCosechas()
		cosechasParaVenta.clear()
	}

	method validarVenta(){
		if(self.cosasAqui().isEmpty() || self.cosaAqui().kindName() != "a Mercado"){  // Si donde estoy parada no hay nada, tira el error. Y si donde estoy parada hay algo pero no es un mercado, también tira error.
			self.error("No puedo vender, no estoy en el mercado")
		}
	}

	method estadoActual(){
		return "Tengo " + oro + " monedas, y " + cosechasParaVenta.size() + " plantas para vender."
	}

	method ponerAspersor(){
		self.validarPoner()
		const nuevoAspersor = new Aspersor (position = self.position())
		game.addVisual(nuevoAspersor)
		aspersoresPuestos.add(nuevoAspersor)
	}

	method seRiega(){
        // No hace nada, no es regable
    }
}