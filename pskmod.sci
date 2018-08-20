function Psk = pskmod(x,m,phi,datatype)
	//
		//Function Description
		//pskmod: This function modulates a sequence of integers
		//x into a complex baseband phase shift keying signal.
		//
		//Calling sequence:-
		//Psk = pskmod(x,m)
		//Psk = pskmod(x,m,phi)
		//Psk = pskmod(x,m,phi,datatype)
		//
		//Parameters:
		//x: int - vector
		//	The sequence of integers to be modulated.
		//	Each entry must be in the range [0,m-1]
		//m: int - scalar
		//	The number of constellation points.
		//	Must be greater than or equal to 1.
		//phi is taken to be zero if not specified.
		//phi: float - scalar
		//	The initial phase (in radian) of the PSK signal.
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
		//	P = pskmod(0:7, 8)
		//
		//	Specifying the initial phase
		//	P = pskmod(0:7, 8, %pi)
		//
		//	Specifying the encoding
		//	P = pskmod(0:7, 8, %pi,'Gray')
		//
		//Authors
		//Devdatta Kathale
		//
		//Function Description Ends
	//
		//Flatten the matrix and store its dimensions
		x_dim = size(x)
		x = matrix(x, [-1,1] )
	//
		//Find the number of arguments, and act accordingly
		select(argn(2))
			case 0 then
				error('pskmod: Need at least 2 arguments.')
			case 1 then
				error('pskmod: Need at least 2 arguments.')
			case 2 then
				phi = 0
				datatype = "Bin"
				if m < ceil(m) | m<1 then
					error('pskmod: m must be an integer greater than 0')
				end
				if or(x>m-1) | or(x-ceil(x)) then
					error('pskmod: x must be a vector of integers in the range [0,M-1]')
				end
			case 3 then
				datatype = "Bin"
				if m < ceil(m) | m<1 then
					error('pskmod: m must be an integer greater than 0')
				end
				if or(x>m-1) | or(x-ceil(x)) then
					error('pskmod: x must be a vector of integers in the range [0,M-1]')
				end
			case 4 then
				if m < ceil(m) | m<1 then
					error('pskmod: m must be an integer greater than 0')
				end
				if or(x>m-1) | or(x-ceil(x)) then
					error('pskmod: x must be a vector of integers in the range [0,M-1]')
				end
				if datatype == "Gray" | datatype == "gray" then
					//Convert gray coded x into binary
					//
						//Obtain Gray code of the integers 0:m-1
						binary = 0:m-1
						grayIndex=bitxor(binary, floor(binary/2))+1
					//
						//Obtain the inverse Gray code in inverseGrayIndex
						[dummy,inverseGrayIndex] = gsort(grayIndex, 'g', 'i')
						inverseGrayIndex = inverseGrayIndex - 1
					//
						//Convert x into binary from gray code
						x = inverseGrayIndex(x+1)
				elseif datatype == "Bin" | datatype == "bin" then //no need to change
					x=x
				else
					error("Type must be either ''Gray'' or ''Bin''.")
				end
		end
	//
		//Find the complex phase exponents
		phase = (%i * 2*%pi * 1.0/m)
		phaseVector = phase * (0:(m-1))
		phaseVector = phaseVector + (%i * phi)
		phaseVector = exp(phaseVector)
	//
		//Perform modulation by looking up from phaseVector
		Psk = phaseVector(x+1)
		Psk = matrix(Psk, x_dim)
	//
endfunction
