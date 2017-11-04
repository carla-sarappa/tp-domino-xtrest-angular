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
import ar.edu.unq.uis.domino.data.LoginRequest
import ar.edu.unq.uis.domino.model.Cliente
import ar.edu.unq.uis.domino.exceptions.BusinessException
import javax.servlet.http.HttpServletResponse
import org.uqbar.xtrest.api.Result
import ar.edu.unq.uis.domino.data.SignupRequest

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
    
    @Post("/login")
    def login(@Body String body){
    	
    	execute(response)[
    		val loginRequest = body.fromJson(LoginRequest)
	        val cliente = Repositories.clientes.findByNick(loginRequest.username)
			
			precondition (cliente != null, "No existe usuario registrado")
			precondition(loginRequest.password == cliente.password, "Contraseña incorrecta")
			
			return ok()
    	]         
    }
    
    def precondition(Boolean condicion, String error){
    	if (!condicion){
    		throw new BusinessException(error)
    	}
    }
    
    def execute(HttpServletResponse response, () => Result bloque){
    	try {
	       	response.contentType = ContentType.APPLICATION_JSON
	       	return bloque.apply
			
		} catch(BusinessException e) {
			return badRequest(e.toJson)
		} catch(Exception e) { 
			return internalServerError(e.toJson)
		}
		
    }
    
	@Post("/usuarios")
    def signup(@Body String body){
    	
    	execute(response)[
    		val signupRequest = body.fromJson(SignupRequest)
	        val cliente = Repositories.clientes.createCliente(signupRequest.username,signupRequest.nombre,signupRequest.email)
	      
	        cliente.setPassword(signupRequest.password)
	        cliente.setDireccion(signupRequest.direccion)
			
			return ok()
    	]         
    }

}