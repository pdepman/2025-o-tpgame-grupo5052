import barraEstres.*
import wollok.game.*
import personajes.*
import objetos.*
import niveles.*

object juego {
  var property cenicienta = new Cenicienta(
    position = game.at(0, 0),
    image = "cenicientaPobre.png"
  )
  var nivelesDelJuego = new List()
  var elementosEnEscena = new List()
  var property nivelActual = 0  
  var configuracionCompleta = false
  
  method iniciar() {
    game.title("Wollok de Cristal")
    game.height(200)
    game.width(200)
    game.cellSize(10)
    
    game.addVisual(cenicienta)
    game.showAttributes(cenicienta)
    
    nivelesDelJuego.add(new NivelEntrada())
    nivelesDelJuego.add(new NivelCocina())
    nivelesDelJuego.add(new NivelDormitorio())
    
    self.irANivel(0)
    
    game.start()
  }
  
  method irANivel(numeroDeNivel) {
    configuracionCompleta = false
    
    // Limpiar elementos del nivel anterior
    elementosEnEscena.forEach({ elem => 
      try {
        game.removeVisual(elem)
      } catch e {
      }
    })
    elementosEnEscena.clear()
    
    // Limpiar todo
    game.clear()
    
    // Agregar cenicienta de nuevo
    game.addVisual(cenicienta)
    
    // Cargar el nivel
    const nivelACargar = nivelesDelJuego.get(numeroDeNivel)
    nivelActual = numeroDeNivel
    
    nivelACargar.configurar(self)
    
    self.configurarPersonaje()
    
    configuracionCompleta = true
  }
  
  method configurarPersonaje() {
    keyboard.up().onPressDo({
      if (configuracionCompleta) {
        cenicienta.position(cenicienta.position().up(5))
        self.verificarColisionesCercanas()
        nivelesDelJuego.get(nivelActual).avanzarNivel(self)
        game.say(
          cenicienta,
          (("Coord x:" + cenicienta.position().x()) + " y:") + cenicienta.position().y()
        )
      }
    })
    
    keyboard.down().onPressDo({
      if (configuracionCompleta) {
        cenicienta.position(cenicienta.position().down(5))
        self.verificarColisionesCercanas()
        nivelesDelJuego.get(nivelActual).avanzarNivel(self)
        game.say(
          cenicienta,
          (("Coord x:" + cenicienta.position().x()) + " y:") + cenicienta.position().y()
        )
      }
    })
    
    keyboard.left().onPressDo({
      if (configuracionCompleta) {
        cenicienta.position(cenicienta.position().left(5))
        self.verificarColisionesCercanas()
        nivelesDelJuego.get(nivelActual).avanzarNivel(self)
        game.say(
          cenicienta,
          (("Coord x:" + cenicienta.position().x()) + " y:") + cenicienta.position().y()
        )
      }
    })
    
    keyboard.right().onPressDo({
      if (configuracionCompleta) {
        cenicienta.position(cenicienta.position().right(5))
        self.verificarColisionesCercanas()
        nivelesDelJuego.get(nivelActual).avanzarNivel(self)
        game.say(
          cenicienta,
          (("Coord x:" + cenicienta.position().x()) + " y:") + cenicienta.position().y()
        )
      }
    })
  }
  
  method agregarElemento(elemento) {
    elementosEnEscena.add(elemento)
    game.addVisual(elemento)
  }
  
  method configurarColision(objeto) {
    game.onCollideDo(cenicienta, { elem =>
      if (elem == objeto) {
        objeto.interactuar(cenicienta, self)
      }
    })
  }
  
  method estaCerca(objeto, radio) {
    const distX = (cenicienta.position().x() - objeto.position().x()).abs()
    const distY = (cenicienta.position().y() - objeto.position().y()).abs()
    return distX <= radio && distY <= radio
  }
  
  method verificarColisionesCercanas() {
    elementosEnEscena.forEach({ elem =>
        if (self.estaCerca(elem, 20)) {
            elem.interactuar(cenicienta, self)
        }
    })
  }

  method estaCercaDe(objeto, radio) {
    const distX = (cenicienta.position().x() - objeto.position().x()).abs()
    const distY = (cenicienta.position().y() - objeto.position().y()).abs()
    
    const distancia = ((distX * distX) + (distY * distY)).squareRoot()
    
    return distancia <= radio
  }
  
  method cambiarFondo(nombreImagen) {
    game.boardGround(nombreImagen)
    game.removeVisual(cenicienta)
    game.schedule(1, { 
      game.addVisual(cenicienta)
    })
  }

  // ========== COMPLETAR MISIÓN ==========
  method completarMisionCocina() {
    console.println("¡Misión de la Cocina Completada!")
    
    elementosEnEscena.forEach({ elem => 
        try {
            game.removeVisual(elem)
        } catch e {
            console.println("Error al remover: " + e)
        }
    })
    
    elementosEnEscena.clear()
    
    game.boardGround("trampaLograda.png") 
    
    cenicienta.limpiarObjetos()
    barraEstres.resetear()
    
    game.say(cenicienta, "¡Lograste vencer a las hermanastras!")
    
    /* game.schedule(2000, { 
        self.irANivel(self.nivelActual() + 1) 
    }) */
  }

  // ========== FALLAR MISIÓN (NUEVO) ==========
  method fallarMisionCocina() {
    console.println("¡Misión de la Cocina Fallida! - Estrés al máximo")
    
    // Limpiar elementos
    elementosEnEscena.forEach({ elem => 
        try {
            game.removeVisual(elem)
        } catch e {
            console.println("Error al remover: " + e)
        }
    })
    
    elementosEnEscena.clear()
    
    // Cambiar a imagen de derrota
    game.boardGround("trampaFallida.png")
    
    cenicienta.limpiarObjetos()
    barraEstres.resetear()
    
    game.say(cenicienta, "¡El estrés te venció! No pudiste completar la misión a tiempo...")
    
    // Opcional: Reiniciar el nivel después de unos segundos
    /* game.schedule(3000, { 
        self.irANivel(nivelActual) // Reinicia el mismo nivel
    }) */
  }

  method completarMisionDormitorio() {
    console.println("¡Misión del Dormitorio Completada!")
    
    elementosEnEscena.forEach({ elem => 
        try {
            game.removeVisual(elem)
        } catch e {
            console.println("Error al remover: " + e)
        }
    })
    
    elementosEnEscena.clear()
    
    game.boardGround("trampaLograda.png")
    
    cenicienta.limpiarObjetos()
    barraEstres.resetear()
    
    game.say(cenicienta, "¡Completaste el dormitorio!")
  }

  method fallarMisionDormitorio() {
    console.println("¡Misión del Dormitorio Fallida! - Estrés al máximo")
    
    elementosEnEscena.forEach({ elem => 
        try {
            game.removeVisual(elem)
        } catch e {
            console.println("Error al remover: " + e)
        }
    })
    
    elementosEnEscena.clear()
    
    game.boardGround("trampaFallida.png")
    
    cenicienta.limpiarObjetos()
    barraEstres.resetear()
    
    game.say(cenicienta, "¡El estrés te venció en el dormitorio!")
  }

  method removerElemento(elemento) {
    elementosEnEscena.remove(elemento)
  }
}