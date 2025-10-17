import wollok.game.*
import cultivos.*
import personaje.*

// Aspersores
class Aspersor {
    var property position
    method image(){
        return "aspersor.png"
    }

    method cultivoEn(direccion) {
		const cultivos = game.getObjectsIn(direccion.siguiente(position))   // Coleccion de objetos en la dirección dada
		if (not cultivos.isEmpty()){       // Si la colección no es vacía, significa que hay algo
            return cultivos.first()        // Me dice el cultivo que esta aquí
        }
        else {
            return self                    // Devuelve el aspersor porque cuando se riega, no hace nada. Hago esto para evitar el error de .first (si no hay nada en una dirección, la precondición de que no puede estar vacía la colección no se cumple)
        }
	}

    method regarTodos() {
        const direcciones = [norte, noreste, este, sureste, sur, suroeste, oeste, noroeste]  
        direcciones.forEach{direccion => self.cultivoEn(direccion).seRiega()}   // Recorre la lista de direcciones. Riega lo que haya en cada dirección
    }

    method seRiega(){
        // No hace nada, no es regable
    }
}

// Direcciones
object norte {
    method siguiente(position){
        return position.up(1)
    }
}

object noreste {
    method siguiente(position){
        return norte.siguiente(este.siguiente(position))
    }
}

object este {
    method siguiente(position){
        return position.right(1)
    }
}

object sureste {
    method siguiente(position){
        return sur.siguiente(este.siguiente(position))
    }
}

object sur {
    method siguiente(position){
        return position.down(1)
    }
}

object suroeste {
    method siguiente(position){
        return sur.siguiente(oeste.siguiente(position))
    }
}

object oeste {
    method siguiente(position){
        return position.left(1)
    }
}

object noroeste {
    method siguiente(position){
        return norte.siguiente(oeste.siguiente(position))
    }
}

// Mercados

class Mercado {
    var property position
    const property image = "market.png"
    var property monedas = 0
    const mercaderia = []

    method comprar(bienes, precio){
        self.validarCompra(precio)
        monedas -= precio
        mercaderia.addAll(bienes)
    }

    method validarCompra(valor){
        if (monedas < valor){
            self.error("El mercado no tiene suficientes monedas para comprar.")
        }
    }

    method seRiega(){
        // No hace nada, no es regable
    }
}