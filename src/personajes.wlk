import objetos.*

// un Personaje "es un" ElementoDeJuego, pero además, sabe moverse.
// sigue siendo abstracta porque no tendremos un "personaje genérico" como un gusto de helado no existe el gusto "helado".
abstract class Personaje inherits ElementoDeJuego {
    method mover(unaPosicion) {
        position = unaPosicion
    }
}

// LA MAIN CHARACTER hereda de Personaje, por lo que ya sabe moverse
// y tiene posición e imagen.
class Cenicienta inherits Personaje {
    var estres = 0
    const estresMaximo = 100
    var objetoEnMano = null
    var prendas = new List() // Una lista para guardar las prendas que gana onda: vestido, guantes, blabla

    // metodos para controlar su estado interno (Encapsulamiento)
    method aumentarEstres(cantidad) {
        estres = (estres + cantidad).min(estresMaximo)
    }

    method disminuirEstres(cantidad) {
        estres = (estres - cantidad).max(0)
    }

    method agregarPrenda(prenda) {
        prendas.add(prenda)
    }

    // metodos para los controles del juego
    method agarrar(objeto) {
        if (self.objetoEnMano() == null && objeto.esAgarrable()) {
            objetoEnMano = objeto
            // hacemos como que el objeto la siga? raro...
        }
    }

    method soltar() {
        // la logica para que tipo tire el objeto en la puerta o asi
        objetoEnMano = null
    }
}

// los ratones ayudan a Cenicienta
class Raton inherits Personaje implements Interactuable {
    var property pista

    // como implementa Interactuable, TIENE QUE tener este método.
    override method interactuar(personaje) {
        personaje.disminuirEstres(10)
        game.say(self, pista) // game.say() muestra un mensaje en pantalla
    }
}

// gato y las hermanastras molestan a Cenicienta
class Gato inherits Personaje implements Interactuable {
    override method interactuar(personaje) {
        personaje.aumentarEstres(15)
        game.say(self, "Miau... (te juzga)")
    }
}

class Hermanastra inherits Personaje implements Interactuable {
    override method interactuar(personaje) {
        personaje.aumentarEstres(20)
        game.say(self, "¡Te voy a acusar con mamá!")
    }
}