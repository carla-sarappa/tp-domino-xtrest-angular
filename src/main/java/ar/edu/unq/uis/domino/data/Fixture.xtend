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
		val calabresa = repoPizza.createPromo("Calabresa", 140.0)
		val napolitana = repoPizza.createPromo("Napolitana", 100.0)
		val margherita = repoPizza.createPromo("Margherita", 180.0)
		val cuatroQuesos = repoPizza.createPromo("Cuatro quesos", 190.0)
		val caprese = repoPizza.createPromo("Capresse", 150.0)
		val palmitos = repoPizza.createPromo("Palmitos", 120.0)
		val jamon = repoPizza.createPromo("Jamon y queso", 125.0)
		val jamonYmorrones = repoPizza.createPromo("Jamon y morrones", 130.0)
		val anana = repoPizza.createPromo("Anana", 135.0)
		
		
		val repoIngredientes = ApplicationContext.instance.getSingleton(typeof(Ingrediente)) as RepoIngredientes
		val aceitunas = repoIngredientes.createIngrediente("Aceitunas", 5.0)
		val jalapeño = repoIngredientes.createIngrediente("Jalapeño", 12.0)
		val anchoas = repoIngredientes.createIngrediente("Anchoas", 22.0)
	
		val tomateSeco = repoIngredientes.createIngrediente("Tomate seco", 6.0)
		val extraQueso = repoIngredientes.createIngrediente("Extra queso", 1.0)
		val jamonCrudo = repoIngredientes.createIngrediente("Jamon crudo", 3.0)
		val provoloneRallado = repoIngredientes.createIngrediente("Provolone rallado", 11.0)
		val salameRodajas = repoIngredientes.createIngrediente("Salame rodajas", 2.0)
				
		
		val repoDistribucion = ApplicationContext.instance.getSingleton(typeof(Distribucion)) as RepoDistribucion
		
		val todaLaPizza = repoDistribucion.createDistribucion("Toda la pizza")
		val mitadIzquierda = repoDistribucion.createDistribucion("Mitad izquierda")
		val mitadDerecha = repoDistribucion.createDistribucion("Mitad derecha")
		

		val aceitunasDistrib = new IngredienteDistribuido(aceitunas, todaLaPizza)
		val anchoasDistrib = new IngredienteDistribuido(anchoas, mitadIzquierda)		
		val jalapeñoDistrib = new IngredienteDistribuido(jalapeño, mitadDerecha)
		val tomateSecoDistrib = new IngredienteDistribuido(tomateSeco, todaLaPizza)
		val extraQuesoDistrib = new IngredienteDistribuido(extraQueso, todaLaPizza)
		val jamonCrudoDistrib = new IngredienteDistribuido(jamonCrudo, mitadIzquierda)
		val provoloneRalladoDistrib = new IngredienteDistribuido(provoloneRallado, mitadDerecha)
		val salameRodajasDistrib = new IngredienteDistribuido(salameRodajas, mitadIzquierda)
				
		
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
		
		val plato1pedido1 = repoPlato.createPlato(calabresa, Tamanio.FAMILIAR, pedido1)
		val plato1pedido2 = repoPlato.createPlato(napolitana, Tamanio.GRANDE, pedido2)
		val plato2pedido2 = repoPlato.createPlato(calabresa, Tamanio.CHICA, pedido2)
		val plato3pedido2 = repoPlato.createPlato(cuatroQuesos, Tamanio.PORCION, pedido2)
		val plato1pedido3 = repoPlato.createPlato(margherita, Tamanio.CHICA, pedido3)
		val plato1pedido4 = repoPlato.createPlato(napolitana, Tamanio.PORCION, pedido4)
		val plato1pedido5 = repoPlato.createPlato(cuatroQuesos, Tamanio.PORCION, pedido5)
		val plato1pedido6 = repoPlato.createPlato(cuatroQuesos, Tamanio.PORCION, pedido6)
		val plato2pedido6 = repoPlato.createPlato(cuatroQuesos, Tamanio.CHICA, pedido6)
		val plato1pedido7 = repoPlato.createPlato(cuatroQuesos, Tamanio.GRANDE, pedido7)
		val plato1pedido8 = repoPlato.createPlato(cuatroQuesos, Tamanio.CHICA, pedido8)
		val plato1pedido9 = repoPlato.createPlato(cuatroQuesos, Tamanio.PORCION, pedido9)
		val plato1pedido10 = repoPlato.createPlato(cuatroQuesos, Tamanio.FAMILIAR, pedido10)
		val plato1pedido11 = repoPlato.createPlato(margherita, Tamanio.FAMILIAR, pedido11)
		val plato1pedido12 = repoPlato.createPlato(napolitana, Tamanio.FAMILIAR, pedido12)
		plato1pedido12.agregarExtra(jalapeñoDistrib)
 		plato1pedido12.agregarExtra(tomateSecoDistrib)
		plato1pedido12.agregarExtra(extraQuesoDistrib)
		plato1pedido12.agregarExtra(jamonCrudoDistrib)
		plato1pedido12.agregarExtra(provoloneRalladoDistrib)
		plato1pedido12.agregarExtra(salameRodajasDistrib)
		plato1pedido12.agregarExtra(salameRodajasDistrib)
	
		}
	
	def minutos(int i) {
		i *60*1000 
	}
	
}