import barraEstres.*
import wollok.game.*
import personajes.*
import objetos.*
import niveles.*
import nivelFactory.*

object fondoIntro {
  var nombreImagen = "intro1.png"
  method image() = nombreImagen
  var position = game.at(50, 55)
  method cambiarImagen(imagenNueva) {
    nombreImagen = imagenNueva
  }
  method position() = position
  method position(nuevaPosition){
    position = nuevaPosition
  }
}
object juego {
  var property cenicienta = new Cenicienta(
    position = game.at(0, 0),
    image = "cenicientaPobre.png"
  )
  var nivelesDelJuego = new List()
  var elementosEnEscena = new List()
  var property nivelActual = 0
  var fondoActual = null
  

  
  method iniciarIntro(){
        game.title("Wollok de Cristal")
        game.height(200)
        game.width(200)
        game.cellSize(10)
        
        game.addVisual(fondoIntro)
        var pantalla = 1
        keyboard.enter().onPressDo({
          if (pantalla == 1){
            pantalla = 2
            fondoIntro.cambiarImagen("intro2.png") 
            fondoIntro.position(game.at(0, 10))

             game.schedule(5000,{
                pantalla = 3
                fondoIntro.cambiarImagen("reglas_intro.webp")

                game.schedule(5000, {
                  game.clear()
                  self.iniciar()
                })
             })
          }
        })
        
        game.start()
  }


  method iniciar() {
        //game.title("Wollok de Cristal")
        //game.height(200)
        //game.width(200)
        //game.cellSize(10)
        
        // 2. Llenamos la lista de niveles usando el Factory
        nivelesDelJuego.add(new NivelEntrada())
        
        nivelesDelJuego.add(nivelFactory.crearNivelCocina())
        nivelesDelJuego.add(nivelFactory.crearNivelDormitorio())
        nivelesDelJuego.add(nivelFactory.crearNivelBanio())
        nivelesDelJuego.add(nivelFactory.crearNivelJardin())
        
        nivelesDelJuego.add(new NivelFinal())
        
        self.configurarPersonaje()
        self.irANivel(0)
        
       // game.start()
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
  
  // saco la barra temporalmente
  if (game.hasVisual(barraEstres)) {
    game.removeVisual(barraEstres)
  }
  
  self.detenerEstresPorTiempo()
  
  const nivelACargar = nivelesDelJuego.get(numeroDeNivel)
  nivelActual = numeroDeNivel
  nivelACargar.configurar(self)
  
  // la sumo la barra AL FINAL para que quede encima
  game.addVisual(barraEstres)
}
  //no acumuilo
  method detenerEstresPorTiempo() {
		game.removeTickEvent("aumentarEstresPorTiempo")
	}

  method iniciarEstresPorTiempo(misionFallidaCallback) {
		self.detenerEstresPorTiempo() //no estoy pasando un objeto, estoy pasando una funcion :(
		
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
     cenicienta.position(cenicienta.position().up(10))  // era 5
     self.verificarColisionesCercanas()
     nivelesDelJuego.get(nivelActual).avanzarNivel(self)
           game.say(cenicienta, "Coord x:" + cenicienta.position().x() + " y:" + cenicienta.position().y())

   })
 
   keyboard.down().onPressDo({
     cenicienta.position(cenicienta.position().down(10))  // era 5
     self.verificarColisionesCercanas()
     nivelesDelJuego.get(nivelActual).avanzarNivel(self)
           game.say(cenicienta, "Coord x:" + cenicienta.position().x() + " y:" + cenicienta.position().y())

   })

   keyboard.left().onPressDo({
     cenicienta.position(cenicienta.position().left(10))  // era 5
     self.verificarColisionesCercanas()
     nivelesDelJuego.get(nivelActual).avanzarNivel(self)
           game.say(cenicienta, "Coord x:" + cenicienta.position().x() + " y:" + cenicienta.position().y())

   })

   keyboard.right().onPressDo({
     cenicienta.position(cenicienta.position().right(10))  // era 5
     self.verificarColisionesCercanas()
     nivelesDelJuego.get(nivelActual).avanzarNivel(self)
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

  method mostrarPantallaResultado(pantalla) {
    self.detenerEstresPorTiempo()
    
    elementosEnEscena.forEach({ elem => 
        if (game.hasVisual(elem)) {
            game.removeVisual(elem)
        }
    })
    elementosEnEscena.clear()
    
    cenicienta.limpiarObjetos()
    barraEstres.resetear()
    
    const imagePrincipal = object {
        var property position = pantalla.posicionPrincipal()
        var property image = pantalla.imagenPrincipal()
    }
    game.addVisual(imagePrincipal)
    
    if (pantalla.imagenSecundaria() != "") {
        const imageHermanas = object {
            var property position = pantalla.posicionSecundaria()
            var property image = pantalla.imagenSecundaria()
        }
        game.addVisual(imageHermanas)
    }
    
    game.say(cenicienta, pantalla.mensaje())
}

 

  method removerElemento(elemento) {
    elementosEnEscena.remove(elemento)
  }
}