function check(in1, in2, tolerance)
	if argn(2) == 2 then
		tolerance = 0.001
	end
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
		if avgDiff < tolerance then
			disp('Passed!')
		else
			disp('Failed')
			printf("Average Absolute Difference: %f\n", avgDiff)
		end
	end
endfunction

getd

//The tests
	//
		//pskmod tests
		disp("-----Running Tests for pskmod")
		//
			disp("  *Test 1: Two arguments")
			P = pskmod(matrix([0,1 ; 2,3],-1,2), 4)
			P_octave = [1, %i ; -1, -%i]
			check(P, P_octave)
		//
			disp("  *Test 2: Initial Phase")
			P = pskmod(matrix([0,1 ; 2,3],-1,2), 4, %pi/2)
			P_octave = [%i, -1 ; -%i, 1]
			check(P, P_octave)
		//
			disp("  *Test 3: Gray option")
			P = pskmod(matrix([0,1 ; 2,3],-1,2), 4, %pi/2, 'Gray')
			P_octave = [%i, -1 ; 1, -%i]
			check(P, P_octave)
		//
		disp("-----Finished Running Tests for pskmod")
		//pskmod tests finished
	//
		//
	//

exit
