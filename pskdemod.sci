function signal = pskdemod(psk, m, phi, datatype)
	//
		//Function Description
		//pskdemod: This function demodulates a matrix of psk modulated
		//baseband signals (constellation points or complex numbers) into integers.
		//
		//Calling sequence:-
		//signal = pskdemod(psk, m)
		//signal = pskdemod(psk, m, phi)
		//signal = pskdemod(psk, m, phi, datatype)
		//
		//Parameters:
		//psk: complex - matrix
		//	The matrix of psk signals to be demodulated.
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
		//signal = pskdemod(psk, m)
		//
		//	Specifying the initial phase
		//signal = pskdemod(psk, m, phi)
		//
		//	Specifying the encoding
		//signal = pskdemod(psk, m, phi, datatype)
		//
		//Authors
		//Devdatta Kathale
		//
		//Function Description Ends
	//
		//Find the number of arguments, and act accordingly
		select(argn(2))
			case 0 then
				error('pskdemod: Need at least 2 arguments.')
			case 1 then
				error('pskdemod: Need at least 2 arguments.')
			case 2 then
				phi = 0
				datatype = "Bin"
				if m < ceil(m) | m<1 then
					error('pskdemod: m must be an integer greater than 0')
				end
			case 3 then
				datatype = "Bin"
				if m < ceil(m) | m<1 then
					error('pskdemod: m must be an integer greater than 0')
				end
			case 4 then
				if m < ceil(m) | m<1 then
					error('pskdemod: m must be an integer greater than 0')
				end
				if datatype == "Gray" | datatype == "gray" then
					//Convert gray coded x into binary
					//
						//Obtain Gray code of the integers 0:m-1
						binary = 0:m-1
						grayIndex=bitxor(binary, floor(binary/2))
					//
				elseif datatype == "Bin" | datatype == "bin" then //no need to change
					x=x
				else
					error("pskdemod: Type must be either ''Gray'' or ''Bin''.")
				end
		end
	//
		//Find the complex phase exponents
		unitPhase = (2*%pi * 1.0/m)
	//
		//Compute the argument of the inputs, and round to the nearest psk phase
		psk_dim = size(psk)
		[phase, mag] = phasemag(psk)
		phase = phase * %pi/180
		phase = phase - phi
		phase = phase + unitPhase/2
		phase(phase<0) = phase(phase<0)+2*%pi
		phase = phase / unitPhase
		phase = floor(phase)
		signal = phase
	//
		//Gray code case
		if datatype == "Gray" | datatype == "gray" then
			signal = grayIndex(signal+1)
		end
	signal = matrix(signal, psk_dim)
endfunction
