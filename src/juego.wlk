
import personajes.*
import objetos.*
import wollok.game.*

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
    /*
    class nivel {
        var numeroNivel = 0
    }*/
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
