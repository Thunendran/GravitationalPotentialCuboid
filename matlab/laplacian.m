function result = laplacian(phi, x, y, z, h)
%LAPLACIAN Approximate the Laplacian of a scalar field using finite differences.
%
%   result = laplacian(phi, x, y, z, h)
%
%   Inputs:
%       phi - Function handle for the potential function, phi(x, y, z)
%       x, y, z - Point coordinates where the Laplacian is evaluated
%       h - Step size for finite difference approximation
%
%   Output:
%       result - Approximate Laplacian value at (x, y, z)

    d2phi_dx2 = (phi(x + h, y, z) - 2 * phi(x, y, z) + phi(x - h, y, z)) / h^2;
    d2phi_dy2 = (phi(x, y + h, z) - 2 * phi(x, y, z) + phi(x, y - h, z)) / h^2;
    d2phi_dz2 = (phi(x, y, z + h) - 2 * phi(x, y, z) + phi(x, y, z - h)) / h^2;
    
    result = d2phi_dx2 + d2phi_dy2 + d2phi_dz2;
end


