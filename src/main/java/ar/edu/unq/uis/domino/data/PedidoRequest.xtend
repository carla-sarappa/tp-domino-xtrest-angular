package ar.edu.unq.uis.domino.data

import java.util.List
import ar.edu.unq.uis.domino.model.Pizza
import ar.edu.unq.uis.domino.model.Cliente
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.uis.domino.model.Plato
import ar.edu.unq.uis.domino.model.Pedido

@Accessors
class PedidoRequest {
	List<PlatoRequest> platos
	Integer cliente
	String aclaraciones
	FormaDeEnvioRequest formaDeEnvio
	
	new(){}
	
	static def from(Pedido pedido){
		val request = new PedidoRequest()
		request.platos = pedido.platos.map [PlatoRequest.from(it)]
		request.cliente = pedido.cliente.id
		request.aclaraciones = pedido.aclaraciones
		request.formaDeEnvio = FormaDeEnvioRequest.from(pedido.formaDeEnvio)
		request
	}
	
}