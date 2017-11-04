package ar.edu.unq.uis.domino.data

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class SignupRequest {
	String username
	String password
	String nombre
	String email
	String direccion	
}