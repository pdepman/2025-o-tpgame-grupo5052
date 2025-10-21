import wollok.game.*
import personajes.*

object barraEstres {
    var property position = game.at(-1, 70)
    const minNivel = 0
    const maxNivel = 5
    var sufijo = '0'
    var visualAgregado = false
    method image() = 'barraEstres' + sufijo + '.png'
    
    method iniciar() {
        sufijo = "0"
        if (!visualAgregado) {
            game.addVisual(self)
            visualAgregado = true
        }
        return self
    }

    method detener() {
        if (visualAgregado) {
            game.removeVisual(self)
            visualAgregado = false
        }
        return self
    }

    method aumentarNivel() {
        const nivelActual = sufijo.toNumber()
        if(nivelActual < maxNivel){
            sufijo = (nivelActual + 1).toString()
            self.actualizarVisual()    
        }
    }

    method disminuirNivel() {
            const nivelActual = sufijo.toNumber()
            if (nivelActual > minNivel) {
                sufijo = (nivelActual - 1).toString()
                self.actualizarVisual()
            }
    }

    method actualizarVisual() {
            if (visualAgregado) {
                game.removeVisual(self)
            }
            game.addVisual(self)
            visualAgregado = true
    }

    
}
