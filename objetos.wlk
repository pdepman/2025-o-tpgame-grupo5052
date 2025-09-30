

object escoba {
  var position = game.origin()
  method position(_nuevaPosition) { position = _nuevaPosition }
  method position() = position
  method image() = "escoba.png"
}