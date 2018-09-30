function M = randsrc(n,m,alpha,prob,seed)
	//
		//Function Description
		//randsrc: This function generates a matrix of random symbols.
		//
		//Calling sequence:-
		//M = randsrc()
		//M = randsrc(n)
		//M = randsrc(n,m)
		//M = randsrc(n,m,alpha)
		//M = randsrc(n,m,alpha,prob)
		//M = randsrc(n,m,alpha,prob,seed)
		//
		//Parameters:
		//n: int - scalar
		//	Number of rows of the output matrix.
		//	Must be positive.
		//If m is not specified, m=n is assumed.
		//m: int - scalar
		//	Number of columns of the output matrix.
		//	Must be positive.
		//If alpha is not specified, it is taken [-1,1].
		//alpha: int or float - vector
		//	alpha represents the alphabet to be used.
		//	If alpha has a single row, the elements of that row are treated as alphabets.
		//	Each entry of the output matrix could be any of the alphabets, with equal probability.
		//	If alpha has two rows, the elements of the first row are treated as the alphabets.
		//	The elements of the second row are treated as the probability of the corresponding alphabets in the first row.
		//prob: probability of each of the symbols in alpha
		//	If not specified, is taken as a vector of the same length as alpha, and each entry 1/length(alpha)
		//	The length of prob must be exactly the same as that of alpha.
		//	The entries in prob must sum to 1, and must lie between [0,1].
		//seed: int - scalar
		//	Set the seed of the random number generator to the given value.
		//	Must be a positive value.
		//	The previous seed is saved, and restored before returning from this function.
		//
		//Example Usage
		//n=4
		//m=3
		//alphabets=[51,56,57]
		//probabilities=[0.1,0.3,0.6]
		//seed=8
		//
		//M = randsrc(n)
		//By specifying only one argument, n, an n x n square matrix is created.
		//Each entry is -1 or 1 with equal probability.
		//
		//M = randsrc(n,m)
		//By specifying only two arguments, n and m, an n x m matrix is created.
		//Each entry is -1 or 1 with equal probability.
		//
		//M = randsrc(n,m,alphabets)
		//By specifying alphabets as a vector, an n x m matrix is created.
		//Each entry is from the vector alphabet, chosen independently with equal probability.
		//
		//M = randsrc(n,m,alphabets,probabilities)
		//By specifying a vector of probabilities for each of the corresponding alphabets.
		//
		//M = randsrc(n,m,alphabets,probabilities,seed)
		//The last argument may be used to specify the seed for random number generation.
		//
		//Special case
		//In case no arguments are given, n=m=1 is chosen.
		//
		//Authors
		//Devdatta Kathale
		//
		//Description ends
	//
	select(argn(2)) //Select the action according to number of input arguments.
		case 0 then //Special case: 0 arguments
			n=1
			m=1
			alpha=[-1,1]
			prob=[0.5,0.5]
		case 1 then //Only one argument specified.
			//n<ceil(n) if and only if n is not an integer.
			if n<ceil(n) | n<1 then
				error('randsrc: The number of rows n must be a positive integer.')
			end
			//Output a square matrix, m=n
			m=n
			//Defaults: The alphabet is [-1,1], and the probabilities [0.5,0.5].
			alpha=[-1,1]
			prob=[0.5,0.5]
		case 2 then //Two arguments to specify dimensions of the matrix.
			//n<ceil(n) if and only if n is not an integer.
			//m<ceil(m) if and only if m is not an integer.
			if n<ceil(n) | m<ceil(m) | n<1 | m<1 then
				error('randsrc: The number of rows n and columns m must be positive integers.')
			end
			//Defaults: The alphabet is [-1,1], and the probabilities [0.5,0.5].
			alpha=[-1,1]
			prob=[0.5,0.5]
		case 3 then //The alphabet is also specified.
			//n<ceil(n) if and only if n is not an integer.
			//m<ceil(m) if and only if m is not an integer.
			if n<ceil(n) | m<ceil(m) | n<1 | m<1 then
				error('randsrc: The number of rows n and columns m must be positive integers.')
			end
			[nr, nc] = size(alpha)
			if nr>1 then
				error('randsrc: alpha should be a vector with exactly one row.')
			end
			prob = ones(1,nc)/nc
		case 4 then //The probability is also specified.
			//n<ceil(n) if and only if n is not an integer.
			//m<ceil(m) if and only if m is not an integer.
			if n<ceil(n) | m<ceil(m) | n<1 | m<1 then
				error('randsrc: The number of rows n and columns m must be positive integers.')
			end
			[nr, nc] = size(alpha)
			if nr>1 then
				error('randsrc: alpha should be a vector with exactly one row.')
			end
			if size(alpha)~=size(prob) then
				error('randsrc: prob and alpha must have the same size.')
			end
			if sum(prob)~=1 then
				error('randsrc: Entries of prob must sum to 1.')
			end
			if or(prob<0) then
				error('randsrc: Entries of prob must be non-negative.')
			end
		case 5 then //The seed is also specified.
			//n<ceil(n) if and only if n is not an integer.
			//m<ceil(m) if and only if m is not an integer.
			if n<ceil(n) | m<ceil(m) | n<1 | m<1 then
				error('randsrc: The number of rows n and columns m must be positive integers.')
			end
			[nr, nc] = size(alpha)
			if nr>1 then
				error('randsrc: alpha should be a vector with exactly one row.')
			end
			if size(alpha)~=size(prob) then
				error('randsrc: prob and alpha must have the same size.')
			end
			if sum(prob)~=1 then
				error('randsrc: Entries of prob must sum to 1.')
			end
			if or(prob<0) then
				error('randsrc: Entries of prob must be non-negative.')
			end
			if seed<0 | seed<ceil(seed) then
				//Check the seed value to confirm if it is a positive integer.
				error('randsrc: Seed should be non-negative integer.')
			end
			//Store the old seed. It has to be restored later.
			oldseed = grand('getsd')
			grand('setsd',seed)
	end
	//
		//Compute Cumulative Probabilities
		cumulProb = zeros(prob)
		for i = 2:length(prob)
			cumulProb(i)=cumulProb(i-1)+prob(i-1)
		end
		cumulProb = [cumulProb,1]
		//The cumulative probabilites mark the start and end points of the
		//slabs we have split [0,1) into.
		//Generate the matrix, and fill in the alphabet
		G=grand(n*m,1,'def')
	//
		//Generate a matrix whose elements are uniformly distributed in [0,1).
		M=ones(n*m,1)*%nan
		//M is the output matrix. Initializing it to NaN so that unprocessed entries are easy to detect.
		for i = 2:length(cumulProb)
			indices = (G>cumulProb(i-1) & G<=cumulProb(i))
			M(indices) = (i-1)
			//Check in which slab the generated numbers lie.
			//Assign the alphabet values accordingly.
		end
		M = alpha(M)
	//
	//Reshape M appropriately.
	M=matrix(M,n,m)
	//
	if argn(2) == 5 then //If seed altered, restore the old one.
		grand('setsd',oldseed)
	end
	//
endfunction

	//Running tests
//		disp('Running Tests to Check Basic Outputs')
//		disp('------Test 1')
//		disp('M = randsrc(4); one input case')
//		M = randsrc(4); disp(M)
//		disp('------Test 2')
//		disp('M = randsrc(4,3); two input case')
//		M = randsrc(4,3); disp(M)
//		disp('------Test 3')
//		disp('M = randsrc(4,3,[51,56,57]); alphabet specified')
//		M = randsrc(4,3,['a','b','c']); disp(M)
//		disp('------Test 4')
//		disp('M = randsrc(4,3,[51,56,57],[0.1,0.3,0.6]); alphabet specified with probabilities')
//		currSeed = grand('getsd')
//		M = randsrc(4,3,[51,56,57],[0.1,0.3,0.6]); disp(M)
//		printf('Resetting the seed to what it was at the beginning of this test.\n')
//		grand('setsd',currSeed)
//		disp('This will be useful for Test 5 and Test 6.')
//		disp('------Test 5')
//		disp('M = randsrc(4,3,[51,56,57],[0.1,0.3,0.6],8); seed specified')
//		M = randsrc(4,3,[51,56,57],[0.1,0.3,0.6],8); disp(M)
//		disp('------Test 6')
//		disp('Test to see if the seed is being restored.')
//		disp('The output should be exactly same as the output of Test 4')
//		disp('M = randsrc(4,3,[51,56,57],[0.1,0.3,0.6]); check for seed restored')
//		M = randsrc(4,3,[51,56,57],[0.1,0.3,0.6]); disp(M)
//		disp('------')
//		disp('Finished Running Tests to Check Basic Outputs')
//		disp('************')
	//
//		disp('Test to check probability')
//		n=1000
//		printf("%d matrices of size 2 x 2 will be generated.',n)
//		p=0.7
//		printf('\n%f Probability of getting 1 at any entry\n',p)
//		disp('alpha=[1,0;p,1-p]')
//		M = zeros(2,2)
//		alpha=[1,0]
//		prob=[p,1-p]
//		disp(alpha)
//		for i = 1:n
//			M = M + randsrc(2,2,alpha,prob)
//		end
//		M = M/n
//		printf('Averaging over all generated matrices.\n')
//		printf('The value of all entries in the matrix below should be close to %f.\n',p)
//		disp(M)
//		disp('Tests Complete')
	//
//	exit
