function signal = pamdemod(pam, m, phi, datatype)
	//
		//Function Description
		//pamdemod: This function demodulates a matrix of pam modulated
		//baseband signals (constellation points or complex numbers) into integers
		//
		//Calling sequence:-
		//signal = pamdemod(pam, m)
		//signal = pamdemod(pam, m, phi)
		//signal = pamdemod(pam, m, phi, datatype)
		//
		//Parameters:
		//pam: complex - matrix
		//	The matrix of pam signals to be demodulated.
		//m: int - scalar
		//	The total number of constellation points.
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
		//signal = pamdemod(pam, m)
		//
		//	Specifying the initial phase
		//signal = pamdemod(pam, m, phi)
		//
		//	Specifying the encoding
		//signal = pamdemod(pam, m, phi, datatype)
		//
		//Authors
		//Devdatta Kathale
		//
		//Function Description Ends
	//
		//Find dimension of pam, and store it
		pam_dim = size(pam)
		pam = matrix(pam, [1,-1] )
	//
		//Find the number of arguments, and act accordingly
		select(argn(2))
			case 0 then
				error('pamdemod: Need at least 2 arguments.')
			case 1 then
				error('pamdemod: Need at least 2 arguments.')
			case 2 then
				phi = 0
				datatype = "Bin"
				if m < ceil(m) | m<1 then
					error('pamdemod: m must be an integer greater than 0')
				end
			case 3 then
				datatype = "Bin"
				if m < ceil(m) | m<1 then
					error('pamdemod: m must be an integer greater than 0')
				end
			case 4 then
				if m < ceil(m) | m<1 then
					error('pamdemod: m must be an integer greater than 0')
				end
				if datatype == "Gray" | datatype == "gray" then
					//Convert gray coded x into binary
					//
						//Obtain Gray code of the integers 0:m-1
						binary = 0:m-1
						grayIndex=bitxor(binary, floor(binary/2))
					//
				elseif datatype == "Bin" | datatype == "bin" then //no need to change
					pam=pam
				else
					error("pamdemod: Type must be either ''Gray'' or ''Bin''.")
				end
		end
	//
		//Find the reference constellation
		L = pammod(0:m-1, m, phi)
	//
		//Compare against reference constellation, and return the symbol with minimum distance
		signal = zeros(pam)
		l = length(pam)
		for i = 1:l
			//Compute distance from each constellation point,
			//and choose the nearest one
			[dummy, signal(i)] = min( abs(pam(i) - L) )
		end
		signal = signal-1
	//
		//Gray code case
		if datatype == "Gray" | datatype == "gray" then
			signal = grayIndex(signal+1)
		end
	signal = matrix(signal, pam_dim)
endfunction
