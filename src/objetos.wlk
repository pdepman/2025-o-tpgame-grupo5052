// la interfaz es un "contrato". cualquier clase que la implemente
// ESTA OBLIGADA a tener un metodo llamado "interactuar".
// esto es la base de nuestro polimorfismo.
interface Interactuable {
    method interactuar(personaje)
}

// la clase mas general de todas. no se pueden crear instancias de ella (es abstracta).
// define lo que CUALQUIER objeto en el juego tiene: una posición y una imagen.
abstract class ElementoDeJuego {
    var property position
    var property image
}

// mueble contiene objetos y es interactuable para "abrirlo"
class Mueble inherits ElementoDeJuego implements Interactuable {
    var objetosOcultos = new List()

    override method interactuar(personaje) {
        // mostrar lo que tiene.
        // por ahora mensjaito....
        game.say(self, "Aquí dentro encontraste: " + objetosOcultos.join(", "))
    }

    method agregarObjeto(objeto) {
        objetosOcultos.add(objeto)
    }
}

// objetos para las trampas. Son interactuables para poder agarrarlos.
class ObjetoDeTrampa inherits ElementoDeJuego implements Interactuable {
    var property nombre

    override method interactuar(personaje) {
        personaje.agarrar(self)
        // si lo encuentra, le baja el estres a Cenicienta
        personaje.disminuirEstres(5)
    }
    
    // metodo para que Cenicienta sepa si lo puede agarrar
    method esAgarrable() = true
}

// consumible que da tiempo extra
class RelojDeArena inherits ElementoDeJuego implements Interactuable {
    override method interactuar(personaje) {
        juego.aumentarTiempo(15) // Llama a un método del objeto 'juego'
        game.removeVisual(self) // desaparece al usarse
    }
    
    method esAgarrable() = false // Nno agarrar, solo usar
}

// Las prendas son solo objetos visuales por ahora
class Prenda inherits ElementoDeJuego {}
class ZapatoDeCristal inherits Prenda {}