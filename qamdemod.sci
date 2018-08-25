function Q = qamdemod(x, m)
	//
		//Function Description
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
