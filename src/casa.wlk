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
		estrategiaAhorro.mantenimiento(self)
	}

	method saldo() {
		return cuentaGastos.saldo()
	}

	method costoReparaciones() {
		return costoReparaciones
	}

}

object minimoEIndispensable {

	var calidad = 2

	method calidad(_calidad) {
		calidad = _calidad
	}

	method mantenimiento(casa) {
		if (not casa.tieneViveresSuficientes()) self.comprarMinimosViveres(casa)
	}

	method comprarMinimosViveres(casa) {
		casa.gastar(self.porcentajeMinimoNecesario(casa) * calidad)
		casa.porcentajeViveres(40)
	}

	method porcentajeMinimoNecesario(casa) {
		return 40 - casa.porcentajeViveres()
	}

}

object full {

	const calidad = 5

	method mantenimiento(casa) {
		self.llenarSiEstaEnOrden(casa)
		if (self.alcanzaParaReparacionesYSobra(casa, 1000)) {
			self.hacerReparaciones(casa)
		}
	}

	method llenarSiEstaEnOrden(casa) {
		if (casa.estaEnOrden()) self.llenarViveres(casa) else self.aumentarViveresEn(40, casa)
	}

	method llenarViveres(casa) {
		casa.gastar(self.porcentajeNecesarioParaLlenar(casa) * calidad)
		casa.porcentajeViveres(100)
	}

	method porcentajeNecesarioParaLlenar(casa) {
		return 100 - casa.porcentajeViveres()
	}

	method aumentarViveresEn(cantidad, casa) {
		casa.gastar(cantidad * calidad)
		casa.porcentajeViveres(casa.porcentajeViveres() + 40)
	}

	method alcanzaParaReparacionesYSobra(casa, cantidad) {
		return self.saldoDescontandoReparaciones(casa) > cantidad
	}

	method saldoDescontandoReparaciones(casa) {
		return casa.saldo() - casa.costoReparaciones()
	}

	method hacerReparaciones(casa) {
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
