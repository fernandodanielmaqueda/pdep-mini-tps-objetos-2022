import tp4.usuario.*
import tp4.redSocial.*

// Para facilitar la creación de objetos de prueba
object fabrica {
	const property creador = new Usuario(nombre = "Tito")
	
	method fechaPublicacion() = new Date()
	
	method crearPublicacionPublica() = new Publicacion(usuarioCreador = self.creador(), fechaDePublicacion = self.fechaPublicacion(), visibilidad = publica)
	method crearPublicacionPrivada() = new Publicacion(usuarioCreador = self.creador(), fechaDePublicacion = self.fechaPublicacion(), visibilidad = privada)
	method crearHistoriaPublica() = new Historia(usuarioCreador = self.creador(), fechaDePublicacion = self.fechaPublicacion(), visibilidad = publica)
	method crearHistoriaPrivada() = new Historia(usuarioCreador = self.creador(), fechaDePublicacion = self.fechaPublicacion(), visibilidad = privada)
	method crearPublicacionSecreta(usuariosRestringidos)  = new Publicacion(usuarioCreador = self.creador(), fechaDePublicacion = self.fechaPublicacion(), visibilidad = secreta, usuariosRestringidos = usuariosRestringidos)
	method crearHistoriaSecreta(usuariosRestringidos) = new Historia(usuarioCreador = self.creador(), fechaDePublicacion = self.fechaPublicacion(), visibilidad = secreta, usuariosRestringidos = usuariosRestringidos)
	
	// Otros métodos convenientes que se usan desde las pruebas
	// No se espera que los cambies
	
	method fechaLejanaAPublicacion() = self.fechaPublicacion().plusDays(10)
	method diaSiguienteAPublicacion() = self.fechaPublicacion().plusDays(1)
	
	method configurarContactos(){
		creador.agregarContacto(new Usuario(nombre = "Ana"))
		creador.agregarContacto(new Usuario(nombre = "Fito"))
	}
	
	method desconocido() = new Usuario(nombre = "Anónimo")
	method contactoDelCreador() = self.creador().contactos().anyOne()
	
	method usuariosDePrueba() 
		= #{creador, self.desconocido()} + creador.contactos()
}