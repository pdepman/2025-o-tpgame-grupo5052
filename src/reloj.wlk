import wollok.game.*

object reloj {
  var property position = game.at(2, 1)
  var segundos = 0
  var activo = false
  var tickAction = null   // callback opcional (ej: juego.actualizarCocina)

  method formato(_s) {
    const m = _s / 60
    const s = _s % 60
    // construyo el string correctamente (sin operador ternario)
    var textoMin = ""
    var textoSeg = ""
    if (m < 10) { textoMin = "0" + m } else { textoMin = "" + m }
    if (s < 10) { textoSeg = "0" + s } else { textoSeg = "" + s }
    return textoMin + ":" + textoSeg
  }

  method onTickDo(_accion) {
    tickAction = _accion
  }

  method iniciar() {
    if (!activo) {
      activo = true
      segundos = 0
      game.addVisual(self)
      game.onTick(1000, "tickReloj", { self.actualizar() })
    }
  }

  method detener() {
    activo = false
    game.removeTickEvent("tickReloj")
    game.removeVisual(self)
  }

  method actualizar() {
    if (activo) {
      segundos += 1
      // redibujo el texto
      game.removeVisual(self)
      game.addVisual(self)
      if (tickAction != null) {
        tickAction.apply()
      }
    }
  }

  method llegoA(seg) {
    return segundos >= seg
  }
}
