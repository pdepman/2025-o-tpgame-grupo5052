import wollok.game.*
import objetos.* import barraEstres.*

class Personaje inherits ObjetoInteractuable {
  override method position(_nuevaPosition) {
    position = _nuevaPosition
  }
  
  override method position() = position
  
  override method image(_nuevaImg) {
    image = _nuevaImg
  }
  
  override method image() = image
  
  override method interactuar(personaje, juego) {}
}

class Cenicienta inherits Personaje {
  var property estres = 0
  var objetosRecolectados = new List()
  
 method agarrar(objeto) {
    objetosRecolectados.add(objeto)
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
  var yaDesestreso = false //unavez sola quiero q la desetresen por nivel!!

  method aplicarEfecto(personaje) {
    if(reduccionEstress > 0 && !yaDesestreso) { 
      personaje.disminuirEstres(reduccionEstress) 
      yaDesestreso = true
    }
  }

  override method interactuar(personaje, juego) {
    self.aplicarEfecto(personaje)
    game.say(self, pista) 
  }
}
