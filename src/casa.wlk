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
	var saldo = 0
	
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
	var saldo = 0
	
	method saldo() {
		return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
	}
	
	method depositar(cantidad) {
		cuentaPrimaria.depositar(cantidad)
	}
	
	method extraer(cantidad) {
		return if (cuentaPrimaria.saldo() >= cantidad) cuentaPrimaria.extraer(cantidad) else cuentaSecundaria.extraer(cantidad)
	}
	
}
	


