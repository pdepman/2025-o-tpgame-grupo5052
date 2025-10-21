import wollok.game.*
import objetos.*
import juego.*

class Personaje inherits ElementoDeJuego {

  // Sobrescribe el setter de position de la superclase
  override method position(_nuevaPosition) {
    if (self.puedeMoverse(_nuevaPosition)) {
      position = _nuevaPosition
    }
  }

  // Sobrescribe el getter de position
  override method position() = position

  // IMPORTANTE: usar la propiedad 'image' (no 'img')
  override method image(_nuevaImg) { image = _nuevaImg }
  override method image() = image

  // Verifica si la nueva posición entra en el “rombo piso”
  method puedeMoverse(_pos) {
    const x = _pos.x()
    const y = _pos.y()

    var xMin
    var xMax

    if (y <= 20) {            // parte inferior del rombo
      xMin = (y - 0)/(-0.541) + 35
      xMax = (y - 0)/0.513 + 35
    } else {                  // parte superior del rombo
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
  const prendas = new List()

  method aumentarEstres(cantidad) { estres = (estres + cantidad).min(estresMaximo) }
  method disminuirEstres(cantidad) { estres = (estres - cantidad).max(0) }
  method agregarPrenda(prenda) { prendas.add(prenda) }
  method objetoEnMano() = objetoEnMano

  method agarrar(objeto) {
    if (self.objetoEnMano() == null) { objetoEnMano = objeto }
  }
  method soltar() { objetoEnMano = null }
}

const cenicienta = new Cenicienta(
    position = game.at(20, 8), 
    image = "cenicientaPobre.png"
    )


object ratones inherits ObjetoInteractuable(
  position = game.at(20,18),
  image = "ratones.png"
) {
  override method interactuar(personaje) {
    // Pide al nivel actual la pista y cuanto deberia reducir del estress
    var pista = juego.nivelActual().pistaParaRatones()
    var reduccionEstress = juego.nivelActual().reduccionEstress()

    if (reduccionEstress > 0) personaje.disminuirEstres(reduccionEstress) 

    game.say(self, pista)
  }
}


class Hermanastra inherits Personaje {
  override method esInteractuable() = true
  override method interactuar(personaje) {
    personaje.aumentarEstres(20)
    game.say(self, "¡Te voy a acusar!")
  }
}
