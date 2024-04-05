object casaDePepeYJulian {

	var porcentajeViveres = 50
	var costoReparaciones = 0
	const property cuentaGastos = cuentaCorriente

	method tieneViveresSuficientes() {
		return porcentajeViveres > 40
	}

	method necesitaReparaciones() {
		return costoReparaciones > 0
	}

	method estaEnOrden() {
		return self.tieneViveresSuficientes() && not self.necesitaReparaciones()
	}

	method romperAlgoDe(valor) {
		costoReparaciones += valor
	}
	
	method gastar(cantidad) {
		cuentaGastos.extraer(cantidad)
	}

}

object cuentaCorriente {
	var saldo = 500
	
	method saldo() {
		return saldo
	}
	
	method depositar(cantidad) {
		saldo += cantidad
	}
	
	method extraer(cantidad) {
		saldo -= cantidad
	}
}

object cuentaConGastos {
	var saldo = 0
	var property costoOperacion = 50
	
	method saldo() {
		return saldo
	}
	
	method depositar(cantidad) {
		saldo += cantidad - costoOperacion
	}
	
	method extraer(cantidad) {
		saldo -= cantidad
	}
}

object cuentaCombinada {
	var property cuentaPrimaria = cuentaConGastos
	var property cuentaSecundaria = cuentaCorriente
	const saldo = cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
	
	method saldo() {
		return saldo
	}
	
	method depositar(cantidad) {
		cuentaPrimaria.depositar(cantidad)
	}
	
	method extraer(cantidad) {
		// Acá intenté usar la subtarea "tieneSaldoSuficiente" pero me tiraba varios errores q no pude solucionar
		return if (cuentaPrimaria.saldo() >= cantidad) cuentaPrimaria.extraer(cantidad) else cuentaSecundaria.extraer(cantidad)
	}
	
	method tieneSaldoSuficiente(cuenta, cantidad) {
		return cuenta.saldo() >= cantidad
	}
	
}
