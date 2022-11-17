class Cruza {
	method cruzar(perro1, perro2) {
		if(not perro1.sonCompatibles(perro2)) throw new PerrosIncompatiblesException(message = "Los perros a cruzar son incompatibles")
		const perroHembra = perro1.hembra(perro2)
		const perroMacho = if(perroHembra == perro2) perro1 else perro2
		return new Perro(velocidad = self.calculoValorCorrespondiente(perroHembra.velocidad(), perroMacho.velocidad()), fuerza = self.calculoValorCorrespondiente(perroHembra.fuerza(), perroMacho.fuerza()))
	}
	
	method calculoValorCorrespondiente(valor1, valor2)
}

object cruzaPareja inherits Cruza {
	override method calculoValorCorrespondiente(valor1, valor2) = (valor1 + valor2) / 2
}

object underdog inherits Cruza {
	override method calculoValorCorrespondiente(valor1, valor2) = (valor1.min(valor2)) * 2
}

object hembraDominante inherits Cruza {
	override method cruzar(perro1, perro2) {
		if(not self.laFuerzaDeLaHembraEsMayor(perro1, perro2)) throw new PerrosIncompatiblesException(message = "Los perros a cruzar son incompatibles")
		return super(perro1, perro2)
	}
	
	method laFuerzaDeLaHembraEsMayor(perro1, perro2) {
		const perroHembra = perro1.hembra(perro2)
		const perroMacho = if(perroHembra == perro2) perro1 else perro2
		return perroHembra.fuerza() > perroMacho.fuerza()
	}
	
	override method calculoValorCorrespondiente(valorMadre, valorPadre) = valorMadre + valorPadre / 20
}

class Criadero {
	const property perros
	method cruzar(estiloDeCruza, perroACruzar) {
		var intentosPendientes = 3
		const correctos = []
		self.ordenarPorStatus(self.potencialesParejas(estiloDeCruza, perroACruzar)).forEach({potencialPareja =>
			if(intentosPendientes <= 0) throw new IntentosDeCruzaAgotadosException(message = "Intentos de cruza agotados")
			try {
				correctos.add(estiloDeCruza.cruzar(perroACruzar, potencialPareja))
			} catch ex : PerrosIncompatiblesException {
				intentosPendientes--
			}
		})
		if(not correctos.isEmpty()) return correctos.head()
		else throw new NecesitaMasPerrosException(message = "Necesita mas perros")
	}
	
	method potencialesParejas(estiloDeCruza, perroACruzar) = perros.filter({perroDelCriadero => perroACruzar.sonCompatibles(perroDelCriadero)})
	
	method ordenarPorStatus(potencialesParejas) = potencialesParejas.sortedBy({potencialPareja1, potencialPareja2 => potencialPareja1.status() > potencialPareja2.status()})
}

////////////////////
/// Excepciones
////////////////////

class IntentosDeCruzaAgotadosException inherits DomainException {}
class NecesitaMasPerrosException inherits DomainException {}
class PerrosIncompatiblesException inherits DomainException {}

/////////////////////////////////////////////////////////////////////////////////////////

class Perro {
	const property esHembra = 0.randomUpTo(2).roundUp() > 1
	var property velocidad
	var property fuerza
	var property adulto = false

	method status() = self.fuerza() + self.velocidad()
	
	method tienenSexosDistintos(otroPerro) = otroPerro.esHembra() != self.esHembra()
	
	method ambosSonAdultos(otroPerro) = (otroPerro.adulto()) && (self.adulto())
	
	method sonCompatibles(otroPerro) = (self.ambosSonAdultos(otroPerro)) && (self.tienenSexosDistintos(otroPerro))
	
	method hembra(otroPerro) {
		if(not self.tienenSexosDistintos(otroPerro)) throw new PerrosIncompatiblesException(message = "Los perros a cruzar no tienen sexos distintos")
		if(self.esHembra()) return self
		else return otroPerro
	}
}
