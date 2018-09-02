function P = pammod(x, m, phi, datatype)
	//
		//Function Description
		//pammod: This function modulates a sequence of integers
		//x into a complex baseband phase amplitude modulation signal.
		//
		//Calling sequence:-
		//pam = pammod(x,m)
		//pam = pammod(x,m,phi)
		//pam = pammod(x,m,phi,datatype)
		//
		//Parameters:
		//x: int - matrix
		//	The sequence of integers to be modulated.
		//	Each entry must be in the range [0,m-1]
		//m: int - scalar
		//	The number of constellation points.
		//	Must be greater than or equal to 1.
		//phi is taken to be zero if not specified.
		//phi: float - scalar
		//	The initial phase (in radian) of the PAM signal.
		//datatype is assumed to be "Bin" if not specified.
		//datatype: string
		//	Should be either "Bin", "bin", "Gray" or "gray"
		//	If "Bin" or "bin", then the encoding of the signal is assumed
		//	to be binary.
		//	If "Gray" or "gray", then the signal is assumed to be
		//	Gray coded, and is converted to binary before
		//	modulation.
		//
		//Example Usage
		//	Using only the signal and the number of constellation points
		//	P = pammod(0:7, 8)
		//
		//	Specifying the initial phase
		//	P = pammod(0:7, 8, %pi)
		//
		//	Specifying the encoding
		//	P = pammod(0:7, 8, %pi,'Gray')
		//
		//Authors
		//Devdatta Kathale
		//
		//Function Description Ends
	//
		//Find the number of arguments, and act accordingly
		select(argn(2))
			case 0 then
				error('pammod: Need at least 2 arguments.')
			case 1 then
				error('pammod: Need at least 2 arguments.')
			case 2 then
				phi = 0
				datatype = "Bin"
				if m < ceil(m) | m<1 then
					error('pammod: m must be an integer greater than 0')
				end
				if or(x>m-1) | or(x-ceil(x)) then
					error('pammod: x must be a vector of integers in the range [0,M-1]')
				end
			case 3 then
				datatype = "Bin"
				if m < ceil(m) | m<1 then
					error('pammod: m must be an integer greater than 0')
				end
				if or(x>m-1) | or(x-ceil(x)) then
					error('pammod: x must be a vector of integers in the range [0,M-1]')
				end
			case 4 then
				if m < ceil(m) | m<1 then
					error('pammod: m must be an integer greater than 0')
				end
				if or(x>m-1) | or(x-ceil(x)) then
					error('pammod: x must be a vector of integers in the range [0,M-1]')
				end
				if datatype == "Gray" | datatype == "gray" then
					//Convert gray coded x into binary
						//Store the shape of x
						x_dim = size(x)
						x = matrix(x, [-1,1] )
					//
						//Obtain Gray code of the integers 0:m-1
						binary = 0:m-1
						grayIndex=bitxor(binary, floor(binary/2))
					//
						//Obtain the inverse Gray code in inverseGrayIndex
						[dummy,inverseGrayIndex] = gsort(grayIndex, 'g', 'i')
						inverseGrayIndex = inverseGrayIndex - 1
					//
						//Convert x into binary from gray code
						x = inverseGrayIndex(x+1)
					//
						//Restore the shape of x
						x = matrix(x, x_dim)
				elseif datatype == "Bin" | datatype == "bin" then //no need to change
					x=x
				else
					error("pammod: Type must be either ''Gray'' or ''Bin''.")
				end
		end
	//
		//Construct constellation
		constellation = [-m+1:2:m-1] * exp(-%i * phi)
	//
		//Flatten, assign values, and restore shape
		x_dim = size(x)
		x_flat = matrix(x, [-1,1] )
		P = constellation(x_flat+1)
		P = matrix(P, x_dim)
	//
endfunction
