import wollok.game.*
import objetos.*
import barraEstres.*

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
  override method image(_nuevaImg) {
    image = _nuevaImg
  }
  
  override method image() = image
}

class Cenicienta inherits Personaje {
  var property estres = 0
  var objetosRecolectados = new List()
  
  method agarrar(objeto) {
    objetosRecolectados.add(objeto).println(
      "Cenicienta agarró: " + objeto.nombre()
    )
  }
  
  method objetosRecolectados() = objetosRecolectados
  
  method limpiarObjetos() {
    objetosRecolectados.clear()
  }
  
  method sincronizarBarraEstres() {
    const nivelBarra = (estres / 20).roundUp().min(5)
    barraEstres.establecerNivel(nivelBarra)
  }
   method resetearEstres() {
    estres = 0
    self.sincronizarBarraEstres()
  }
  method aumentarEstres(valor) {
    estres = 100.min(estres + valor)
    self.sincronizarBarraEstres()
    
    if (estres >= 100) game.say(
        self,
        "Estresaste por completo a cenicienta!!!!"
      )
  }
  
  method disminuirEstres(valor) {
    estres = 0.max(estres - valor)
    self.sincronizarBarraEstres()
    
    game.say(self, ("Me siento mejor... (Estrés: " + estres) + "%)")
  }
  
  method estaAlMaximoEstres() = estres >= 100
}

class Raton inherits ObjetoInteractuable(image = "ratones.png") {
  var pista = ""
  var reduccionEstress = 0
  
  override method interactuar(personaje, juego) {

    if(reduccionEstress > 0) { // si el raton del nivel puede reducir el estres (a partir del nivel 2)
      personaje.disminuirEstres(reduccionEstress) 
    }

    game.say(self, pista)
  }
}

class Gato inherits Personaje {
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