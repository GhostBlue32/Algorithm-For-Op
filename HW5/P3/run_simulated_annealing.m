function [Vs, ds] = run_simulated_annealing(N, P, T)
  % This runs the simulated annealing algo to solve the traveling
  % salesman problem.
  
  % First create locations and info about the cities to visit.
  

  % Make plot of cities
  % figure(1)
  % h1 = plot(P(1,:), P(2,:), 'ro', 'MarkerFaceColor', 'r');
  % hold on
  % % Plot home city blue.
  % h2 = plot(P(1,1), P(2,1), 'bo', 'MarkerFaceColor', 'b');
  % title('City locations and initial path')

  % Names of cities to visit.  I just name them a, b, c, ....
  % The below is a tricky way to create the city names using
  % Matlab string conversion stuff.
  for i=1:N
    C{i} = char(i+96); 
  end
  %fprintf('Cities we will visit:')
  %disp(C)

        
  % Initial guess of order in which to visit cities
  % This is the C list but augmented at the end since we 
  % must return to the home city, 'a', at the end of traveling.
  V = horzcat(C, C(1));

  % Make plot of cities
  % figure(1)
  % h1 = plot(P(1,:), P(2,:), 'ro', 'MarkerFaceColor', 'r');
  % hold on
  % % Plot home city blue.
  % h2 = plot(P(1,1), P(2,1), 'bo', 'MarkerFaceColor', 'b');
  
  % Plot initial path
  % for i=1:(length(V)-1)
  %   j = get_idx(C, V(i));
  %   u = P(:,j);
  %   k = get_idx(C, V(i+1));
  %   v = P(:,k);
  %   h3 = plot([u(1),v(1)], [u(2),v(2)],'g');
  % end
  % title('City locations and initial traveling salesman path')

  
  % Compute travel distance for this visiting order of cities.
  dn = compute_travel_distance(C, V, T);
  ds = dn;   % Initialize smallest distance variable.
  Vs = V;
  
  fprintf('Initial visiting order')
  disp(V)
  idn = dn;  % Initial dn
  fprintf('Total initial travel distance = %f\n', idn)

  % Initial annealing temp and decrease rate
  Temp = 500;
  alpha = 0.95;
  
  
  % Now start algo -- outer loop over decreasing temps.
  for i=1:300
    
    % Inner loop over pairwise swapped distances.
    for m = 1:500
      % Chose a pair to swap at random
      is = randperm(N-1)+1;
      j = is(1);
      k = is(2);
      
      % Do swap using proposed list Vp
      Vp = V;
      Vp{j} = V{k};
      Vp{k} = V{j};
      
      % Compute travel distance for this new order of cities.
      dnp1 = compute_travel_distance(C, Vp, T);
      
      % Now decide whether to keep this permutation or not.
      if (dnp1 < dn)
	% Keep it in any event
	V = Vp;
	dn = dnp1;
      else
	% Make Metropolis random decision here -- choose random
	% number between [0,1] and then compare to activation energy.
	% As temp decreases the activation energy will decrease from
	% 1 to 0, so the probabiliy of accepting the permutation will
	% decrease over time.
	r = rand();                  % Random number between [0, 1]
	act = exp(-(dnp1-dn)/Temp);  % Activation energy between [0, 1]
	if (act > r)
	  % Accept this permutation -- keep new travel order.
	  V = Vp;
	  dn = dnp1;
	else
	  % Discard this permutation -- keep previous travel order.
	  V = V;
	  dn = dn;
	end
      end

      % Check if this is shortest observed so far and save the
      % path if it is.
      if (dn < ds)
	Vs = V;
	ds = dn;
      end
      
    end

  % End of inner loop.  Now decrease annealing temp.
  %fprintf('dn = %f, ds = %f, Temp = %f\n', dn, ds, Temp)
  Temp = alpha*Temp;
  end

  fprintf('Observed minimum visiting order')
  disp(Vs)
  %fprintf('Total initial travel distance = %f\n', idn)
  fprintf('At end, smallest observed travel distance = %f\n', ds)  
  fprintf('At end of annealing, optimized travel distance = %f\n', dn)

  % Make plot of cities
  % figure(2)
  % h1 = plot(P(1,:), P(2,:), 'ro', 'MarkerFaceColor', 'r');
  % hold on
  % % Plot home city blue.
  % h2 = plot(P(1,1), P(2,1), 'bo', 'MarkerFaceColor', 'b');
  % title('City locations and optimized paths')
  % 
  % % Make plot of shortest path found
  % for i=1:(length(Vs)-1)
  %   j = get_idx(C, Vs(i));
  %   u = P(:,j);
  %   k = get_idx(C, Vs(i+1));
  %   v = P(:,k);
  %   h3 = plot([u(1),v(1)], [u(2),v(2)],'g');
  % end
  
  % Make plot of path found by annealing
  % for i=1:(length(V)-1)
  %   j = get_idx(C, V(i));
  %   u = P(:,j);
  %   k = get_idx(C, V(i+1));
  %   v = P(:,k);
  %   h4 = plot([u(1),v(1)], [u(2),v(2)],'b');
  % end

  % ylim( [1.1*min(P(2,:)), 1.4*max(P(2,:))] );
  % %legend([h3,h4],'Shortest path','Annealed path')
  % legend([h3],'Shortest path')
  
end
  