import tp4.usuario.*

class Publicacion {
	const property usuarioCreador
	const fechaDePublicacion
	var property visibilidad
	
	method esVisible(usuario, fecha) = self.esElUsuarioCreador(usuario) || self.cumpleCondicionDeVisibilidad(usuario, fecha)
	
	method esElUsuarioCreador(usuario) = usuario == usuarioCreador
	
	method cumpleCondicionDeVisibilidad(usuario, fecha) = visibilidad.puedeVerla(usuario, self)
}

class Historia inherits Publicacion {
	override method cumpleCondicionDeVisibilidad(usuario, fecha) = super(usuario, fecha) && self.noHayMasDeUnDiaDeDiferencia(fecha)
	
	method noHayMasDeUnDiaDeDiferencia(fecha) = (fecha - fechaDePublicacion) <= 1
}

object publica {
	method puedeVerla(usuario, publicacion) = true
}

object privada {
	method puedeVerla(usuario, publicacion) = publicacion.usuarioCreador().tieneContacto(usuario)
}

class Secreta {
	var property usuariosRestringidos = #{}
	
	method puedeVerla(usuario, publicacion) = privada.puedeVerla(usuario, publicacion) && not self.estaRestringido(usuario)
	
	method estaRestringido(usuario) = usuariosRestringidos.contains(usuario)
}