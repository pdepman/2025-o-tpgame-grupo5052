import wollok.game.*
import objetos.*

class Personaje inherits ElementoDeJuego {

  // Sobrescribe el setter de position de la superclase
  override method position(_nuevaPosition) {
    // if (self.puedeMoverse(_nuevaPosition)) {
      position = _nuevaPosition
    // }
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

class Cenicienta {
    var property position
    var property image
    var property estres = 100
    
    var objetosRecolectados = new List()

    method agarrar(objeto) {
        objetosRecolectados.add(objeto)
        console.println("Cenicienta agarró: " + objeto.nombre())
    }
    
    method objetosRecolectados() {
        return objetosRecolectados
    }
    
    method disminuirEstres(valor) {
        estres = 0.max(estres - valor)
    }
    method limpiarObjetos() {
        objetosRecolectados.clear()
    }
}
const cenicienta = new Cenicienta(
    position = game.at(20, 8), 
    image = "cenicientaPobre.png"
    )

class Raton inherits Personaje  {
  var property pista
  override method esInteractuable() = true
 method interactuar(personaje) {
    personaje.disminuirEstres(10)
    game.say(self, pista)
  }
}

class Gato inherits Personaje  {
  override method esInteractuable() = true
  method interactuar(personaje) {
    personaje.aumentarEstres(15)
    game.say(self, "Miau... (te juzga)")
  }
}

class Hermanastra inherits Personaje {
  override method esInteractuable() = true
   method interactuar(personaje) {
    personaje.aumentarEstres(20)
    game.say(self, "¡Te voy a acusar!")
  }
}
