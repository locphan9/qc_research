% Initialize parameters
N = 4;
k = 4;
A = zeros(N, k);
A(1, 2) = -1;  % Initialize the first row of A

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
dt = 0.0001;
t = linspace(0, 10, 100001);
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

% Plot the results
figure;
plot(t, x_values);
xlabel('Time t');
ylabel('x(t)');
title('Solution using Matrix Exponential Method');
grid on;
