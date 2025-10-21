import wollok.game.*
import personajes.*

class ElementoDeJuego {
    var property position
    var property image

    method esPuerta() = false
    method esRelojDeArena() = false
    method esInteractuable() = false

    method interactuar(personaje, juego) {
    }
}

class ObjetoInteractuable inherits ElementoDeJuego {
    override method esInteractuable() = true
}

class Mueble inherits ObjetoInteractuable {
    var nombre = "mueble"
    var property imagenIntern
    var objetosOcultos = new List()

    override method interactuar(personaje, juego) {
        game.say(self, "Aquí dentro encontraste: " + objetosOcultos.join(", "))
        game.boardGround(imagenIntern)
    }

    method agregarObjeto(objeto) {
        objetosOcultos.add(objeto)
    }
}

class ObjetoDeTrampa inherits ObjetoInteractuable {
    var property nombre
    var yaRecolectado = false

    override method interactuar(personaje, juego) {
       
       if(!yaRecolectado){

         console.println("Recolectando objeto: " + nombre)
            yaRecolectado = true
            
            // Agregar al inventario
            personaje.agarrar(self)
            personaje.disminuirEstres(5)
            
            game.say(personaje, "¡Conseguiste: " + nombre + "!")
            
            game.removeVisual(self)
            
            juego.removerElemento(self)
            
            const cantidadObjetos = personaje.objetosRecolectados().size()
            
            game.schedule(1000, {
                game.say(personaje, "Objetos: " + cantidadObjetos + "/3")
            })
       }
    }
}

class RelojDeArena inherits ObjetoInteractuable {
    override method interactuar(personaje, juego) {
    }
}

class Puerta inherits ObjetoInteractuable {
    var property nivelDestino
    var yaActivada = false
    
    override method esPuerta() = true

    override method interactuar(personaje, juego) {
        if (!yaActivada) {
            yaActivada = true
            console.println("¡Pasando al nivel " + nivelDestino + "!")
            game.say(personaje, "¡Entrando a la siguiente área!")
            
            game.schedule(500, { 
                juego.irANivel(nivelDestino)
            })
        }
    }
}

class Prenda inherits ElementoDeJuego {}
class ZapatoDeCristal inherits Prenda {}

class Heladera inherits ObjetoInteractuable {
    var yaAbierta = false
    
    override method interactuar(personaje, juego) {
        if (!yaAbierta) {
            yaAbierta = true
            game.say(self, "Abriste la heladera... ¡Encontraste los huevos!")
            
            game.schedule(1000, { 
                self.image("Huevos.png")
                
                const huevo = new ObjetoDeTrampa(
                    position = game.at(165, 47),  
                    image = "huevosAgarrar.png",  
                    nombre = "Huevo"
                )
                
                juego.agregarElemento(huevo)
                
                game.schedule(500, {
                    game.say(huevo, "¡Recógeme!")
                })
            })
        }
    }
}

class MesaAceite inherits ObjetoInteractuable {
    var yaAbierta = false
    
    override method interactuar(personaje, juego) {
        if (!yaAbierta) {
            yaAbierta = true
            game.say(self, "¡Encontraste el aceite!")
            
            game.schedule(1000, { 
                self.image("aceite.png")
                
                const aceite = new ObjetoDeTrampa(
                    position = game.at(76, 46),
                    image = "aceiteAgarrar.png", 
                    nombre = "Aceite"
                )
                
                juego.agregarElemento(aceite)
                
                game.schedule(500, {
                    game.say(aceite, "¡Recógeme!")
                })
            })
        }
    }
}

class EstanteriaHarina inherits ObjetoInteractuable {
    var yaAbierta = false
    
    override method interactuar(personaje, juego) {
        if (!yaAbierta) {
            yaAbierta = true
            game.say(self, "¡Encontraste la harina!")
            
            game.schedule(1000, { 
                self.image("estanteriaHarina.png")
                
                const harina = new ObjetoDeTrampa(
                    position = game.at(26, 41),
                    image = "harinaAgarrar.png", 
                    nombre = "Harina"
                )
                
                juego.agregarElemento(harina)
                
                game.schedule(500, {
                    game.say(harina, "¡Recógeme!")
                })
            })
        }
    }
}

class ListaMision inherits ObjetoInteractuable {
    var yaAbierta = true
}