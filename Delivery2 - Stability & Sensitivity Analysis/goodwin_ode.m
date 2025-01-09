function [y,t] = goodwin_ode(x)

    % x = [nu, alpha, beta, delta, phi0, phi1, omega0, lambda0, y0]
    
    % Time vector for integration
    t = 0:0.01:10;  % Shortened time span for debugging purposes
    
    % Initial conditions for omega and lambda (x(7), x(8) are omega0 and lambda0)
    initial_conditions = [x(7); x(8)];  % [omega0; lambda0]
    
    % Solve the ODE system using ode15s (stiff solver)
    options = odeset('RelTol',1e-5, 'AbsTol', 1e-6);  % Set tolerance to avoid numerical instability
    [t,z] = ode15s(@(t,z) goodwin_model(z, x(1), x(2), x(3), x(4), x(5), x(6)), t, initial_conditions, options);
    
    % Output omega (z(:,1)) over time, and time t
    y = z(:,1)';  % Omega values over time
    t = t';        % Time vector
end

% Define the system of ODEs for the Goodwin model
function dz = goodwin_model(z, nu, alpha, beta, delta, phi0, phi1)
    % z(1) = omega, z(2) = lambda
    omega = z(1);
    lambda = z(2);
    
    % Inverse of the Phillips curve function
    %fun_Phi_inv = @(x) 1 - (phi1 / (x + phi0)).^(1/2);  % Inverse of Phillips curve
    
    % Define the ODEs
    dz = zeros(2,1);  % Initialize the derivative vector
    
    % Equation for d(omega)/dt
    dz(1) = omega * ((phi1 / ((1-lambda).^(2))) - phi0 - alpha);
    
    % Equation for d(lambda)/dt
    dz(2) = lambda * ((1 - omega) / nu - alpha - beta - delta);
end
