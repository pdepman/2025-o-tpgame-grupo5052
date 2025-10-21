
import wollok.game.*
// la interfaz es un "contrato". cualquier clase que la implemente
// ESTA OBLIGADA a tener un metodo llamado "interactuar".
// esto es la base de nuestro polimorfismo.



// la clase mas general de todas. no se pueden crear instancias de ella (es abstracta).
// define lo que CUALQUIER objeto en el juego tiene: una posición y una imagen.
// ES ABSTACTA POR MAS DE QUEN NOS DEJEN PONERE LA PROP
class ElementoDeJuego {
    var position
    var image

    method esPuerta() = false
    method esRelojDeArena() = false
    method esInteractuable() = false

    method interactuar(personaje) {
        // por defecto no hace nada.
    }
}

// nuestros muebles interactuables que van a ser objetos interactuables
// van a resevir por herencia de ElementoDeJuego e implementar la interfaz Interactuable
class ObjetoInteractuable inherits ElementoDeJuego {
    method esInteractuable() = true
    method interactuar(personaje)
}
// mueble contiene objetos y es interactuable para "abrirlo"
class Mueble inherits ObjetoInteractuable {
    var nombre = "mueble"
    var property imagenIntern
    var objetosOcultos = new List()

    override method interactuar(personaje) {
        // mostrar lo que tiene.
        // por ahora mensjaito....
        game.say(self, "Aquí dentro encontraste: " + objetosOcultos.join(", "))
        game.boardGround("imagenInterior")
    }

    method agregarObjeto(objeto) {
        objetosOcultos.add(objeto)
    }
}

// objetos para las trampas. Son interactuables para poder agarrarlos.
class ObjetoDeTrampa inherits ObjetoInteractuable {
    var property nombre

    override method interactuar(personaje) {
        personaje.agarrar(self)
        // si lo encuentra, le baja el estres a Cenicienta
        personaje.disminuirEstres(5)
    }
    


}

// consumible que da tiempo extra
class RelojDeArena inherits ObjetoInteractuable {
    override method interactuar(personaje) { //lo hacemos en el juego.wlk
       
    }
    

}

class Puerta inherits ObjetoInteractuable {
    var property nivelDestino
    override method esPuerta() = true

    override method interactuar(personaje) {
        // Lo maneja juego.wlk al colisionar
    }
}
// Las prendas son solo objetos visuales por ahora
class Prenda inherits ElementoDeJuego {}
class ZapatoDeCristal inherits Prenda {}
