package ar.edu.unq.uis.domino.data

import ar.edu.unq.uis.domino.model.Delivery
import ar.edu.unq.uis.domino.model.RetiraPorElLocal
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.uis.domino.model.FormaDeEnvio

@Accessors
class FormaDeEnvioRequest {
	String nombre
	String direccion
	
	new(){}
	
	def createFormaDeEnvio(){
		if (nombre.toLowerCase == "delivery"){
			new Delivery(direccion)
		} else {
			new RetiraPorElLocal()
		}
	}
	
	def static from(FormaDeEnvio envio) {
		val formaDeEnvioRequest = new FormaDeEnvioRequest
		formaDeEnvioRequest.nombre = envio.class.simpleName.toLowerCase
		formaDeEnvioRequest
	}
	
}