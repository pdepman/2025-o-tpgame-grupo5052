object escoba {
  var position = game.origin()
  method position(_nuevaPosition) { position = _nuevaPosition }
  method position() = position
  method image() = "escoba.png"
}

object gato {
  var position = game.at(game.width()-1, game.height()-1)
  method position(_nuevaPosition) { position = _nuevaPosition }
  method position() = position
  
  method image() = "gato-parado.png"
}

object cenicienta {
  var position = game.center()
  method position(_nuevaPosition) { position = _nuevaPosition }
  method position() = position

  method image() = "ceni.png"
}

object pepita {
  var energy = 100

  method energy() = energy

  method fly(minutes) {
    energy = energy - minutes * 3
  }
}