function Q = qamdemod(x, m)
	//
		//Function Description
		//qamdemod: This function demodulates a matrix of qam modulated
		//baseband signals (constellation points or complex numbers) into integers
		//
		//Calling sequence:-
		//signal = qamdemod(qam, m)
		//
		//Parameters:
		//qam: complex - matrix
		//	The matrix of qam signals to be demodulated.
		//m: int - scalar
		//	The total number of constellation points.
		//	Must be greater than or equal to 1.
		//	Must be an even power of 2.
		//
		//Example Usage
		//signal = qamdemod(qam, m)
		//
		//Authors
		//Devdatta Kathale
		//
		//Function Description Ends
	//
		//Check inputs
		if or(m<floor(m)) | or(m<1) then
			error('qamdemod: m must be a positive integer.')
		end
		k = log2(m)
		if k > floor(k) then
			error('qamdemod: M must be a square of a power of 2')
		end
	//
		//Make qammod constellation for lookup
		L = qammod((0:m-1)', m)
	//
		//Flatten, assign values, and restore shape
		x_dim = size(x)
		x_flat = matrix(x, [-1,1] )
		Q = zeros(x_flat)
		l = length(x_flat)
		for i = 1:l
			//Compute distance from each constellation point,
			//and choose the nearest one
			[dummy, Q(i)] = min( abs(x_flat(i) - L) )
		end
		Q = Q-1
		Q = matrix(Q, x_dim)
	//
endfunction
