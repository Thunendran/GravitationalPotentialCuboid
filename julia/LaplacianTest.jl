# Laplacian Test
# Author: Thunendran Periyandy and Michael Bevis
# Date: 03-21-2025

module LaplacianTest

export Laplacian

setprecision(BigFloat, 512)

function Laplacian(phi, x::BigFloat, y::BigFloat, z::BigFloat, h::BigFloat)
    d2phi_dx2 = (phi(x + h, y, z) - 2phi(x, y, z) + phi(x - h, y, z)) / h^2
    d2phi_dy2 = (phi(x, y + h, z) - 2phi(x, y, z) + phi(x, y - h, z)) / h^2
    d2phi_dz2 = (phi(x, y, z + h) - 2phi(x, y, z) + phi(x, y, z - h)) / h^2
    return d2phi_dx2 + d2phi_dy2 + d2phi_dz2
end

end