import tp4.usuario.*

class Publicacion {
	const property usuarioCreador
	const fechaDePublicacion
	var property visibilidad
	var property usuariosRestringidos = #{}
	
	method esVisible(usuario, fecha) = usuario == usuarioCreador || visibilidad.puedeVerla(usuario, self)
	
	method estaRestringido(usuario) = usuariosRestringidos.contains(usuario)
}

class Historia inherits Publicacion {
	override method esVisible(usuario, fecha) = usuario == usuarioCreador || (visibilidad.puedeVerla(usuario, self) && self.noHayMasDeUnDiaDeDiferencia(fecha))
	
	method noHayMasDeUnDiaDeDiferencia(fecha) = (fecha - fechaDePublicacion) <= 1
}

object publica {
	method puedeVerla(usuario, publicacion) = true
}

object privada {
	method puedeVerla(usuario, publicacion) = publicacion.usuarioCreador().tieneContacto(usuario)
}

object secreta {
	method puedeVerla(usuario, publicacion) = privada.puedeVerla(usuario, publicacion) && not publicacion.estaRestringido(usuario)
}