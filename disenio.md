# Disenio Técnico y Fundamentos de la Materia

Para hacer el juego, aplicamos varios de los conceptos que vimos en Paradigmas. La idea era que el código quedara prolijo, que no repitiéramos cosas al vicio y que fuera fácil de entender.

---

### 1. Polimorfismo: La Tecla de "Interactuar" Mágica 

El **polimorfismo** es la idea clave de nuestro juego. [cite_start]Como dice el apunte, para que exista, se necesitan como mínimo tres objetos: uno que "usa" y al menos dos que son "usados"[cite: 20].

* **En nuestro juego** :
    * **El que "usa"**: Es `Cenicienta`.
    * **Los "usados"**: Son el `Raton`, la `Hermanastra`, el `Gato`, el `RelojDeArena`, etc.

    La magia está en que Cenicienta no necesita saber con qué está interactuando. [cite_start]Ella solo manda un mensaje: `interactuar()`[cite: 18, 40]. [cite_start]Todos esos objetos son polimórficos porque entienden ese mismo mensaje, pero cada uno responde a su manera[cite: 22]:
    * `raton.interactuar()` => Le baja el estrés a Cenicienta.
    * `hermanastra.interactuar()` => Le sube el estrés.
    * `relojDeArena.interactuar()` => Le da más tiempo al `Juego`.

    Esto lo logramos con la interfaz `Interactuable`. Cualquier cosa que queramos que Cenicienta "use" en el juego, simplemente la hacemos implementar esta interfaz y listo. Así, el código es súper simple y no tenemos un `if` gigante preguntando "¿esto es un ratón? ¿es un gato?".

---

### 2. Encapsulamiento: ¡Nadie Toca el Estrés de Cenicienta! 

La idea del **encapsulamiento** es que cada objeto se encargue de sus propias cosas. Sus datos internos (atributos) están "encapsulados" o protegidos, y solo se pueden modificar a través de sus métodos. [cite_start]Quien usa el objeto no necesita saber los detalles de cómo funciona por dentro[cite: 597].

* **En nuestro juego**:
    El mejor ejemplo es el estrés de `Cenicienta`. El atributo `estres` es parte del estado interno de ella. Ningún otro objeto puede venir y cambiarle el valor directamente.

    En vez de eso, creamos métodos para que ella misma gestione su estrés:
    * `aumentarEstres(cantidad)`
    * `disminuirEstres(cantidad)`

    Dentro de esos métodos, nos aseguramos de que el estrés nunca se pase de 100 ni baje de 0. Así, `Cenicienta` tiene el control total sobre su estado, y evitamos que se rompa el juego por un valor inválido.

---

### 3. Herencia: No Escribir el Mismo Código Mil Veces 👨‍👩‍👧

Usamos **herencia** para agrupar comportamiento que se repetía. [cite_start]La idea es tener una clase "madre" (superclase) con toda la lógica común, y clases "hijas" (subclases) que heredan todo eso y le agregan su toque especial[cite: 710, 711].

* **En nuestro juego**:
    1.  **`ElementoDeJuego` (La Abuela de Todos)**: Es una clase abstracta que dice: "toda cosa que exista en el juego tiene una posición y una imagen". [cite_start]La definimos como abstracta porque no tiene sentido crear un "ElementoDeJuego" genérico, solo sirve como base[cite: 951].
    2.  **`Personaje` (La Mamá)**: Es un `ElementoDeJuego`, así que hereda lo de la posición y la imagen. Pero le agrega algo nuevo: el método `mover()`.
    3.  **`Cenicienta`, `Raton`, `Hermanastra` (Las Hijas)**: Todas heredan de `Personaje`. Así, no tuvimos que escribir el código para moverse en cada una. ¡Ya lo tenían gratis! Simplemente lo reusamos.

    Esto nos ahorró un montón de código repetido y dejó todo mucho más ordenado en una jerarquía clara.

---

### 4. Referencias y Atributos: `var` vs. `const` 

[cite_start]Como vimos en la cursada, una variable es una **referencia**, como una flecha que apunta a un objeto[cite: 609, 610].

* **En nuestro juego**:
    * Usamos **`var`** para cosas que necesitan cambiar a qué objeto apuntan. Por ejemplo, el `estres` de Cenicienta es `var` porque su valor (el objeto número al que apunta) cambia todo el tiempo.
        `var estres = 0` // Apunta al objeto 0
        `estres = 15` // Ahora la misma flecha apunta al objeto 15

    * Usamos **`const`** para referencias que no van a cambiar nunca. Por ejemplo, la referencia a Cenicienta en la clase `Juego` es `const`.
        `const cenicienta = new Cenicienta()`

        Esto es importante: que la referencia sea `const` no significa que el objeto no pueda cambiar. Significa que la "flecha" `cenicienta` **siempre va a apuntar a la misma instancia de Cenicienta**. Pero el estado interno de ese objeto (su estrés, las prendas que tiene) sí puede cambiar. Si intentáramos hacer `cenicienta = otroPersonaje`, ahí sí Wollok nos daría un error.

---

### 5. Diagrama de Clases

Este diagrama muestra cómo se relacionan todas las clases e interfaces del juego.

```plantuml
@startuml
' --- Estilo y configuración del diagrama ---
skinparam classAttributeIconSize 0
skinparam style strictuml
hide empty members

' --- Clase Central del Juego ---
class Juego {
  - reloj: Timer
  - nivelActual: number
  - cenicienta: Cenicienta
  - elementosEnEscena: List
  + {method} iniciarNivel()
  + {method} verificarVictoria()
  + {method} verificarDerrota()
}

' --- Interfaz ---
interface Interactuable {
  + {method} interactuar(personaje)
}

' --- Clases Abstractas ---
abstract class ElementoDeJuego {
  # posicion
  # imagen
}

abstract class Personaje {
  + {method} mover(unaDireccion)
}

' --- Clases Concretas ---
class Cenicienta {
  - estres: number
  - objetoEnMano: ElementoDeJuego
  - prendas: List<Prenda>
  + {method} aumentarEstres(cantidad)
  + {method} disminuirEstres(cantidad)
  + {method} agregarPrenda(prenda)
}

class Hermanastra {
    + {method} interactuar(personaje)
}

class Raton {
  - pista: String
  + {method} interactuar(personaje)
}

class Gato {
  + {method} interactuar(personaje)
}

class Mueble {
  - objetosOcultos: List
  + {method} interactuar(personaje)
}

class ObjetoDeTrampa {
    + {method} interactuar(personaje)
}

class Prenda {
}

class ZapatoDeCristal {}

class RelojDeArena {
  + {method} interactuar(personaje)
}

' --- Relaciones entre Clases ---

' Herencia (es un...)
ElementoDeJuego <|-- Personaje
Personaje <|-- Cenicienta
Personaje <|-- Hermanastra
Personaje <|-- Raton
Personaje <|-- Gato
ElementoDeJuego <|-- Mueble
ElementoDeJuego <|-- ObjetoDeTrampa
ElementoDeJuego <|-- Prenda
Prenda <|-- ZapatoDeCristal
ElementoDeJuego <|-- RelojDeArena

' Implementación de la interfaz (implementa...)
Interactuable <|.. Hermanastra
Interactuable <|.. Raton
Interactuable <|.. Gato
Interactuable <|.. Mueble
Interactuable <|.. ObjetoDeTrampa
Interactuable <|.. RelojDeArena


' Composición y Agregación (tiene / contiene)
Juego "1" *-- "1" Cenicienta : controla >
Juego "1" o-- "many" ElementoDeJuego : contiene >
Cenicienta "1" -- "0..*" Prenda : colecciona >

@enduml