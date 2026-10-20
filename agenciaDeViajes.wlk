class Pack {
var property coordinador
var property duracion
var property precio
const property beneficios = []

method valorFinal() = precio + beneficios.filter({ b => b.estaVigente() }).sum({ beneficio => beneficio.costo()})
method cantidadBeneficiosVigentes() = beneficios.count({ b => b.estaVigente() })

method esPremium()
}

class Coordinador {
    var rol
    var property estaMotivado
    var property viajesRealizados = 0
    var property aniosDeExperiencia = 0
    const rolesPermitidos = [guia, asistenteLogico, acompaniante]

method esAltamenteCalificado() = viajesRealizados > 20 and rol.condicion(self)

method asignarRol(nuevoRol){
    if(not rolesPermitidos.contains(nuevoRol)) {
     self.error("Ese rol no esta permitido ")
    }
    rol = nuevoRol
}
method rol() = rol
}

class Beneficio {
    var property tipo
    var property costo
    var property estaVigente
}
object guia {
method condicion(coordinador) = coordinador.estaMotivado()

}
object asistenteLogico {
    method condicion(coordinador) = coordinador.aniosDeExperiencia() >= 3
}
object acompaniante {
    method condicion(coordinador) = true
}

class PackNacional inherits Pack {
    var property provinciaDestino
    const property actividadesIncluidas = []

    override method esPremium() = duracion > 10 and coordinador.esAltamenteCalificado()
}

class PackInternacional inherits Pack {
    var property paisDestino
    var property cantidadEscalas
    var property esLugarDeInteres

    override method  valorFinal() = super() * 1.20
    override method esPremium() = self.esLugarDeInteres() and duracion > 20 and cantidadEscalas == 0 
} 

class PackProvincial inherits PackNacional {
    var property cantidadDeCiudadesAVisitar 

    override method esPremium() {
        return actividadesIncluidas.size() >= 4 and cantidadDeCiudadesAVisitar > 5 and self.cantidadBeneficiosVigentes() >= 3 
        }
   
    override method valorFinal() {
        const totalProvincial = super()
        return if (self.esPremium()) totalProvincial * 1.05 else totalProvincial
    }
}