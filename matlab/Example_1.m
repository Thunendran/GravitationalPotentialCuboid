% Constants and point of evaluation
G = 1;          % Gravitational constant
rho = 1;        % Density of the cube (kg/m^3)
X_0 = 3; Y_0 = 3; Z_0 = 3;   % Center of mass coordinates
L = 2.0; B = 2.0; D = 2.0;   % Dimensions of the cuboid (full lengths)
x = 4; y = 4; z = 4;         % Evaluation point

% Calculate gravitational potential
V = Gravitational_potential_cuboid((x - X_0), (y - Y_0), (z - Z_0), L/2, B/2, D/2, rho, G);

% Display the result
fprintf('The gravitational potential at point (%.1f, %.1f, %.1f) is %.10e m^2/s^2\n', x, y, z, V);
