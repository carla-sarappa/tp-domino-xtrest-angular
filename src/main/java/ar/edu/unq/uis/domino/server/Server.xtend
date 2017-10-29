package ar.edu.unq.uis.domino.server

import ar.edu.unq.uis.domino.data.PedidoRequest
import ar.edu.unq.uis.domino.model.Pedido
import ar.edu.unq.uis.domino.model.Tamanio
import ar.edu.unq.uis.domino.repo.Repositories
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils

/**
 * Servidor RESTful implementado con XtRest.
 */
@Controller
class Server {
    extension JSONUtils = new JSONUtils
    
    new() {
       
    }


    @Get("/promos")
    def getPromos() {
        response.contentType = ContentType.APPLICATION_JSON
        
        val pizzas = Repositories.pizzas.allInstances
        
        return ok(pizzas.toJson)
    }
    
    @Get("/tamanios")
    def getTamanios() {
        response.contentType = ContentType.APPLICATION_JSON
        
        val tamanios = Tamanio.tamanios
        
        return ok(tamanios.toJson)
    }
    
    @Get("/ingredientes")
    def getIngredientes() {
        response.contentType = ContentType.APPLICATION_JSON
        
        val ingredientes = Repositories.ingredientes.allInstances
        
        return ok(ingredientes.toJson)
    }
    
    @Post("/pedidos")
    def postPedido(@Body String body) {
       try {
	       	response.contentType = ContentType.APPLICATION_JSON
	        
	        val pedidoRequest = body.fromJson(PedidoRequest)
	        val cliente = Repositories.clientes.searchById(pedidoRequest.cliente)
	       
	        val formaDeEnvio = pedidoRequest.formaDeEnvio.createFormaDeEnvio()
	        
	        val pedido = Repositories.pedidos.createPedido(cliente, formaDeEnvio)
			val platos = pedidoRequest.platos.map[
				val plato = it.createPlato(pedido)
				Repositories.platos.create(plato)
				plato
			]
			
			return ok()
		} catch(Exception e) { 
			return badRequest(e.toString)
		}
        
    }
    
    @Get("/pedidos/:id")
    def getPedido() {
        response.contentType = ContentType.APPLICATION_JSON

        val pedido = Repositories.pedidos.searchById(Integer.parseInt(id))
        
        if (pedido == null) {
            return notFound()
        } else {
        	val pedidoResponse = PedidoRequest.from(pedido)
            return ok(pedidoResponse.toJson)
        }
    }

}