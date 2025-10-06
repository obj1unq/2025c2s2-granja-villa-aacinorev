import wollok.game.*
import cultivos.*
import personaje.*

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
        const direcciones = [norte, este, sur, oeste]  
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

object este{
    method siguiente(position){
        return position.right(1)
    }
}

object sur{
    method siguiente(position){
        return position.down(1)
    }
}

object oeste{
    method siguiente(position){
        return position.left(1)
    }
}