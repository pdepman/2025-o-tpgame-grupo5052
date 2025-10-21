import wollok.game.*
import personajes.*

object barraEstres {
    var property position = game.at(5, 160)
    const minNivel = 0
    const maxNivel = 5
    var property sufijo = 0
    var visualAgregado = false
    
    method image() = 'barraEstres' + sufijo.toString() + '.png'
    
    method iniciar() {
        if (!visualAgregado) {
          visualAgregado = true
          sufijo = 0
          game.addVisual(self)
        }
    }

    method detener() {
        if (visualAgregado) {
          visualAgregado = false
          game.removeVisual(self)
        }
    }

    method aumentarNivel() {
        if(sufijo < maxNivel){
            sufijo = sufijo + 1
        }
    }

    method disminuirNivel() {
        if (sufijo > minNivel) {
            sufijo = sufijo - 1
        }
    }
    
    method estaAlMaximo() = sufijo >= maxNivel
    
    method resetear() {
        sufijo = 0
    }
}