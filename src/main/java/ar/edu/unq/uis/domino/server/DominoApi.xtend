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
import org.uqbar.xtrest.api.annotation.Put

/**
 * Servidor RESTful implementado con XtRest.
 */
@Controller
class DominoApi {
    extension JSONUtils = new JSONUtils
    
    new() {    
    }


    @Get("/promos")
    def getPromos() {
    	execute(response)[  ok(Repositories.pizzas.allInstances.toJson) ]
    }
    
    @Get("/tamanios")
    def getTamanios() {
        execute(response)[  ok(Tamanio.tamanios.toJson) ]
    }
    
    @Get("/ingredientes")
    def getIngredientes() {
        execute(response)[  ok(Repositories.ingredientes.allInstances.toJson) ]
    }
    
    @Post("/pedidos")
    def postPedido(@Body String body) {
       execute(response)[
	        
	        val pedidoRequest = body.fromJson(PedidoRequest)
	        
	        val cliente = if (pedidoRequest.cliente != null) { 
	        		Repositories.clientes.searchById(pedidoRequest.cliente)
	        		} else {
	        			Repositories.clientes.findByNick("Invitado")
	        		}
	     
	       
	        val formaDeEnvio = pedidoRequest.formaDeEnvio.createFormaDeEnvio()
	        
	        val pedido = Repositories.pedidos.createPedido(cliente, formaDeEnvio)

			pedidoRequest.platos
				.map[it.createPlato(pedido)]
				.forEach [ Repositories.platos.create(it) ]
			
			return ok(PedidoRequest.from(pedido).toJson)
		]
    }
    
    @Get("/pedidos")
    def getPedidos(){
    	execute(response)[     	
    		try {
    			val pedidos = if (request.getParameter("userId") != null){
	    			val cliente = Repositories.clientes.searchById(Integer.parseInt(request.getParameter("userId")))
	    			Repositories.pedidos.historial(cliente)
       			} else {
       				Repositories.pedidos.allInstances
       			}
       			
				val filtrados = if (request.getParameter("estado") != null){
	    				pedidos.filter[it.hasEstado(request.getParameter("estado") )]
	      			} else {
       					pedidos
       				}
       			return ok(filtrados.map[PedidoRequest.from(it)].toList.toJson)
       			
    		} catch(NumberFormatException e) {
    			return ok([].toJson)
    		}
		]
    }
    
    //    			val estado = request.getParameter("estado")
    
 
    
    @Get("/pedidos/:id")
    def getPedido() {
        execute(response)[  
	        val pedido = Repositories.pedidos.searchById(Integer.parseInt(id))
	        
	        if (pedido == null) {
	            return notFound()
	        } else {
	        	val pedidoResponse = PedidoRequest.from(pedido)
	            return ok(pedidoResponse.toJson)
	        }
        ]
    }
    
    @Post("/login")
    def login(@Body String body){
    	
    	execute(response)[
    		val loginRequest = body.fromJson(LoginRequest)
	        val cliente = Repositories.clientes.findByNick(loginRequest.username)
			
			precondition (cliente != null, "No existe usuario registrado")
			precondition(loginRequest.password == cliente.password, "Contraseña incorrecta")
			
			return ok(cliente.toJson)
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
    
    @Get("/usuarios/:id")
    def getUsuario(){
    	execute(response)[
        	val cliente = Repositories.clientes.searchById(Integer.parseInt(id))
			return ok(cliente.toJson)
    	]  
    }
    
    @Put("/usuarios/:id")
    def editarUsuario(@Body String body){
    	execute(response)[
    		val signupRequest = body.fromJson(SignupRequest)
    		
        	val cliente = Repositories.clientes.searchById(Integer.parseInt(id))
        	val clienteExistente = Repositories.clientes.findByEmail(signupRequest.email)
        	
        	precondition (clienteExistente == null || clienteExistente.id == cliente.id,  "Ya existe usuario registrado con ese email")
        	
        	cliente.setNombre(signupRequest.nombre)
        	cliente.setEmail(signupRequest.email)
        	cliente.setDireccion(signupRequest.direccion)
        	
        	return ok(cliente.toJson)
    	]
    }

}