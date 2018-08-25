function P = pammod(x, m, phi, datatype)
	//
		//Function Description
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
