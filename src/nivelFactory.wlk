import wollok.game.*
import niveles.* 
import personajes.*

object nivelFactory {
    
    //derrota
    const property datosDerrota = object {
        var property imagenPrincipal = "derrota.png"
        var property posicionPrincipal = game.at(50, 90)
        var property imagenSecundaria = "hermanas.png"
        var property posicionSecundaria = game.at(0, 0)
        var property mensaje = "¡El estrés te venció! No pudiste completar la misión a tiempo..."
    }
    
    //victoria
    const property datosVictoria = object {
        var property imagenPrincipal = "imagenVictoria.png"
        var property posicionPrincipal = game.at(78, 86)
        var property imagenSecundaria = null
        var property posicionSecundaria = null
        var property mensaje = "¡Lograste vencer a las hermanastras!"
    }
    
    
    method crearNivelCocina() {
        return new NivelConMision(
            fondoNivel = "nivelCocinaFondo.jpeg",
            imagenListaMision = "misionCocina.png",
            cantidadObjetosMision = 3,
            
            objetosDeMisionData = [
                //heladera
                object {
                    var property position = game.at(156, 51)
                    var property image = "heladeraSola.png"
                    var property muebleCerrada = "heladeraSola.png"
                    var property muebleAbierta = "Huevos.png"
                    var property nombreObjeto = "Huevo"
                    var property imagenObjetoRecolectable = "huevosAgarrar.png"
                    var property posicionObjeto = game.at(148, 31)
                    var property mensajeDescubrimiento = "Abriste la heladera... ¡Encontraste los huevos!"
                },
                //mesa
                object {
                    var property position = game.at(71, 51) 
                    var property image = "aceiteSolo.png"
                    var property muebleCerrada = "aceiteSolo.png"
                    var property muebleAbierta = "nivelCocinaMuebleAbierta_Aceite.png"
                    var property nombreObjeto = "Aceite"
                    var property imagenObjetoRecolectable = "nivelCocinaObjetoRecolectable_Aceite.jpeg"
                    var property posicionObjeto = game.at(76, 46)
                    var property mensajeDescubrimiento = "¡Encontraste el aceite!"
                },
                //estanteria
                object {
                    var property position = game.at(3, 53) 
                    var property image = "estanteriaSola.png"
                    var property muebleCerrada = "estanteriaSola.png"
                    var property muebleAbierta = "estanteriaHarina.png"
                    var property nombreObjeto = "Harina"
                    var property imagenObjetoRecolectable = "harinaAgarrar.png"
                    var property posicionObjeto = game.at(26, 41)
                    var property mensajeDescubrimiento = "¡Encontraste la harina!"
                }
            ],
            
            objetosEstresantesData = [
                //escoba
                object {
                    var property position = game.at(111, 21)
                    var property image = "nivelCocinaObjetoEstresante_Escoba.png"
                    var property nombre = "Escoba sucia"
                    var property valorEstres = 10
                }
            ],
            
            mueblesEnganiososData = [], 
            
            pantallaVictoriaData = object {
                var property imagenPrincipal = datosVictoria.imagenPrincipal()
                var property posicionPrincipal = datosVictoria.posicionPrincipal()
                var property imagenSecundaria = "nivelCocinaHermanasCumplido.png"
                var property posicionSecundaria = game.at(0, 0)
                var property mensaje = datosVictoria.mensaje()
            },
            pantallaDerrotaData = datosDerrota,

            // ratones
            ratoncitosNivel = { juego => 
                new Raton(
                    position = game.at(120, 75),
                    pista = "Pista! Blancos y frágiles como la luna, se esconden donde siempre hace frío.",
                    reduccionEstress = 0
                    )
                }
        )
    }

    method crearNivelDormitorio() {
        return new NivelConMision(
            fondoNivel = "nivelDormitorioFondo.jpeg",
            imagenListaMision = "misionDormitorio.png",
            cantidadObjetosMision = 2,
            
            objetosDeMisionData = [
                //cama
                object {
                    var property position = game.at(76, 81)
                    var property image = "nivelDormitorioMuebleCerrado_Cama.png"
                    var property muebleCerrada = "nivelDormitorioMuebleCerrado_Cama.png"
                    var property muebleAbierta = "nivelDormitorioMuebleAbierto_Cama.png"
                    var property nombreObjeto = "frazada"
                    var property imagenObjetoRecolectable = "nivelDormitorioObjetoDesestresante_frazada.png"
                    var property posicionObjeto = game.at(78, 80)
                    var property mensajeDescubrimiento = "¡Encontraste la frazada!"
                },
                //placard
                object {
                    var property position = game.at(161, 56)
                    var property image = "nivelDormitorioMuebleCerrado_Placard.png"
                    var property muebleCerrada = "nivelDormitorioMuebleCerrado_Placard.png"
                    var property muebleAbierta = "nivelDormitorioMuebleAbierto_Placard.png"
                    var property nombreObjeto = "costurero"
                    var property imagenObjetoRecolectable = "nivelDormitorioObjetoDesestresante_costurero.png"
                    var property posicionObjeto = game.at(136, 41)
                    var property mensajeDescubrimiento = "¡Encontraste el Costurero!"
                }
            ],
            
            objetosEstresantesData = [
                object {
                    var property position = game.at(111, 21)
                    var property image = "nivelDormitorioObjetoEstresante_Ropa.png"
                    var property nombre = "Ropa sucia"
                    var property valorEstres = 10
                },
                object {
                    var property position = game.at(66, 51)
                    var property image = "nivelDormitorioObjetoEstresante_Collar.png"
                    var property nombre = "Collares desordenados"
                    var property valorEstres = 10
                }
            ],
            
            mueblesEnganiososData = [
                object {
                    var property position = game.at(126, 71) 
                    var property image = "nivelDormitorioMuebleXDdd.png"
                    var property muebleEnganio = "nivelDormitorioMuebleXDdd.png" 
                    var property mensajeEnganio = "Aca no hay nada..."
                },
                object {
                    var property position = game.at(36, 26) 
                    var property image = "nivelDormitorioMuebleXD.png"
                    var property muebleEnganio = "nivelDormitorioMuebleXD.png"
                    var property mensajeEnganio = "Aca no hay nada..."
                }
            ],
            
            pantallaVictoriaData = object {
                var property imagenPrincipal = datosVictoria.imagenPrincipal()
                var property posicionPrincipal = datosVictoria.posicionPrincipal()
                var property imagenSecundaria = "nivelDormitorioHermanasCompletado.png"
                var property posicionSecundaria = game.at(0, 0)
                var property mensaje = datosVictoria.mensaje()
            },
            pantallaDerrotaData = datosDerrota
            ,

            // raton habitacion 
            ratoncitosNivel = { juego =>
                new Raton(
                    position = game.at(90, 78),  
                    pista = "Pista! De noche me abrigo con ella; descansa doblada y suave, protegiendo los sueños.",
                    reduccionEstress = 20
                )
            }
        )
    }

    method crearNivelBanio() {
        return new NivelConMision(
            fondoNivel = "nivelBanioFondo.jpeg",
            imagenListaMision = "misionBanio.png",
            cantidadObjetosMision = 2,
            objetosDeMisionData = [
                object {
                    var property position = game.at(51, 71)
                    var property image = "nivelBanioMuebleCerrado_Ducha.png"
                    var property muebleCerrada = "nivelBanioMuebleCerrado_Ducha.png"
                    var property muebleAbierta = "nivelBanioMuebleAbierto_Ducha.png"
                    var property nombreObjeto = "ducha"
                    var property imagenObjetoRecolectable = "nivelBanioJabon.png"
                    var property posicionObjeto = game.at(63, 69)
                    var property mensajeDescubrimiento = "¡Encontraste el jabon!"
                },
                object {
                    var property position = game.at(153, 56)
                    var property image = "nivelBanioMuebleCerrado.png"
                    var property muebleCerrada = "nivelBanioMuebleCerrado.png"
                    var property muebleAbierta = "nivelBanioMuebleAbierto.png"
                    var property nombreObjeto = "espejoBanio"
                    var property imagenObjetoRecolectable = "nivelBanioPerfume.png"
                    var property posicionObjeto = game.at(136, 41)
                    var property mensajeDescubrimiento = "¡Encontraste el perfume!"
                }
            ],
            objetosEstresantesData = [
                object {
                    var property position = game.at(111, 21)
                    var property image = "nivelBanioTrampa2.png"
                    var property nombre = "toalla"
                    var property valorEstres = 40
                },
                object {
                    var property position = game.at(66, 51)
                    var property image = "nivelBanioTrampa.png"
                    var property nombre = "charco"
                    var property valorEstres = 60
                }
            ],
            mueblesEnganiososData = [
                object {
                    var property position = game.at(120, 71)
                    var property image = "nivelBanioEnganio1.png"
                    var property muebleEnganio = "nivelBanioEnganio1.png"
                    var property mensajeEnganio = "Aca no hay nada..."
                },
                object {
                    var property position = game.at(36, 26)
                    var property image = "nivelBanioEnganio2.png"
                    var property muebleEnganio = "nivelBanioEnganio2.png"
                    var property mensajeEnganio = "Aca no hay nada..."
                }
            ],
            pantallaVictoriaData = object {
                var property imagenPrincipal = datosVictoria.imagenPrincipal()
                var property posicionPrincipal = datosVictoria.posicionPrincipal()
                var property imagenSecundaria = "nivelBanioHermanasCumplido.png"
                var property posicionSecundaria = game.at(0, 0)
                var property mensaje = datosVictoria.mensaje()
            },
            pantallaDerrotaData = datosDerrota
            ,

            // raton baño
            ratoncitosNivel = { juego =>
                new Raton(
                    position = game.at(60, 72),
                    pista = "Pista!Hace burbujas y huele bien, buscalo donde el agua canta.",
                    reduccionEstress = 30
                )
            }
        )
    }

    method crearNivelJardin() {
        return new NivelConMision(
            fondoNivel = "nivelJardinFondo.jpeg",
            imagenListaMision = "misionJardin.png",
            cantidadObjetosMision = 1,
            objetosDeMisionData = [
                object {
                    var property position = game.at(100, 30)
                    var property image = "nivelJardinMuebleCerrado.png"
                    var property muebleCerrada = "nivelJardinMuebleCerrado.png"
                    var property muebleAbierta = "nivelJardinMuebleAbierto.png"
                    var property nombreObjeto = "Hojas"
                    var property imagenObjetoRecolectable = "nivelJardinHojas.jpeg"
                    var property posicionObjeto = game.at(105, 40)
                    var property mensajeDescubrimiento = "¡Encontraste las hojas!"
                }
            ],
            objetosEstresantesData = [
                object {
                    var property position = game.at(101, 61)
                    var property image = "nivelJardinTramapa1.png"
                    var property nombre = "rastrillo"
                    var property valorEstres = 100
                },
                object {
                    var property position = game.at(50, 40)
                    var property image = "nivelJardin_Estresante1.png"
                    var property nombre = "tierra"
                    var property valorEstres = 2
                }
            ],
            mueblesEnganiososData = [
                object {
                    var property position = game.at(81, 91)
                    var property image = "nivelJardin_MuebleEngani2.png"
                    var property muebleEnganio = "nivelJardin_MuebleEngani2.png"
                    var property mensajeEnganio = "Aca no hay nada..."
                },
                object {
                    var property position = game.at(131, 61)
                    var property image = "nivelJardin_MuebleEngani1.png"
                    var property muebleEnganio = "nivelJardin_MuebleEngani1.png"
                    var property mensajeEnganio = "Aca no hay nada..."
                },
                object {
                    var property position = game.at(25, 50)
                    var property image = "nivelJardinEnganio1.png"
                    var property muebleEnganio = "nivelJardinEnganio1.png"
                    var property mensajeEnganio = "Aca no hay nada..."
                }
            ],
            pantallaVictoriaData = object {
                var property imagenPrincipal = datosVictoria.imagenPrincipal()
                var property posicionPrincipal = game.at(90, 85)
                var property imagenSecundaria = "hermanasJardin.png"
                var property posicionSecundaria = game.at(0, 0)
                var property mensaje = datosVictoria.mensaje()
            },
            pantallaDerrotaData = datosDerrota
            ,

            // raton jardin
            ratoncitosNivel = { juego =>
                new Raton(
                    position = game.at(110, 35),
                    pista = "Pista!Entre ruedas dormidas y barro silente,
                    reposan las hojas que buscan tu suerte.",
                    reduccionEstress = 40
                )
            }
        )
    }
}