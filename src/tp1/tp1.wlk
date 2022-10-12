object jardin {
	var property malezas = 30
	
	method image()
	  = if(not self.desprolijo()) "arbusto.png"
	    else "arbusto-desprolijo.png"
	
	method crecerMalezas() {
		malezas += 5
	}

	method desprolijo() {
		return malezas > 20
	}
	
	method emprolijar(nivelDeProlijidad) {
		if(nivelDeProlijidad >= 10) malezas = 0
		if(nivelDeProlijidad.between(3, 9)) malezas /= 2
	}
}

object spa {
	method image() = "spa.png"
	
	method atender(persona) {
		persona.darseUnBanioDeVaporDurante(5)
		persona.recibirMasajes()
		persona.darseUnBanioDeVaporDurante(15)
	}
}

object olivia {
	var property relax = 4
	
	method image() = "jardinera.png"
	
	method trabajarEnJardin(unJardin){
		if(unJardin.desprolijo()) self.estresarse(2)
		unJardin.emprolijar(2 * relax)
		self.estresarse(1)
	}
	
	method estresarse(estres){
		relax = (relax - estres).max(1)
	}
	
	method darseUnBanioDeVaporDurante(minutos) {
		relax += minutos / 5
	}
	
	method recibirMasajes() {
		relax += 3
	}
}

object adriano {
	var property contracturas = 0
	
	method image() = "jardinero.png"
	
	method trabajarEnJardin(unJardin){
		const malezasIniciales = unJardin.malezas()
		if(self.estaLastimado()) unJardin.emprolijar(1)
		else unJardin.emprolijar(5)
		contracturas += 7.min(malezasIniciales)
	}
	
	method estaLastimado() {
		return contracturas > 10
	}
	
	method darseUnBanioDeVaporDurante(minutos) {
		if(self.estaLastimado()) self.disminuirContracturas(2)
	}
	
	method recibirMasajes() {
		self.disminuirContracturas(5)
	}
	
	method disminuirContracturas(disminucion) {
		contracturas = (contracturas - disminucion).max(0)
	}
}