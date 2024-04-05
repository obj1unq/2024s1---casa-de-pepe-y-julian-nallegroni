object casaDePepeYJulian {

	var property porcentajeViveres = 50
	var costoReparaciones = 0
	const property cuentaGastos = cuentaCorriente
	var property estrategiaAhorro = minimoEIndispensable

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
	
	method estrategiaAhorro(_estrategiaAhorro) {
		estrategiaAhorro = _estrategiaAhorro
	}
	
	method hacerMantenimiento() {
		estrategiaAhorro.mantenimiento()
	}

	method saldo() {
		return cuentaGastos.saldo()
	}
	
	method costoReparaciones() {
		return costoReparaciones
	}
}

object minimoEIndispensable {
	var casa = casaDePepeYJulian
	var calidad = 2
	
	method calidad(_calidad) {
		calidad = _calidad
	}
	
	method mantenimiento() {
		if (not casa.tieneViveresSuficientes()) self.comprarMinimosViveres()
	}
	
	method comprarMinimosViveres() {
		casa.gastar(self.porcentajeMinimoNecesario() * calidad)
		casa.porcentajeViveres(40)
	}
	
	method porcentajeMinimoNecesario() {
		return 40 - casa.porcentajeViveres()
	}
}

object full {
	var casa = casaDePepeYJulian
	const calidad = 5
	
	
	method mantenimiento() {
		self.llenarSiEstaEnOrden()
		self.repararSiAlcanzaYSobran1000()
	}
	
	method llenarSiEstaEnOrden() {
		if (casa.estaEnOrden()) self.llenarViveres() else self.aumentarEn40Viveres()
	}
	
	method llenarViveres() {
		casa.gastar(self.porcentajeNecesarioParaLlenar() * calidad)
		casa.porcentajeViveres(100)
	}
	
	method porcentajeNecesarioParaLlenar() {
		return 100 - casa.porcentajeViveres()
	}
	
	method aumentarEn40Viveres() {
		casa.gastar(40 * calidad)
		casa.porcentajeViveres(casa.porcentajeViveres() + 40)
	}
	
	method repararSiAlcanzaYSobran1000() {
		if (self.alcanzaParaReparacionesYSobra1000()) self.hacerReparaciones()
	}
	
	method alcanzaParaReparacionesYSobra1000() {
		return self.saldoDescontandoReparaciones() > 1000
	}
	
	method saldoDescontandoReparaciones() {
		return casa.saldo() - casa.costoReparaciones()
	}
	
	method hacerReparaciones() {
		casa.gastar(casa.costoReparaciones())
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
	
/*  Para que al agregar una nueva casa se puedan utilizar las mismas estrategias en ella, basicamente debe entender los mismos mensajes
 	que la casaDePepeYJulian */

