function signal = genqamdemod(mod, constellation)
	//
		//Function Description
		//genqamdemod: This function demodulates a matrix of complex baseband signals
		//into a matrix of integers, according to a specified constellation.
		//
		//Calling sequence:-
		//genqamdemod(mod, constellation)
		//
		//Parameters:
		//mod: complex - matrix
		//	The matrix of complex baseband signals to be demodulated.
		//constellation: complex - vector
		//	The constellation map to modulate x.
		//	Must be a vector of complex numbers.
		//
		//Example Usage
		//	signal = genqamdemod([1, %i; -1, -%i], [1, -1, %i, -%i])
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
	//
		//Flatten, assign values, and restore shape
		mod_dim = size(mod)
		mod_flat = matrix(mod, [-1,1] )
		signal = zeros(mod_flat)
		l = length(mod_flat)
		for i = 1:l
			//Compute distance from each constellation point,
			//and choose the nearest one
			[dummy, signal(i)] = min( abs(mod_flat(i) - constellation) )
		end
		signal = signal-1
		signal = matrix(signal, mod_dim)
	//
endfunction
