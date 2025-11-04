import wollok.game.*
import personajes.*

class ElementoDeJuego {
    var property position
    var property image

    method esPuerta() = false
    method esRelojDeArena() = false
    method esInteractuable() = false

    method interactuar(personaje, juego) {
    }
}

class ObjetoInteractuable inherits ElementoDeJuego {
    override method esInteractuable() = true
}


class Puerta inherits ObjetoInteractuable {
    var property nivelDestino
    var yaActivada = false
    
    override method esPuerta() = true

    override method interactuar(personaje, juego) {
        if (!yaActivada) {
            yaActivada = true
            .println("¡Pasando al nivel " + nivelDestino + "!")
            game.say(personaje, "¡Entrando a la siguiente área!")
            
            game.schedule(500, { 
                juego.irANivel(nivelDestino)
            })
        }
    }
}

class MuebleConObjetosMision inherits ObjetoInteractuable {
    //unifico todo
    var yaAbierto= false
    var property muebleCerrada 
    var property muebleAbierta 
    var property nombreObjeto
    var property imagenObjetoRecolectable
    var property posicionObjeto
    var property mensajeDescubrimiento
method aplicarEfecto(personaje) {
      personaje.disminuirEstres(15)
    }
   override method interactuar(personaje, juego) {
        if (!yaAbierto) {
            yaAbierto = true
            self.aplicarEfecto(personaje)
            game.say(self, mensajeDescubrimiento)
            
            game.schedule(1000, { 
                self.image(muebleAbierta)
                
                const objetoRecolectable = new ObjetoDeTrampa(
                    position = posicionObjeto,
                    image = imagenObjetoRecolectable, 
                    nombre = nombreObjeto
                )
                
                juego.agregarElemento(objetoRecolectable)
                
                game.schedule(500, {
                    game.say(objetoRecolectable, "¡Agarrame!")
                })
            })
        }
    }

}

class MuebleEnganioso inherits ObjetoInteractuable {
    var property muebleEnganio
    var property mensajeEnganio

   override method interactuar(personaje, juego) {
            
            game.say(self, mensajeEnganio)  
        
    }

}
class ObjetoDeTrampa inherits ObjetoInteractuable {
    var property nombre
    var yaRecolectado = false

    method aplicarEfecto(personaje) {
        personaje.agarrar(self)
        personaje.disminuirEstres(10)
    }

    override method interactuar(personaje, juego) {
        if (!yaRecolectado) {
            yaRecolectado = true
            
            self.aplicarEfecto(personaje) 
            
            game.say(personaje, "¡Conseguiste: " + nombre + "!")
            
            game.removeVisual(self)
            juego.removerElemento(self)
            
            const cantidadObjetos = personaje.objetosRecolectados().size()
            
            game.schedule(1000, {
                game.say(personaje, "Objetos: " + cantidadObjetos + "/3")
            })
        }
    }
}
class ObjetoEstresante inherits ObjetoInteractuable {
    var property nombre = "objeto peligroso"
    var property valorEstres = 15
    var yaActivado = false
    method aplicarEfecto(personaje) {
        personaje.aumentarEstres(valorEstres)
    }
    override method interactuar(personaje, juego) {
        if (!yaActivado) {
            yaActivado = true
            
            self.aplicarEfecto(personaje)
            
            game.say(self, "¡Cuidado! ¡Esto te estresa!")
            
            /* game.schedule(1500, {
                if (game.hasVisual(self)) {
                    game.removeVisual(self)
                    juego.removerElemento(self)
                }
            }) este por si queremos hac q tipo desaparezca depsues d tocarlo*/
        }
    }
}


class ListaMision inherits ObjetoInteractuable {
    var yaAbierta = true
}