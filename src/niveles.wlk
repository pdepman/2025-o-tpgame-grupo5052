import wollok.game.*
import objetos.*
import barraEstres.*

class Nivel {
    method configurar(juego)
    method avanzarNivel(juego)
    method imagenVictoria()
    method posicionImagenVictoria()
    method imagenHermanasVictoria()
    method posicionImagenHermanasVictoria()
    method mensajeVictoria()
    method imagenDerrota()
    method posicionImagenDerrota()
    method imagenHermanasDerrota()
    method posicionImagenHermanasDerrota()
    method mensajeDerrota()
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

    override method imagenVictoria() = ""
    override method posicionImagenVictoria() = game.at(0, 0)
    override method imagenHermanasVictoria() = ""
    override method posicionImagenHermanasVictoria() = game.at(0, 0)
    override method mensajeVictoria() = ""
    override method imagenDerrota() = ""
    override method posicionImagenDerrota() = game.at(0, 0)
    override method imagenHermanasDerrota() = ""
    override method posicionImagenHermanasDerrota() = game.at(0, 0)
    override method mensajeDerrota() = ""
}

class NivelCocina inherits Nivel {
    var misionFallida = false
    var misionCompletada = false
    
    override method configurar(juego) {
        misionFallida = false
        misionCompletada = false
        
        juego.cambiarFondo("nivelCocinaFondo.jpeg")
        
        // Esperar un poquito para que el fondo se cargue primero
        game.schedule(100, {
            barraEstres.iniciar()
        })

       juego.iniciarEstresPorTiempo({
			if (!misionFallida && !misionCompletada) {
				misionFallida = true
				juego.fallarMision(
					self.imagenDerrota(),
					self.posicionImagenDerrota(),
					self.imagenHermanasDerrota(),
					self.posicionImagenHermanasDerrota(),
					self.mensajeDerrota()
				)
			}
		})

        const listaMision = new ListaMision (
            position = game.at(156,146),
            image = "misionCocina.png"
        )
        juego.agregarElemento(listaMision)

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

    override method avanzarNivel(juego) {
        const personaje = juego.cenicienta()
        const cantidadObjetos = personaje.objetosRecolectados().size()

        if (cantidadObjetos == 3 && !misionCompletada) {
            misionCompletada = true
            
            // Detener el estrés
            juego.detenerEstresPorTiempo()
            
            // Mostrar pantalla de victoria
            game.schedule(500, {
                juego.completarMision(
                    self.imagenVictoria(),
                    self.posicionImagenVictoria(),
                    self.imagenHermanasVictoria(),
                    self.posicionImagenHermanasVictoria(),
                    self.mensajeVictoria()
                )
            })
            
            // Esperar 3 segundos y avanzar al siguiente nivel
            game.schedule(3500, {
                juego.irANivel(juego.nivelActual() + 1)
            })
        }
    }

    override method imagenVictoria() = "imagenVictoria.png"
    override method posicionImagenVictoria() = game.at(78, 86)
    override method imagenHermanasVictoria() = "nivelCocinaHermanasCumplido.png"
    override method posicionImagenHermanasVictoria() = game.at(0, 0)
    override method mensajeVictoria() = "¡Lograste vencer a las hermanastras!"
    
    override method imagenDerrota() = "derrota.png"
    override method posicionImagenDerrota() = game.at(50, 90)
    override method imagenHermanasDerrota() = "hermanas.png"
    override method posicionImagenHermanasDerrota() = game.at(0, 0)
    override method mensajeDerrota() = "¡El estrés te venció! No pudiste completar la misión a tiempo..."
}

class NivelDormitorio inherits Nivel {
    var misionFallida = false
    var misionCompletada = false
    
    override method configurar(juego) {
        misionFallida = false
        misionCompletada = false
        
        juego.cambiarFondo("nivelDormitorioFondo.jpeg")

        game.schedule(100, {
            barraEstres.iniciar()
        })

        juego.cenicienta().resetearEstres()
        barraEstres.iniciar()

       juego.iniciarEstresPorTiempo({
			if (!misionFallida && !misionCompletada) {
				misionFallida = true
				juego.fallarMision(
					self.imagenDerrota(),
					self.posicionImagenDerrota(),
					self.imagenHermanasDerrota(),
					self.posicionImagenHermanasDerrota(),
					self.mensajeDerrota()
				)
			}
		})

        const listaMision = new ListaMision (
            position = game.at(156,146),
            image = "misionCocina.png"
        )
        juego.agregarElemento(listaMision)

        const cama = new MuebleConObjetosMision(
            position = game.at(81, 86), 
            image = "nivelDormitorioMuebleCerrado_Cama.png",
            muebleCerrada = "nivelDormitorioMuebleCerrado_Cama.png",
            muebleAbierta = "nivelDormitorioMuebleAbierto_Cama.png",
            nombreObjeto = "frazada",
            imagenObjetoRecolectable = "nivelDormitorioObjetoDesestresante_frazada.png",
            posicionObjeto = game.at(148, 31),
            mensajeDescubrimiento = "¡Encontraste la frazada!"
        )
        juego.agregarElemento(cama)

        const placard = new MuebleConObjetosMision(
            position = game.at(156, 51), 
            image = "nivelDormitorioMuebleCerrado_Placard.png",
            muebleCerrada = "nivelDormitorioMuebleCerrado_Placard.png",
            muebleAbierta = "nivelDormitorioMuebleAbiertp_Placard.png",
            nombreObjeto = "costurero",
            imagenObjetoRecolectable = "nivelDormitorioObjetoDesestresante_costurero.png",
            posicionObjeto = game.at(76, 46),
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
            position = game.at(50, 50),
            image = "nivelDormitorioObjetoEstresante_Collar.png",
            nombre = "Collares desordenados",
            valorEstres = 10
        )
        juego.agregarElemento(collares)

        juego.cenicienta().position(game.at(1, 1))
    }

    override method avanzarNivel(juego) {
        const personaje = juego.cenicienta()
        const cantidadObjetos = personaje.objetosRecolectados().size()

        if (cantidadObjetos == 2 && !misionCompletada) {
            misionCompletada = true
            
            // Para el último nivel, sí mostrar la pantalla de victoria completa
            juego.completarMision(
                self.imagenVictoria(),
                self.posicionImagenVictoria(),
                self.imagenHermanasVictoria(),
                self.posicionImagenHermanasVictoria(),
                self.mensajeVictoria()
            )
            
            // Si hubiera más niveles, descomentar esto:
            // game.schedule(3000, {
            //     juego.irANivel(juego.nivelActual() + 1)
            // })
        }
    }

    override method imagenVictoria() = "imagenVictoria.png"
    override method posicionImagenVictoria() = game.at(78, 86)
    override method imagenHermanasVictoria() = "nivelDormitorioHermanasCompletado.png"
    override method posicionImagenHermanasVictoria() = game.at(0, 0)
    override method mensajeVictoria() = "¡Lograste vencer a las hermanastras!"
    
    override method imagenDerrota() = "derrota.png"
    override method posicionImagenDerrota() = game.at(50, 90)
    override method imagenHermanasDerrota() = "hermanas.png"
    override method posicionImagenHermanasDerrota() = game.at(0, 0)
    override method mensajeDerrota() = "¡El estrés te venció! No pudiste completar la misión a tiempo..."
}