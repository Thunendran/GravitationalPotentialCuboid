% Constants
G = 1.0;
rho = 1.0;
X_0 = 3.0; Y_0 = 3.0; Z_0 = 3.0;
L = 2.0; B = 2.0; D = 2.0;
epsilon = 1e-10;

% Semi-dimensions
a = L/2;
b = B/2;
c = D/2;

% Test points and their descriptions
test_points = {
    [3.5, 3.5, 3.5], 'Interior';
    [3.5, 3.5, 4.0], 'On face';
    [3.5, 3.5, 4.0 + epsilon], 'Exterior (above face by epsilon)';
    [3.5, 3.5, 4.0 - epsilon], 'Interior (below face by epsilon)';
    [4.0, 4.0, 4.0], 'On vertex B';
    [4.0, 4.0 + epsilon, 4.0], 'On extended edge';
    [4.0 + epsilon, 4.0, 4.0], 'On extended edge';
    [3.0, 5.0, 4.0], 'On extended face';
    [7.0, 7.0, 7.0], 'Far exterior point';
    [7.0 + epsilon, 7.0 + epsilon, 7.0 + epsilon], 'Far exterior + eps'
};

% Potential function handle
phi = @(x,y,z) Gravitational_potential_cuboid(x - X_0, y - Y_0, z - Z_0, a, b, c, rho, G);

% Function to compute central difference gradient
function [gx, gy, gz] = compute_gradient(phi_func, x, y, z, h)
    gx = (phi_func(x + h, y, z) - phi_func(x - h, y, z)) / (2*h);
    gy = (phi_func(x, y + h, z) - phi_func(x, y - h, z)) / (2*h);
    gz = (phi_func(x, y, z + h) - phi_func(x, y, z - h)) / (2*h);
end

% Preallocate results
results = struct('TestPoint', {}, 'PotentialValue', {}, 'Description', {});
results_with_gradient = struct('TestPoint', {}, 'PotentialValue', {}, 'g_x', {}, 'g_y', {}, 'g_z', {}, 'Description', {});

% Loop over test points
for k = 1:size(test_points,1)
    coords = test_points{k,1};
    desc = test_points{k,2};
    x = coords(1); y = coords(2); z = coords(3);
    
    V = phi(x, y, z);
    
    results(k).TestPoint = sprintf('(%0.10f, %0.10f, %0.10f)', x, y, z);
    results(k).PotentialValue = sprintf('%0.15e', V);
    results(k).Description = desc;
    
    % Compute gradient
    [gx, gy, gz] = compute_gradient(phi, x, y, z, 1e-2);
    
    results_with_gradient(k).TestPoint = sprintf('(%0.10f, %0.10f, %0.10f)', x, y, z);
    results_with_gradient(k).PotentialValue = sprintf('%0.15e', V);
    results_with_gradient(k).g_x = sprintf('%0.15e', gx);
    results_with_gradient(k).g_y = sprintf('%0.15e', gy);
    results_with_gradient(k).g_z = sprintf('%0.15e', gz);
    results_with_gradient(k).Description = desc;
end

% Convert to table for better display
T = struct2table(results);
T_grad = struct2table(results_with_gradient);

% Display
disp('----------------------------------- Potential Values -----------------------------------');
disp(T);

disp('----------------------------------- Potential and Gradients ----------------------------');
disp(T_grad);
