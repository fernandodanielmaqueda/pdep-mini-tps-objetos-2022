object carrito {
	const carrito = []

	method agregar(producto) {
		carrito.add(producto)
	}

	method estaVacio() = carrito.isEmpty()
	
	method cantidadDeProductos() = carrito.size()
	
	method totalAAbonar() = carrito.sum( {producto => producto.precioAAbonar()} )
	
	method productoMasCaro() = carrito.max( {producto => producto.precioAAbonar()} )
	
	method detalleDeCompra() = carrito.map( {producto => producto.detalleDeProducto()} ).asSet().sortedBy( {descripcion1, descripcion2 => descripcion1 < descripcion2} )

}

class ProductoDeVentaUnitaria {
	var property nombreDelProducto
	var property precioUnitario
	
	method precioAAbonar() = precioUnitario
	
	method detalleDeProducto() = nombreDelProducto.toString()
}

class ProductoDeVentaPorPeso {
	var property nombreDelProducto
	var property precioPorKilo
	var property pesoEnKg
	
	method precioAAbonar() = precioPorKilo * pesoEnKg
	
	method detalleDeProducto() = nombreDelProducto.toString() + " x " + pesoEnKg.toString() + " kg"
}