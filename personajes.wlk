import wollok.game.*
import animales.*

class Personaje {
  var position
  const animal
  var img 

  method position(_nuevaPosition) { position = _nuevaPosition }
  method position() = position
  method img(_nuevaImg) { img = _nuevaImg }
  method image() = img
}

const cenicienta = new Personaje(
    position = game.center(), 
    animal = ratones, 
    img = "ceni.png"
    )

const hermanas  = new Personaje(
    position = game.origin(), 
    animal = gato,
    img = ""
    )
