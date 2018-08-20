//Function Description
	//randint: This function generates a matrix of random integers.
	//
	//Calling sequence:-
	//M = randint(n)
	//M = randint(n,m)
	//M = randint(n,m,myrange)
	//M = randint(n,m,myrange,seed)
	//
	//Parameters:
	//n: int - scalar
	//	Number of rows of the output matrix.
	//	Must be positive.
	//If m is not specified, m=n is assumed.
	//m: int - scalar
	//	Number of columns of the output matrix.
	//	Must be positive.
	//If myrange is not specified, it is taken 0:1.
	//myrange: int - scalar or vector
	//	If scalar and positive, the output matrix will consist of uniformly chosen random
	//	integers in [0,myrange] (both inclusive).  
	//	If scalar and negative, the output matrix will consist of uniformly chosen random
	//	integers in [myrange,0] (both inclusive).  
	//	If myrange is a vector of length 2, the output matrix will consist of uniformly
	//	chosen random integers in [myrange(1),myrange(2)], both inclusive. If myrange(2)<myrange(1),
	//	the entries are chosen from [myrange(2),myrange(1)], both inclusive.
	//seed: int - scalar
	//	Set the seed of the random number generator to the given value.
	//	Must be a positive value.
	//	The previous seed is saved, and restored before returning from this function.
	//
	//Special cases
	//If range is a scalar with value 0, an n x m matrix of zeros is returned.
	//
	//Example Usage
	//n=4
	//m=3
	//seed=0
	//myrange=[-8,19]
	//M = randint(n)
	//M = randint(n,m)
	//M = randint(n,m,myrange)
	//M = randint(n,m,myrange,seed)
	//
	//Authors
	//Devdatta Kathale
	//
//Function Description Ends

function b = isinteger(a)
	//
		//This is a utility function 
		//to check if the given argument
		//is an integer or not.
		//
		//Calling sequence:-
		//b = isinteger(a)
		//returns 1 if a is an integer
		//0 otherwise.
	//
		//The function
		if a==ceil(a) then b=1 // a==ceil(a) if and only if a is an integer
		else b=0
		end
	//
endfunction

function [M] = randint(n,m,myrange,seed)
	//Refer the top of the file for the description.

	//Count the number of input arguments, to process accordingly.
	select(argn(2)) //Check the input and throw errors for invalid inputs.
		case 0 then 
			error('randint: Too few arguments: need at least one, the value of n')
		case 1 then
			if (~isinteger(n)|n<0) then
				error('randint: n must be a positive integer')
			end
			m=n //Assume square matrix output if only one dimension is specified.
			myrange=0:1
		case 2 then
			if (~isinteger(n) | ~isinteger(m) | n<0 | m<0 ) then
				error('randint: n and m must be positive integers')
			end
			myrange=0:1
		case 3 then
			if (~isinteger(n) | ~isinteger(m) | n<0 | m<0 ) then
				error('randint: n and m must be positive integers')
			end
			if length(myrange)>2 | or(~isinteger(myrange))
				error('randint: Range should be a vector of integers, and its length must at most be 2.')
			end
		case 4 then
			if (~isinteger(n) | ~isinteger(m) | n<0 | m<0 ) then
				error('randint: n and m must be positive integers')
			end
			if length(myrange)>2 | or(~isinteger(myrange))
				error('randint: Range should be a vector of integers, and its length must at most be 2.')
			end
			if (~isinteger(seed) | seed<0)
				error('randint: seed should be a non-negative integer')
			end
			oldseed = grand('getsd')
			grand('setsd', seed) 
	end

	//Convert myrange to a 2-length vector for further operations.
	if length(myrange)==1
		if myrange<0 then
			myrange=[myrange+1,0]
		end
		if myrange>0 then
			myrange=[0,myrange-1]
		end
		//Handle the myrange==0 special case.
		if myrange==0 then
			M = zeros(n,m)
			return
		end
	end
	//Arrange myrange in ascending order.
	if myrange(1)>myrange(2) then
		myrange = [myrange(2),myrange(1)] 
	end

	//Generating the matrix as per the requirements.
	M = myrange(1) -1 + ceil( grand(n,m,'def') * ( myrange(2) - myrange(1) + 1 ) )
	if argn(2) == 4 then
		grand('setsd',oldseed) //Restore the old seed.
	end
endfunction

//Running tests
	//n=4
	//m=3
	//seed=67
	//myrange=[-8,19]
	//
	//disp('------')
	//disp('Tests:-')
	//disp('Test 1: With n=4')
	//M = randint(n); disp(M)
	//disp('------')
	//disp('Test 2: With n=4,m=3')
	//M = randint(n,m); disp(M)
	//disp('------')
	//disp('Test 3: With n=4,m=3,myrange=[-8,19]')
	//currSeed = grand('getsd')
	//M = randint(n,m,myrange); disp(M)
	//grand('setsd', currSeed)
	//disp('Resetting the seed to what it was in the beginning of Test 3.\nThis will be useful in Tests 4 and 5.')
	//disp('------')
	//disp('Test 4: With n=4,m=3,myrange=[-8,19],seed=67')
	//M = randint(n,m,myrange,seed); disp(M)
	//disp('------')
	//disp('Test 5: Generating the Test 3 again to check if the seed has been restored.')
	//disp('With n=4,m=3,myrange=[-8,19]')
	//M = randint(n,m,myrange); disp(M)
	//disp('------')
	//disp('Tests Complete.')
//Running tests finished
