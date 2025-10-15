import wollok.game.*
import personajes.*
import objetos.*

// objeto 'juego' es el director de orquesta
object juego {
    var cenicienta
    var elementosEnEscena = new List()
    var tiempo = 45 

    // metodo principal que se llama al iniciar
    method iniciar() {
        game.title("Wollok de Cristal")
        game.height(800)
        game.width(1000)

        self.configurarNivel1() // 1°nivel

        // configuramos los controles del teclado
        keyboard.space().onPressDo({ self.interactuarConLoCercano() })
        
        // configuramos un timer para que el tiempo baje
        game.onTick(1000, "bajarTiempo", { self.actualizarJuego() })
        
        game.start()
    }

    method configurarNivel1() {
        game.backgroundImage("kitchen_background.png") // La imagen de la cocina
        
        // creamos a Cenicienta
        cenicienta = new Cenicienta(position=game.center(), image="cenicienta.png")
        game.addVisual(cenicienta)
        
        // creamos los ratones
        const raton1 = new Raton(position=game.at(1,1), image="raton.png", pista="Psst... ¡revisa cerca del fuego!")
        game.addVisual(raton1)
        
        // aca vamos creando y agregando todos los demas onda muebles, ObjetosDeTrampa, etc.
    }
    
    method actualizarJuego() {
        tiempo = tiempo - 1
        // ACA va la logica para verificar si ganó o perdió
        if (cenicienta.estres() >= 100) {
            game.say(cenicienta, "¡No puedo más! ¡Perdí!")
            game.stop()
        }
        if (tiempo <= 0) {
            // Lógica para ver si completó la trampa
            // Si no, pierde.
        }
    }
    
    method aumentarTiempo(segundos) {
        tiempo = tiempo + segundos
    }

    method interactuarConLoCercano() {
        // aca iria para encontrar el objeto 'Interactuable' más cercano a Cenicienta
        // y llamar a su método interactuar().
        // const objetoCercano = ...
        // objetoCercano.interactuar(cenicienta)
    }
}