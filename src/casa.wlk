object casaDePepeYJulian {

	var porcentajeViveres = 50
	var costoReparaciones = 0

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

}

