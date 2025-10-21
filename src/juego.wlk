import wollok.game.*
import personajes.*
import objetos.*
import reloj.*

// objeto 'juego' es el director de orquesta
object juego {
    var cenicienta
    var elementosEnEscena = new List()
    var tiempo = 45 
    var nivelActual = 0

    method nivelActual() = nivelActual
    method nivelActual(_nuevoNivel) {
        nivelActual = _nuevoNivel
    }
    // metodo principal que se llama al iniciar
    method iniciar() {
        game.title("Wollok de Cristal")
        game.height(800)
        game.width(1000)
        game.cellSize(50)

        self.configurarNivel1() // 1°nivel
        //NIVIEL INICIAL OSEA ENTRADA DEL CASTILLO
        self.irANivel(0)
        // configuramos los controles del teclado
        keyboard.space().onPressDo({ self.interactuarConLoCercano() })
        
        // configuramos un timer para que el tiempo baje
        game.onTick(1000, "bajarTiempo", { self.actualizarJuego() })
        
        game.start()
    } 

    //ACA vamos a hacer los diferentes niveles 
    method irANivel(numeroDeNivel){
        elementosEnEscena = newList() // mi listra de elementos q se reinicia en cada uno 

        game.addVisual(cenicienta)
        
        //deberia ser algo nivel.configurar(numeroDeNivel) 
        
        if(numeroDeNivel == 0){
            self.configurarEntrada()
        },
        if(numeroDeNivel == 1){
            self.configurarCocina()
        },
        if (numeroDeNivel == 2){
            self.configurarBanio()
        },
        if (numeroDeNivel == 3){
            self.configurarBiblioteca()
        },
        if (numeroDeNivel == 4){
            self.configurarJardin()
        },
        if (numeroDeNivel == 5){ 
            self.configurarFinal()
        }
    }
    //deberiamos tener 5 instacias de nivel

    method configurarEntrada(){
        game.boardGround("entradaCastillo.png")
        cenicienta.position = game.at(10, 70)

        // ahora voy a hacwer la puerta que conecte con el nivel 1 osea cocina
        /*const puertaCocina = new Puerta(
            position = game.at(40,70),
            image = "aceite.png",
            nivelDestino = 1,
        )*/
        game.addVisual(puertaCocina)
        elementosEnEscena.add(puertaCocina) //pongo a la puerta como elemento interactrivo

        game.removeTickEvent("bajarTiempo") //xq yo en mi entrada no voy a tener tiempo
    }
    
    
    method actualizarJuego() {
        tiempo = tiempo - 1
        // ACA va la logica para verificar si ganó o perdió
        if (cenicienta.estres() >= 100) { // cenicienta.estaEstresada()
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



// ---------------------------- NIVELEs, despues se mueven a los arhcivos de los objetos  
class Nivel {
    //codigo de nivel

    method alEntrar(_personaje) {
    game.addVisual(ratones)
    game.onCollideDo(_personaje, ratones) {
      ratones.interactuar(_personaje)
    }
    }

    method pistaParaRatones() = ""
    method reduccionEstres() = 0
}

    // ENTRADA aca no pasa nada
    object entrada inherits Nivel { }

    // COCINA (pista, sin bajar estrés)
    object cocina inherits Nivel {
        //codigo de la cocina

    method iniciar(_personaje) {
    self.alEntrar(_personaje)    // addVisual + onCollideDo
    // otras cosas
    }

    override method pistaParaRatones() =
        "Hola Ceni, para hacer las trampas:\n" +
        " - los huevos están en la heladera\n" +
        " - el aceite está en la mesa"

    override method reduccionEstres() = 0
    }

    // BAÑO 
    object banio inherits Nivel {
        //codigo del banio

    override method pistaParaRatones() =
        "El jabon en la jabonera, el jabon liquido en el lavamanos, el agua en la bañera."
    override method reduccionEstres() = 10
    }

    // DORMITORIO 
    object dormitorio inherits Nivel {
            // codigo del dormitorio

    override method pistaParaRatones() =
        "Las sabanas en la cama, la ropa en el ropero."
    override method reduccionEstres() = 20
    }

    // JARDÍN 
    object jardin inherits Nivel {
        //codigo del jardin

    override method pistaParaRatones() =
        "En el mueble la palita para ablandar la tierra y hoja de las masetas."
    override method reduccionEstres() = 30
    }