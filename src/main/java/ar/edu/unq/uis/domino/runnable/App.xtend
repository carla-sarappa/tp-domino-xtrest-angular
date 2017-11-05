package ar.edu.unq.uis.domino.runnable

import org.uqbar.xtrest.api.XTRest
import org.uqbar.commons.applicationContext.ApplicationContext
import ar.edu.unq.uis.domino.repo.Repositories
import ar.edu.unq.uis.domino.data.Fixture
import ar.edu.unq.uis.domino.server.DominoApi
import org.eclipse.jetty.servlet.ServletHandler
import org.eclipse.jetty.servlet.FilterHolder
import org.eclipse.jetty.servlet.FilterMapping

class App {
	def static void main(String[] args) {
		Repositories.init
		new Fixture().run

        XTRest.startInstance(9000, new DominoApi())
       
    }
 }