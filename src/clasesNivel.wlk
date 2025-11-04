import wollok.game.*
import objetos.*
import barraEstres.*
import pantallas.*
import personajes.*
//clase abstact
class Nivel {
    var misionFallida = false    //sacar
    var misionCompletada = false //sacar
    method configurar(juego)
    method avanzarNivel(juego)

    method pantallaVictoria()
    method pantallaDerrota()

    method fondoNivel()
    method imagenListaMision()
    method configurarObjetos(juego)
    method cantidadObjetosMision()

    method necesitaBarraEstres() = false

    method ratonDeNivel(juego) = null // por defecto no va a haber ningun raton

    method registrarRatones(juego) {
        const raton = self.ratonDeNivel(juego)
        if(raton != null) {
            juego.agregarElemento(raton)
            game.addVisual(raton)
            game.onCollideDo(juego.cenicienta(), {
                otro => if(otro == raton) {
                    raton.interactuar(juego.cenicienta(), juego)
                }
             })
         }
    }
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

    //hago las PROPs para mis datos
    var property fondoNivel
    var property imagenListaMision
    var property cantidadObjetosMision
    
    //listas con los DATOS para el factory
    var property objetosDeMisionData = []
    var property objetosEstresantesData = []
    var property mueblesEnganiososData = []
    
    //data pantallas
    var property pantallaVictoriaData
    var property pantallaDerrotaData

    //data ratones
    var property ratoncitosNivel = null
    override method ratonDeNivel(juego) {
        if (ratoncitosNivel == null) {
            return null
        } else {
            return ratoncitosNivel.apply(juego)
        }
          
    }

    override method necesitaBarraEstres() = true
    
    //el fondoNivel() ahora method que DEVUELVE la prop y asi resto
    override method fondoNivel() = fondoNivel 
    override method imagenListaMision() = imagenListaMision
    override method cantidadObjetosMision() = cantidadObjetosMision

    //lee las dataLists y crea objetos
    override method configurarObjetos(juego) {
        
        objetosDeMisionData.forEach({ data =>
            const mueble = new MuebleConObjetosMision(
                position = data.position(),
                image = data.image(),
                muebleCerrada = data.muebleCerrada(),
                muebleAbierta = data.muebleAbierta(),
                nombreObjeto = data.nombreObjeto(),
                imagenObjetoRecolectable = data.imagenObjetoRecolectable(),
                posicionObjeto = data.posicionObjeto(),
                mensajeDescubrimiento = data.mensajeDescubrimiento()
            )
            juego.agregarElemento(mueble)
        })

        objetosEstresantesData.forEach({ data =>
            const objeto = new ObjetoEstresante(
                position = data.position(),
                image = data.image(),
                nombre = data.nombre(),
                valorEstres = data.valorEstres()
            )
            juego.agregarElemento(objeto)
        })

        mueblesEnganiososData.forEach({ data =>
            const mueble = new MuebleEnganioso(
                position = data.position(),
                image = data.image(),
                muebleEnganio = data.muebleEnganio(),
                mensajeEnganio = data.mensajeEnganio()
            )
            juego.agregarElemento(mueble)
        })
    }
    
    override method pantallaVictoria() {
        return new PantallaResultado(
            imagenPrincipal = pantallaVictoriaData.imagenPrincipal(),
            posicionPrincipal = pantallaVictoriaData.posicionPrincipal(),
            imagenSecundaria = pantallaVictoriaData.imagenSecundaria(),
            posicionSecundaria = pantallaVictoriaData.posicionSecundaria(),
            mensaje = pantallaVictoriaData.mensaje()
        )
    }
    
    override method pantallaDerrota() {
        return new PantallaResultado(
            imagenPrincipal = pantallaDerrotaData.imagenPrincipal(),
            posicionPrincipal = pantallaDerrotaData.posicionPrincipal(),
            imagenSecundaria = pantallaDerrotaData.imagenSecundaria(),
            posicionSecundaria = pantallaDerrotaData.posicionSecundaria(),
            mensaje = pantallaDerrotaData.mensaje()
        )
    }
    
    
    //esqueleto de la configuracion
 override method configurar(juego) {
 misionFallida = false
  misionCompletada = false
 juego.cenicienta().resetearEstres()
  
         // Usa la property a través del método de la superclase
 juego.cambiarFondo(self.fondoNivel()) 
  
  game.schedule(100, { barraEstres.iniciar() })
  if (!game.hasVisual(barraEstres)) {
   game.addVisual(barraEstres)
  }
  
  juego.iniciarEstresPorTiempo({
  if (!misionFallida && !misionCompletada) {
   misionFallida = true
          // Usa la property
  juego.mostrarPantallaResultado(self.pantallaDerrota()) 

   game.schedule(3500, {
   juego.irANivel(juego.nivelActual())
   })//reinicie el nivel
  }
  })
  
  const listaMision = new ListaMision (
  position = game.at(151,135),
      // Usa la property
   image = self.imagenListaMision() 
  )
  juego.agregarElemento(listaMision)
  
  // Llama al "factory" interno
  self.configurarObjetos(juego) 
  
  game.say(juego.cenicienta(), "¡Es hora de encontrar tus objetos!")
  juego.cenicienta().position(game.at(1, 1))

  self.registrarRatones(juego)
 }
 
 override method avanzarNivel(juego) {
const personaje = juego.cenicienta()
const cantidadObjetos = personaje.objetosRecolectados().size()
// Usa la property
if (cantidadObjetos == self.cantidadObjetosMision() && !misionCompletada) {
misionCompletada = true
juego.detenerEstresPorTiempo()

//llamo al nuevo metodo del juego
game.schedule(500, {
    // Usa la property
juego.mostrarPantallaResultado(self.pantallaVictoria())
})

//espera y avanza
game.schedule(3500, {
 juego.irANivel(juego.nivelActual() + 1)
})
}
 }
}

class NivelFinal inherits Nivel {
    override method configurar(juego) {
        juego.cambiarFondo("nivelFinalFondo.jpeg") 
        juego.cenicienta().image("cenicientaLinda.png") 
        juego.cenicienta().position(game.at(1, 1))
        game.say(juego.cenicienta(), "¡Lograste Ganar el juego, encontraste al principe!")
        
        game.schedule(5000, {
            self.mostrarPantallaFinalYReiniciar(juego)
        })
    }
    
    method mostrarPantallaFinalYReiniciar(juego) {
        if (game.hasVisual(juego.cenicienta())) {
            game.removeVisual(juego.cenicienta())
        }
        
        const pantallaFinal = object {
            var property position = game.at(0, 0)
            var property image = "fin.jpeg"  
        }
        game.addVisual(pantallaFinal)
        
        
        game.schedule(5000, {
            game.removeVisual(pantallaFinal)
            juego.irANivel(0)  
        })
    }

    override method avanzarNivel(juego) {
    }

    override method pantallaVictoria() = null
    override method pantallaDerrota() = null
    override method fondoNivel() = ""
    override method imagenListaMision() = ""
    override method configurarObjetos(juego) {}
    override method cantidadObjetosMision() = 0
}