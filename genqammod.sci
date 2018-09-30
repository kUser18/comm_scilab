function mod = genqammod(x, constellation)
	//
		//Function Description
		//genqammod: This function modulates a sequence of integers
		//x into a complex baseband signal, according to a specified constellation.
		//
		//Calling sequence:-
		//genqammod(x, constellation)
		//
		//Parameters:
		//x: int - matrix
		//	The sequence of integers to be modulated.
		//	Each integer in x should be in [0,length(constellation)-1]
		//constellation: complex - vector
		//	The constellation map to modulate x.
		//	Must be a vector of complex numbers.
		//
		//Example Usage
		//	mod = genqammod(0:4, [1, -1, %i, -%i])
		//
		//Authors
		//Devdatta Kathale
		//
		//Function Description Ends
	//
		//Check inputs
		if argn(2)~=2 then
			error('genqammod: This function takes exactly 2 arguments.')
		end
		if ~or(size(constellation)==1) then
			error('genqammod: The constellation must be a vector.')
		end
		if or(x>ceil(x)) | or(x<0) then
			error('genqammod: The entries of x must all be non-negative integers.')
		end
		if or(x+1>length(constellation)) then
			error('genqammod: The entries of x must all be in [0,length(constellation)-1].')
		end
	//
		//Flatten, assign values, and restore shape
		x_dim = size(x)
		x_flat = matrix(x, [-1,1] )
		mod = constellation(x_flat+1)
		mod = matrix(mod, x_dim)
	//
endfunction
