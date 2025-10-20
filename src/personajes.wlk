import wollok.game.*
import objetos.*

class Personaje inherits ElementoDeJuego {
  

  method position(_nuevaPosition) {
      if (self.puedeMoverse(_nuevaPosition)) {
          position = _nuevaPosition
      }
  }

  method position() = position
  method img(_nuevaImg) { img = _nuevaImg }
  method image() = img
 
  // metodo que verifica si la posición está dentro del rombo "piso"
  method puedeMoverse(_pos) {
      var x = _pos.x()
      var y = _pos.y()
      
      var xMin
      var xMax

      if (y <= 20) { // parte inferior del rombo
          xMin = (y - 0)/(-0.541) + 35
          xMax = (y - 0)/0.513 + 35
      } else { // parte superior del rombo
          xMin = (y - 20)/0.541 - 2
          xMax = (y - 20)/(-0.513) + 74
      }

      return x >= xMin && x <= xMax
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
        if (self.objetoEnMano() == null) {
            objetoEnMano = objeto
            // hacemos como que el objeto la siga? raro...
        }
    }

    method soltar() {
        // la logica para que tipo tire el objeto en la puerta o asi
        objetoEnMano = null
    }
}

// PERSONAJES NPSCS
class Raton inherits Personaje  {
    var property pista
    override method esInteractuable() = true
    // como implementa Interactuable, TIENE QUE tener este método.
    override method interactuar(personaje) {
        personaje.disminuirEstres(10)
        game.say(self, pista) // game.say() muestra un mensaje en pantalla
    }
}

// gato y las hermanastras molestan a Cenicienta
class Gato inherits Personaje  {
    override method esInteractuable() = true
    override method interactuar(personaje) {
        personaje.aumentarEstres(15)
        game.say(self, "Miau... (te juzga)")
    }
}

class Hermanastra inherits Personaje {
    override method esInteractuable() = true
    override method interactuar(personaje) {
        personaje.aumentarEstres(20)
        game.say(self, "¡Te voy a acusar!")
    }
}