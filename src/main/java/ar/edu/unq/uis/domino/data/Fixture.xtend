package ar.edu.unq.uis.domino.data

import org.uqbar.commons.applicationContext.ApplicationContext
import ar.edu.unq.uis.domino.repo.RepoPizza
import org.uqbar.commons.applicationContext.ApplicationContext
import ar.edu.unq.uis.domino.model.Pizza
import ar.edu.unq.uis.domino.model.Ingrediente
import ar.edu.unq.uis.domino.repo.RepoIngredientes
import ar.edu.unq.uis.domino.model.Distribucion
import ar.edu.unq.uis.domino.repo.RepoDistribucion
import ar.edu.unq.uis.domino.model.Estado
import ar.edu.unq.uis.domino.repo.RepoPedido
import ar.edu.unq.uis.domino.model.Pedido
import ar.edu.unq.uis.domino.model.Cliente
import ar.edu.unq.uis.domino.model.Delivery
import ar.edu.unq.uis.domino.model.RetiraPorElLocal
import ar.edu.unq.uis.domino.model.Plato
import ar.edu.unq.uis.domino.repo.RepoPlato
import ar.edu.unq.uis.domino.model.Tamanio
import ar.edu.unq.uis.domino.repo.Repositories
import ar.edu.unq.uis.domino.repo.RepoCliente
import ar.edu.unq.uis.domino.model.GmailSender
import java.util.Date
import ar.edu.unq.uis.domino.model.Cancelado
import ar.edu.unq.uis.domino.model.Entregado
import ar.edu.unq.uis.domino.model.IngredienteDistribuido
import ar.edu.unq.uis.domino.model.ListoParaEnviar
import ar.edu.unq.uis.domino.model.EnViaje

class Fixture {
	def run() {
		val repoPizza = ApplicationContext.instance.getSingleton(typeof(Pizza)) as RepoPizza
		val calabresa = repoPizza.createPromo("Calabresa", 40.0)
		val napolitana = repoPizza.createPromo("Napolitana", 100.0)
		val margherita = repoPizza.createPromo("Margherita", 80.0)
		val cuatroQuesos = repoPizza.createPromo("Cuatro quesos", 20.0)
		
		repoPizza => [
			createPromo("Capresse", 15.0)
			createPromo("Palmitos", 20.0)
			createPromo("Jamon y queso", 25.0)
			createPromo("Jamon y morrones", 30.0)
			createPromo("Anana", 35.0)
		]
		
		val repoIngredientes = ApplicationContext.instance.getSingleton(typeof(Ingrediente)) as RepoIngredientes
		val aceitunas = repoIngredientes.createIngrediente("Aceitunas", 5.0)
		
		repoIngredientes => [
			createIngrediente("Tomate seco", 1.0)
			createIngrediente("Extra queso", 1.0)
			createIngrediente("Jamon crudo", 1.0)
			createIngrediente("Provolone rallado", 1.0)
			createIngrediente("Anchoas sueltas", 1.0)
			createIngrediente("Salame rodajas", 1.0)
		]
		
		
		val repoDistribucion = ApplicationContext.instance.getSingleton(typeof(Distribucion)) as RepoDistribucion
		
		repoDistribucion => [
			createDistribucion("Toda la pizza")
			createDistribucion("Mitad izquierda")
			createDistribucion("Mitad derecha")
		]
		
		val aceitunasDistrib = new IngredienteDistribuido(aceitunas, new Distribucion("Toda la pizza"))
		val anchoas = new Ingrediente("Anchoas", 22.0)
		val anchoasDistrib = new IngredienteDistribuido(anchoas, new Distribucion("Toda la pizza"))
		calabresa.agregarIngrediente(aceitunasDistrib)
		calabresa.agregarIngrediente(anchoasDistrib)
		napolitana.agregarIngrediente(aceitunasDistrib)
		margherita.agregarIngrediente(anchoasDistrib)
		cuatroQuesos.agregarIngrediente(aceitunasDistrib)		
		
		
		
		val repoCliente = ApplicationContext.instance.getSingleton(typeof(Cliente)) as RepoCliente
		repoCliente => [
			createCliente("carla11", "carla11@gmail.com", "Carla 11")
			createCliente("carla12", "carla12@gmail.com", "Carla 12")
			createCliente("Invitado", "Invitado", "Invitado")
		]		
				
		val carlaSarappa = repoCliente.createCliente("carla.sarappa","carla@hotmail.com", "Carla Sarappa")
		carlaSarappa.setPassword("1111")
		carlaSarappa.setDireccion("Mario Bravo 445, Avellaneda")
		val gisele = repoCliente.createCliente("escobargisele","escobargisele@gmail.com", "Gisele Escobar")
		gisele.setPassword("1111")
		gisele.setDireccion("Jujuy 1123, Cap. Fed.")
		
		val fede = repoCliente.createCliente("fede11","fede@fede.c", "Fede")
		val maria = repoCliente.createCliente("maria","maria@maria.com", "Maria Lopez")
	
		val repoPedido = ApplicationContext.instance.getSingleton(typeof(Pedido)) as RepoPedido
		val pedido1 = repoPedido.createPedido(carlaSarappa, new RetiraPorElLocal)
		pedido1.fecha = new Date(System.currentTimeMillis - minutos(40))
		val pedido2 = repoPedido.createPedido(gisele, new RetiraPorElLocal)
		pedido2.fecha = new Date(System.currentTimeMillis - minutos(20))
		val pedido3 = repoPedido.createPedido(fede, new RetiraPorElLocal)
		val pedido4 = repoPedido.createPedido(carlaSarappa, new Delivery("Calle Falsa 123"))
		val pedido5 = repoPedido.createPedido(maria, new RetiraPorElLocal)
		val pedido6 = repoPedido.createPedido(maria, new Delivery("Lebenshon 44"))
		
		val pedido7 = repoPedido.createPedido(gisele, new RetiraPorElLocal)
		pedido7.fecha = new Date("2017/09/22")
		pedido7.estado = new Cancelado
		
		
		val pedido8 = repoPedido.createPedido(carlaSarappa, new RetiraPorElLocal)
		pedido8.fecha = new Date("2017/09/27")
		pedido8.estado = new Entregado
		pedido8.fechaCerrado = new Date()
		
		val pedido9 = repoPedido.createPedido(gisele, new Delivery("Corrientes 949"))
		pedido9.fecha = new Date("2017/11/27")
		pedido9.estado = new ListoParaEnviar
		
		val pedido10 = repoPedido.createPedido(carlaSarappa, new Delivery("Rodriguez Pena 1889"))
		pedido10.fecha = new Date("2017/11/27")
		pedido10.estado = new EnViaje

		val pedido11 = repoPedido.createPedido(gisele, new Delivery("Colon 44"))
		pedido11.fecha = new Date("2017/11/27")
		pedido11.estado = new EnViaje
		
		val pedido12 = repoPedido.createPedido(carlaSarappa, new Delivery("Belgrano 399"))
		pedido12.fecha = new Date("2017/11/27")
		pedido12.estado = new ListoParaEnviar
		
		val repoPlato = ApplicationContext.instance.getSingleton(typeof(Plato)) as RepoPlato
		
		repoPlato => [
			createPlato(calabresa, Tamanio.FAMILIAR, pedido1)
			
			createPlato(napolitana, Tamanio.GRANDE, pedido2)
			createPlato(calabresa, Tamanio.CHICA, pedido2)
			createPlato(cuatroQuesos, Tamanio.PORCION, pedido2)
			
			createPlato(margherita, Tamanio.CHICA, pedido3)
			
			createPlato(napolitana, Tamanio.PORCION, pedido4)
			
			createPlato(cuatroQuesos, Tamanio.PORCION, pedido5)
			
			createPlato(cuatroQuesos, Tamanio.PORCION, pedido6)
			createPlato(cuatroQuesos, Tamanio.CHICA, pedido6)
			
			createPlato(cuatroQuesos, Tamanio.GRANDE, pedido7)
			createPlato(cuatroQuesos, Tamanio.CHICA, pedido8)
			createPlato(cuatroQuesos, Tamanio.PORCION, pedido9)
			createPlato(cuatroQuesos, Tamanio.FAMILIAR, pedido10)
			
			createPlato(margherita, Tamanio.FAMILIAR, pedido11)
			createPlato(napolitana, Tamanio.FAMILIAR, pedido12)
				
		]
	}
	
	def minutos(int i) {
		i *60*1000 
	}
	
}