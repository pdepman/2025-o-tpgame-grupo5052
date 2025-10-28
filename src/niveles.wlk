import wollok.game.*
import objetos.*
import barraEstres.*
import pantallas.*
//clase abstact
class Nivel {
    var misionFallida = false    
    var misionCompletada = false
    method configurar(juego)
    method avanzarNivel(juego)

    method pantallaVictoria()
    method pantallaDerrota()

    method fondoNivel()
    method imagenListaMision()
    method configurarObjetos(juego)
    method cantidadObjetosMision()
}

class NivelEntrada inherits Nivel {
    override method configurar(juego) {
        juego.cambiarFondo("nivelEntradaFondo.jpeg") 
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

    override method pantallaVictoria() = null
    override method pantallaDerrota() = null
    override method fondoNivel() = ""
    override method imagenListaMision() = ""
    override method configurarObjetos(juego) {}
    override method cantidadObjetosMision() = 0

}
class NivelConMision inherits Nivel {
    //esqueleto de la configuracion
    override method configurar(juego) {
        //reseteo estado
        misionFallida = false
        misionCompletada = false
        juego.cenicienta().resetearEstres()
        
        juego.cambiarFondo(self.fondoNivel()) 
        
        game.schedule(100, { barraEstres.iniciar() })
        if (!game.hasVisual(barraEstres)) {
            game.addVisual(barraEstres)
        }
        
        juego.iniciarEstresPorTiempo({
            if (!misionFallida && !misionCompletada) {
                misionFallida = true
                juego.mostrarPantallaResultado(self.pantallaDerrota())
            }
        })
        
        const listaMision = new ListaMision (
            position = game.at(156,146),
            image = self.imagenListaMision() 
        )
        juego.agregarElemento(listaMision)
        
        self.configurarObjetos(juego) 
        
        game.say(juego.cenicienta(), "¡Es hora de encontrar tus objetos!")
        juego.cenicienta().position(game.at(1, 1))
    }
    
    override method avanzarNivel(juego) {
        const personaje = juego.cenicienta()
        const cantidadObjetos = personaje.objetosRecolectados().size()

        // cuntos objetos son
        if (cantidadObjetos == self.cantidadObjetosMision() && !misionCompletada) {
            misionCompletada = true
            juego.detenerEstresPorTiempo()
            
            //llamo al nuevo metodo del juego
            game.schedule(500, {
                juego.mostrarPantallaResultado(self.pantallaVictoria())
            })
            
            //espera y avanza
            game.schedule(3500, {
                juego.irANivel(juego.nivelActual() + 1)
            })
        }
    }
}
class NivelCocina inherits NivelConMision {
    override method fondoNivel() = "nivelCocinaFondo.jpeg"
    override method imagenListaMision() = "misionCocina.png"
    override method cantidadObjetosMision() = 3
    
    override method configurarObjetos(juego) {
       
        const heladera = new MuebleConObjetosMision(
            position = game.at(156, 51), 
            image = "heladeraSola.png",
            muebleCerrada = "heladeraSola.png",
            muebleAbierta = "Huevos.png",
            nombreObjeto = "Huevo",
            imagenObjetoRecolectable = "huevosAgarrar.png",
            posicionObjeto = game.at(148, 31),
            mensajeDescubrimiento = "Abriste la heladera... ¡Encontraste los huevos!"
        )
        juego.agregarElemento(heladera)

        const mesaAceite = new MuebleConObjetosMision(
            position = game.at(71, 51), 
            image = "aceiteSolo.png",
            muebleCerrada = "aceiteSolo.png",
            muebleAbierta = "nivelCocinaMuebleAbierta_Aceite.png",
            nombreObjeto = "Aceite",
            imagenObjetoRecolectable = "nivelCocinaObjetoRecolectable_Aceite.jpeg",
            posicionObjeto = game.at(76, 46),
            mensajeDescubrimiento = "¡Encontraste el aceite!"
        )
        juego.agregarElemento(mesaAceite)

        const estanteriaHarina = new MuebleConObjetosMision(
            position = game.at(3, 53), 
            image = "estanteriaSola.png",
            muebleCerrada = "estanteriaSola.png",
            muebleAbierta = "estanteriaHarina.png",
            nombreObjeto = "Harina",
            imagenObjetoRecolectable = "harinaAgarrar.png",
            posicionObjeto = game.at(26, 41),
            mensajeDescubrimiento = "¡Encontraste la harina!"
        )
        juego.agregarElemento(estanteriaHarina)

        game.say(juego.cenicienta(), "¡Es hora de encontrar tus objetos!")

        const escoba = new ObjetoEstresante(
            position = game.at(111, 21),
            image = "nivelCocinaObjetoEstresante_Escoba.png",
            nombre = "Escoba sucia",
            valorEstres = 10
        )
        juego.agregarElemento(escoba)

        juego.cenicienta().position(game.at(1, 1))
    }

   override method pantallaVictoria() {
        return new PantallaResultado(
            imagenPrincipal = "imagenVictoria.png",
            posicionPrincipal = game.at(78, 86),
            imagenSecundaria = "nivelCocinaHermanasCumplido.png",
            posicionSecundaria = game.at(0, 0),
            mensaje = "¡Lograste vencer a las hermanastras!"
        )
    }
    
    override method pantallaDerrota() {
        return new PantallaResultado(
            imagenPrincipal = "derrota.png",
            posicionPrincipal = game.at(50, 90),
            imagenSecundaria = "hermanas.png",
            posicionSecundaria = game.at(0, 0),
            mensaje = "¡El estrés te venció! No pudiste completar la misión a tiempo..."
        )
    }
}

class NivelDormitorio inherits NivelConMision {
   
    override method fondoNivel() = "nivelDormitorioFondo.jpeg"
    override method imagenListaMision() = "misionCocina.png" //cambiaaa 
    override method cantidadObjetosMision() = 2

    override method configurarObjetos(juego) {
        
        const cama = new MuebleConObjetosMision(
            position = game.at(76, 81), 
            image = "nivelDormitorioMuebleCerrado_Cama.png",
            muebleCerrada = "nivelDormitorioMuebleCerrado_Cama.png",
            muebleAbierta = "nivelDormitorioMuebleAbierto_Cama.png",
            nombreObjeto = "frazada",
            imagenObjetoRecolectable = "nivelDormitorioObjetoDesestresante_frazada.png",
            posicionObjeto = game.at(76, 60),
            mensajeDescubrimiento = "¡Encontraste la frazada!"
        )
        juego.agregarElemento(cama)

        const placard = new MuebleConObjetosMision(
            position = game.at(161, 56), 
            image = "nivelDormitorioMuebleCerrado_Placard.png",
            muebleCerrada = "nivelDormitorioMuebleCerrado_Placard.png",
            muebleAbierta = "nivelDormitorioMuebleAbierto_Placard.png",
            nombreObjeto = "costurero",
            imagenObjetoRecolectable = "nivelDormitorioObjetoDesestresante_costurero.png",
            posicionObjeto = game.at(136, 41),
            mensajeDescubrimiento = "¡Encontraste el Costurero!"
        )
        juego.agregarElemento(placard)

        game.say(juego.cenicienta(), "¡Es hora de encontrar tus objetos!")

        const ropa = new ObjetoEstresante(
            position = game.at(111, 21),
            image = "nivelDormitorioObjetoEstresante_Ropa.png",
            nombre = "Ropa sucia",
            valorEstres = 10
        )
        juego.agregarElemento(ropa)

        const collares = new ObjetoEstresante(
            position = game.at(66, 51),
            image = "nivelDormitorioObjetoEstresante_Collar.png",
            nombre = "Collares desordenados",
            valorEstres = 10
        )
        juego.agregarElemento(collares)

       const espejo = new MuebleEnganioso (
            position = game.at(126, 71), 
            image = "nivelDormitorioMuebleXDdd.png",
            muebleEnganio = "nivelDormitorioMuebleXDdd.png", 
            mensajeEnganio = "Aca no hay nada..."
       )
       juego.agregarElemento(espejo)
       
       
        const sillonAcostado = new MuebleEnganioso (
            position = game.at(36, 26), 
            image = "nivelDormitorioMuebleXD.png",
            muebleEnganio = "nivelDormitorioMuebleXD.png", 
            mensajeEnganio = "Aca no hay nada..."
       )
              juego.agregarElemento(sillonAcostado)

       
       

        juego.cenicienta().position(game.at(1, 1))
    }
    override method pantallaVictoria() {
        return new PantallaResultado(
            imagenPrincipal = "imagenVictoria.png",
            posicionPrincipal = game.at(78, 86),
            imagenSecundaria = "nivelDormitorioHermanasCompletado.png",
            posicionSecundaria = game.at(0, 0),
            mensaje = "¡Lograste vencer a las hermanastras!"
        )
    }
    
    override method pantallaDerrota() {
        return new PantallaResultado(
            imagenPrincipal = "derrota.png",
            posicionPrincipal = game.at(50, 90),
            imagenSecundaria = "hermanas.png",
            posicionSecundaria = game.at(0, 0),
            mensaje = "¡El estrés te venció! No pudiste completar la misión a tiempo..."
        )
    }

}


class NivelBanio inherits NivelConMision {
    override method fondoNivel() = "nivelBanioFondo.jpeg"
    override method imagenListaMision() = "misionCocina.png" //cambiaaa 
    override method cantidadObjetosMision() = 2

    override method configurarObjetos(juego) {
        
        const ducha = new MuebleConObjetosMision(
            position = game.at(76, 81), 
            image = "nivelBanioMuebleCerrado_Ducha.png",
            muebleCerrada = "nivelBanioMuebleCerrado_Ducha.png",
            muebleAbierta = "nivelBanioMuebleCerrado_Abierto.png",
            nombreObjeto = "ducha",
            imagenObjetoRecolectable = "nivelBanioJabon.png",
            posicionObjeto = game.at(76, 60),
            mensajeDescubrimiento = "¡Encontraste el jabon!"
        )
        juego.agregarElemento(ducha)

        const espejoBanio = new MuebleConObjetosMision(
            position = game.at(161, 56), 
            image = "nivelBanioMuebleCerrado.png",
            muebleCerrada = "nivelBanioMuebleCerrado.png",
            muebleAbierta = "nivelBanioMuebleAbierto.png",
            nombreObjeto = "espejoBanio",
            imagenObjetoRecolectable = "nivelBanioPerfume.png",
            posicionObjeto = game.at(136, 41),
            mensajeDescubrimiento = "¡Encontraste el perfume!"
        )
        juego.agregarElemento(espejoBanio)

        game.say(juego.cenicienta(), "¡Es hora de encontrar tus objetos!")

        const toallas = new ObjetoEstresante(
            position = game.at(111, 21),
            image = "nivelBanioTrampa2.png",
            nombre = "toalla",
            valorEstres = 40
        )
        juego.agregarElemento(toallas)

        const charco = new ObjetoEstresante(
            position = game.at(66, 51),
            image = "nivelBanioTrampa.png",
            nombre = "charco",
            valorEstres = 600
        )
        juego.agregarElemento(charco)

       
       

        juego.cenicienta().position(game.at(1, 1))
    }
    
    override method avanzarNivel(juego) {
        const personaje = juego.cenicienta()
        const cantidadObjetos = personaje.objetosRecolectados().size()

        if (cantidadObjetos == self.cantidadObjetosMision() && !misionCompletada) {
            misionCompletada = true
            juego.detenerEstresPorTiempo()
            game.schedule(500, {
                juego.mostrarPantallaResultado(self.pantallaVictoria())
            })
            //No avanza de nivel
        }
    }

    override method pantallaVictoria() {
        return new PantallaResultado(
            imagenPrincipal = "imagenVictoria.png",
            posicionPrincipal = game.at(78, 86),
            imagenSecundaria = "nivelBanioHermanasCumplido.png", 
            posicionSecundaria = game.at(0, 0),
            mensaje = "¡Lograste vencer a las hermanastras!"
        )
    }
    
    override method pantallaDerrota() {
        return new PantallaResultado(
            imagenPrincipal = "derrota.png",
            posicionPrincipal = game.at(50, 90),
            imagenSecundaria = "hermanas.png",
            posicionSecundaria = game.at(0, 0),
            mensaje = "¡El estrés te venció! No pudiste completar la misión a tiempo..."
        )
    }

    
}