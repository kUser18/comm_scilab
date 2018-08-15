function check(in1, in2)
	if type(in1) ~= type(in2) then
		error('check: The data types of the inputs don''t match.')
	end
	if or(type(in1)==[1, 4, 8]) then
		if size(in1) ~= size (in2) then
			error('check: The sizes of the inputs don''t match.')
		end
		n = length(in1)
		input_diff = in1 - in2
		avgDiff = sum(abs(input_diff))/n
		printf("Average Absolute Difference: %f\n", avgDiff)
		if avgDiff < 0.001 then
			disp('Passed!')
		else
			disp('Failed')
		end
	end
endfunction

getd

check([1,-1,6+8*%i],[1,-1,6+8*%i])

exit
