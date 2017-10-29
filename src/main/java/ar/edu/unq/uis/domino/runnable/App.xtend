package ar.edu.unq.uis.domino.runnable

import org.uqbar.xtrest.api.XTRest
import ar.edu.unq.uis.domino.server.Server
import org.uqbar.commons.applicationContext.ApplicationContext
import ar.edu.unq.uis.domino.repo.Repositories
import ar.edu.unq.uis.domino.data.Fixture

class App {
	def static void main(String[] args) {
		Repositories.init
		new Fixture().run

        XTRest.startInstance(9000, new Server())
    }
 }