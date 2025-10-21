import wollok.game.*
import objetos.*
import barraEstres.*

class Nivel {
    method configurar(juego)
    method avanzarNivel(juego)
}

class NivelEntrada inherits Nivel {
    override method configurar(juego) {
        console.println("Configurando Nivel: Entrada del Castillo")
        
        game.boardGround("entradaCastillo.png")
        juego.cenicienta().position(game.at(1, 1))
        
        game.say(juego.cenicienta(), "¡Bienvenida a la entrada del castillo!")
    }

    override method avanzarNivel(juego) {
        if (juego.cenicienta().position().x() >= 75 && 
            juego.cenicienta().position().x() <= 85 &&
            juego.cenicienta().position().y() >= 50 && 
            juego.cenicienta().position().y() <= 60) {
            juego.irANivel(1)
        }
    }
}

class NivelCocina inherits Nivel {
    var misionFallida = false
    
    override method configurar(juego) {
        console.println("Configurando Nivel: Cocina")
        misionFallida = false
        
        barraEstres.iniciar()

        // Timer de estrés
        game.onTick(10000, "subirEstres", {
            barraEstres.aumentarNivel()
            
            // ¡NUEVO! Verificar si llegó al máximo
            if (barraEstres.estaAlMaximo()) {
                game.removeTickEvent("subirEstres")
                
                if (!misionFallida) {
                    misionFallida = true
                    juego.fallarMisionCocina()
                }
            }
        })

        game.boardGround("cocinaVistaR3.png")
        juego.cenicienta().position(game.at(1, 1))

        const listaMision = new ListaMision (
            position = game.at(156,146),
            image= "misionCocina.png"
        )
        juego.agregarElemento(listaMision)

        const heladera = new Heladera(
            position = game.at(156, 51), 
            image = "heladeraSola.png"
        )
        juego.agregarElemento(heladera)

        const mesaAceite = new MesaAceite(
            position = game.at(76, 46), 
            image = "aceiteSolo.png"
        )
        juego.agregarElemento(mesaAceite)

        const estanteriaHarina = new EstanteriaHarina(
            position = game.at(3, 56), 
            image = "estanteriaSola.png"
        )
        juego.agregarElemento(estanteriaHarina)

        game.say(juego.cenicienta(), "¡Es hora de encontrar tus objetos!")
    }

    override method avanzarNivel(juego) {
        console.println("Avanzando al siguiente nivel desde la Cocina")

        const personaje = juego.cenicienta()
        const cantidadObjetos = personaje.objetosRecolectados().size()
        console.println("Objetos recolectados: " + cantidadObjetos + "/3")

        if (cantidadObjetos == 3 && !misionFallida) {
            // Detener el timer de estrés al completar
            game.removeTickEvent("subirEstres")
            
            game.schedule(2000, {
                juego.completarMisionCocina()
            })
        }
    }
}

class NivelDormitorio inherits Nivel {
    var misionFallida = false
    
    override method configurar(juego) {
        console.println("Configurando Nivel: Dormitorio")
        misionFallida = false
        
        barraEstres.iniciar()
        
        // Timer de estrés para dormitorio
        game.onTick(10000, "subirEstresDormitorio", {
            barraEstres.aumentarNivel()
            
            if (barraEstres.estaAlMaximo()) {
                game.removeTickEvent("subirEstresDormitorio")
                
                if (!misionFallida) {
                    misionFallida = true
                    juego.fallarMisionDormitorio()
                }
            }
        })

        game.boardGround("dormitorioVistaR3.png")
        juego.cenicienta().position(game.at(1, 1))

        game.say(juego.cenicienta(), "¡Es hora de encontrar tus objetos!")
    }

    override method avanzarNivel(juego) {
        console.println("Avanzando al siguiente nivel desde el Dormitorio")

        const personaje = juego.cenicienta()
        const cantidadObjetos = personaje.objetosRecolectados().size()
        console.println("Objetos recolectados: " + cantidadObjetos + "/3")

        if (cantidadObjetos == 3 && !misionFallida) {
            game.removeTickEvent("subirEstresDormitorio")
            
            game.schedule(2000, {
                juego.completarMisionDormitorio()
            })
        }
    }
}