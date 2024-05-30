function carleman_comparison
    % Parameters
    y0 = 1;  % Initial condition
    t0 = 0;  % Initial time
    tf = 10; % Final time
    dt = 0.001;  % Time step to reduce memory usage
    t_points = 10001;  % Number of time points for a manageable size

    % Solve the ODE using ode45
    [t_ode, y_ode] = ode45(@ode_function, linspace(t0, tf, t_points), y0);

    % Initialize parameters for Carleman solution
    N = 4;
    k = 4;
    A = zeros(k);
    A(1, 2) = -0.03;  % Initialize the first row of A
    A(1,1) = 1
    % Construct matrix A according to the given logic
    for i = 2:N
        for j = 1:k
            if j - i >= 0
                A(i, j) = A(1, j - i + 1) + A(i - 1, j - 1);
            end
        end
    end

    % Convert A to a matrix and perform the operations
    A = double(A);
    t = linspace(t0, tf, t_points);
    x = 1;  % Initial condition
    inversed_matrix = inv(eye(4) - A * dt);  % Inverse matrix computation

    % Preallocate x array for efficiency
    x_values = zeros(size(t));
    x_values(1) = x;

    % Iterative solution
    for i = 2:length(t)
        X = [x, x^2, x^3, x^4]';  % Current state vector
        x_new = inversed_matrix * X;
        x = x_new(1);  % Update x with the first element of the resulting vector
        x_values(i) = x;
    end

    % Compute the error between Carleman solution and ode45 solution
    y_carleman = x_values(:);  % Ensure column vector
    error = abs(y_carleman - interp1(t_ode, y_ode, t));  % Interpolate ode45 solution to match Carleman solution time points

    % Sum of the absolute error
    sum_error = sum(error);

    % Display the sum of the error
    fprintf('Sum of the absolute error: %f\n', sum_error);

    % Plot the results
    figure;
    plot(t, y_carleman, 'r', 'DisplayName', 'Carleman Solution');
    hold on;
    plot(t_ode, y_ode, 'b--', 'DisplayName', 'ODE45 Solution');
    xlabel('Time t');
    ylabel("y(t)");
    legend();
    title("Logistic Equation dy/dt = y - 0.03y^2");
    grid on;
end

% Define the differential equation dy/dt = -y + y^2
function dydt = ode_function(~, y)
    dydt = y - 0.03*y^2;
end
