package ar.edu.unq.uis.domino.data

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ErrorResponse {
	String error
	
	
	new(String error){
		this.error = error
	}
}