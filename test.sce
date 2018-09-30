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

//The tests start
	//
		//pskmod tests
		disp("-----Running Tests for pskmod")
		//
			disp("  *Test 1: Two arguments")
			P = pskmod([0,1 ; 2,3], 4)
			P_octave = [1, %i ; -1, -%i]
			check(P, P_octave)
		//
			disp("  *Test 2: Initial Phase")
			P = pskmod([0,1 ; 2,3], 4, %pi/2)
			P_octave = [%i, -1 ; -%i, 1]
			check(P, P_octave)
		//
			disp("  *Test 3: Gray option")
			P = pskmod([0,1 ; 2,3], 4, %pi/2, 'Gray')
			P_octave = [%i, -1 ; 1, -%i]
			check(P, P_octave)
		//
		disp("-----Finished Running Tests for pskmod")
		//pskmod tests finished
	//
		//pskdemod tests
		disp("-----Running Tests for pskdemod")
		//
			disp("  *Test 1: Two arguments")
			P = pskdemod([1,-1 ; %i,-%i], 4)
			P_octave = [0, 2 ; 1, 3]
			check(P, P_octave)
		//
			disp("  *Test 2: Initial phase")
			P = pskdemod([1,-1 ; %i,-%i], 4, %pi/2)
			P_octave = [3, 1 ; 0, 2]
			check(P, P_octave)
		//
			disp("  *Test 3: Gray code case")
			P = pskdemod([1,-1 ; %i,-%i], 4, %pi/2, 'Gray')
			P_octave = [2, 1 ; 0, 3]
			check(P, P_octave)
		//
		disp("-----Finished Running Tests for pskdemod")
		//pskdemod tests finished
	//
		//qammod tests
		disp("-----Running Tests for qammod")
		//
			disp("  *Test 1: Four qam")
			P = qammod([0,1 ; 2,3], 4)
			P_octave = [-1+%i, -1-%i ; 1+%i, 1-%i]
			check(P, P_octave)
		//
		disp("-----Finished Running Tests for qammod")
		//qammod tests finished
	//
		//qamdemod tests
		disp("-----Running Tests for qamdemod")
		//
			disp("  *Test 1: Four qam")
			P = qammod([0,1 ; 2,3], 4)
			Q = qamdemod(P,4)
			Q_octave = [0,1;2,3]
			check(Q, Q_octave)
		//
		disp("-----Finished Running Tests for qamdemod")
		//qamdemod tests finished
	//
		//pammod tests
				disp("  *Test 1: Simple PAM modulation")
				P = pammod([0,1;2,3],4)
				P_octave = [-3,-1;1,3]
				check(P,P_octave)
			//
				disp("  *Test 2: PAM modulation with initial phase and Gray code")
				P = pammod([0,1,2,3;4,5,6,7],8,%pi/2,"Gray")
				P_octave = [7,5,1,3;-7,-5,-1,-3] * %i
				check(P,P_octave)
		//pammod tests finished
	//
		//pamdemod tests
				disp("  *Test 1: Simple PAM demodulation")
				P = pamdemod([-3,-1;1,3],4)
				P_octave = [0,1;2,3]
				check(P,P_octave)
			//
				disp("  *Test 2: PAM modulation with initial phase and Gray code")
				P = pamdemod([7,5,1,3;-7,-5,-1,-3] * %i,8,%pi/2,"Gray")
				P_octave = [0,1,2,3;4,5,6,7]
				check(P,P_octave)
		//pamdemod tests finished
	//
		//genqammod tests
				disp("  *Test 1: General QAM modulation")
				P = genqammod([0,1;2,3],[1,%i,-%i,-1])
				P_octave = [1,%i;-%i,-1]
				check(P,P_octave)
		//genqammod tests finished
	//
		//genqamdemod tests
				disp("  *Test 1: General QAM demodulation")
				P = genqamdemod([1,%i;-%i,-1],[1,%i,-%i,-1])
				P_octave = [0,1;2,3]
				check(P,P_octave)
		//genqammod tests finished
//The tests end

exit
