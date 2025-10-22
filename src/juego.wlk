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
  var fondoActual = null
  
  method iniciar() {
    game.title("Wollok de Cristal")
    game.height(200)
    game.width(200)
    game.cellSize(10)

   
    
    nivelesDelJuego.add(new NivelEntrada())
    nivelesDelJuego.add(new NivelCocina())
    //nivelesDelJuego.add(new NivelDormitorio())
    
    self.configurarPersonaje()
    self.irANivel(0)
    
    game.start()
  }
  
  method irANivel(numeroDeNivel) {
    if (game.hasVisual(cenicienta)) {
      game.removeVisual(cenicienta)
    }
    
    elementosEnEscena.forEach({ elem => 
      if (game.hasVisual(elem)) {
        game.removeVisual(elem)
      }
    })
    elementosEnEscena.clear()
    
    if (fondoActual != null && game.hasVisual(fondoActual)) {
      game.removeVisual(fondoActual)
    }
    self.detenerEstresPorTiempo()
    
    const nivelACargar = nivelesDelJuego.get(numeroDeNivel)
    nivelActual = numeroDeNivel
    nivelACargar.configurar(self)
  }
  //no acumuilo
  method detenerEstresPorTiempo() {
		game.removeTickEvent("aumentarEstresPorTiempo")
	}

  method iniciarEstresPorTiempo(misionFallidaCallback) {
		self.detenerEstresPorTiempo()
		
		game.onTick(5000, "aumentarEstresPorTiempo", {
			
			cenicienta.aumentarEstres(10) 
			
			if (cenicienta.estaAlMaximoEstres()) {
				self.detenerEstresPorTiempo()
				
				misionFallidaCallback.apply()
			}
		})
	}

  method configurarPersonaje() {
    keyboard.up().onPressDo({
      cenicienta.position(cenicienta.position().up(5))
      self.verificarColisionesCercanas()
      if (!nivelesDelJuego.isEmpty()) {
        nivelesDelJuego.get(nivelActual).avanzarNivel(self)
      }
      game.say(cenicienta, "Coord x:" + cenicienta.position().x() + " y:" + cenicienta.position().y())
    })
    
    keyboard.down().onPressDo({
      cenicienta.position(cenicienta.position().down(5))
      self.verificarColisionesCercanas()
      if (!nivelesDelJuego.isEmpty()) {
        nivelesDelJuego.get(nivelActual).avanzarNivel(self)
      }
      game.say(cenicienta, "Coord x:" + cenicienta.position().x() + " y:" + cenicienta.position().y())
    })
    
    keyboard.left().onPressDo({
      cenicienta.position(cenicienta.position().left(5))
      self.verificarColisionesCercanas()
      if (!nivelesDelJuego.isEmpty()) {
        nivelesDelJuego.get(nivelActual).avanzarNivel(self)
      }
      game.say(cenicienta, "Coord x:" + cenicienta.position().x() + " y:" + cenicienta.position().y())
    })
    
    keyboard.right().onPressDo({
      cenicienta.position(cenicienta.position().right(5))
      self.verificarColisionesCercanas()
      if (!nivelesDelJuego.isEmpty()) {
        nivelesDelJuego.get(nivelActual).avanzarNivel(self)
      }
      game.say(cenicienta, "Coord x:" + cenicienta.position().x() + " y:" + cenicienta.position().y())
    })
  }
  
  method cambiarFondo(nombreImagen) {
    const teniaCenicienta = game.hasVisual(cenicienta)
    if (teniaCenicienta) {
      game.removeVisual(cenicienta)
    }
    
    if (fondoActual != null && game.hasVisual(fondoActual)) {
      game.removeVisual(fondoActual)
    }
    
    fondoActual = object {
      var property position = game.at(0, 0)
      var property image = nombreImagen
    }
    
    game.addVisual(fondoActual)
    game.addVisual(cenicienta)
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
  
  method agregarCenicienta() {
    if (!game.hasVisual(cenicienta)) {
      game.addVisual(cenicienta)
    }
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

  method completarMision(imagenVictoria, posicionVictoria, imagenHermanas, posicionHermanas, mensaje) {
    self.detenerEstresPorTiempo()
    
    elementosEnEscena.forEach({ elem => 
      if (game.hasVisual(elem)) {
        game.removeVisual(elem)
      }
    })
    elementosEnEscena.clear()
    
    cenicienta.limpiarObjetos()
    barraEstres.resetear()
    
    const imageVictoria = object {
      var property position = posicionVictoria
      var property image = imagenVictoria
    }
    game.addVisual(imageVictoria)
    
    if (imagenHermanas != "") {
      const imageHermanas = object {
        var property position = posicionHermanas
        var property image = imagenHermanas
      }
      game.addVisual(imageHermanas)
    }
    
    game.say(cenicienta, mensaje)
  }

  method fallarMision(imagenDerrota, posicionDerrota, imagenHermanas, posicionHermanas, mensaje) {
    self.detenerEstresPorTiempo()
    elementosEnEscena.forEach({ elem => 
      if (game.hasVisual(elem)) {
        game.removeVisual(elem)
      }
    })
    elementosEnEscena.clear()
    
    cenicienta.limpiarObjetos()
    barraEstres.resetear()
    
    const imageDerrota = object {
      var property position = posicionDerrota
      var property image = imagenDerrota
    }
    game.addVisual(imageDerrota)
    
    if (imagenHermanas != "") {
      const imageHermanas = object {
        var property position = posicionHermanas
        var property image = imagenHermanas
      }
      game.addVisual(imageHermanas)
    }
    
    game.say(cenicienta, mensaje)
  }

  method removerElemento(elemento) {
    elementosEnEscena.remove(elemento)
  }
}