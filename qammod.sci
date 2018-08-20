function Q = qammod(x, m)
	//
		//Function Description
		//Function Description Ends
	//
		//Check inputs
		if or(m<floor(m)) | or(m<1) then
			error('qammod: m must be a positive integer.')
		end
		k = log2(m)
		if k > floor(k) then
			error('qammod: M must be a square of a power of 2')
		end
		if or(x<0) | or(x>m-1) | or(x>floor(x)) then
			error('qammod: x must be a vector of integers in the range [0,M-1]')
		end
	//
		//Construct constellation
		n = sqrt(m)
		mymatrix = (0:n-1)'*ones(1,n) + %i*ones(n,1)*(0:n-1)
		mymatrix = mymatrix*2 - mymatrix($)
		constellation = mymatrix'
	//
		//Flatten, assign values, and restore shape
		x_dim = size(x)
		x_flat = matrix(x, [-1,1] )
		Q = constellation(x_flat+1)
		Q = matrix(Q, x_dim)
	//
endfunction
