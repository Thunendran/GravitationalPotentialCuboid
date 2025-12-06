using Printf

# Set extended precision globally
setprecision(BigFloat, 512)

# --------------------------------------------------
# Include Custom Modules
# --------------------------------------------------
include("Gravitational_Potential_of_Cuboid.jl")
import .Gravitational_Potential_of_Cuboid as GPC

include("LaplacianTest.jl")
import .LaplacianTest as LT

# --------------------------------------------------
# Constants and Setup (Extended precision)
# --------------------------------------------------
G = big"1.0"
roh = big"1.0"
L, B, D = big"2.0", big"2.0", big"2.0"
X_0, Y_0, Z_0 = big"3.0", big"3.0", big"3.0"
h = big"1e-16"

# --------------------------------------------------
# Potential function definition
# --------------------------------------------------
phi(x, y, z) = GPC.Gravitational_potential_cuboid(
    x - X_0, y - Y_0, z - Z_0,
    L/big"2.0", B/big"2.0", D/big"2.0",
    roh, G
)

# --------------------------------------------------
# Special points Laplacian values
# --------------------------------------------------
points = [
    (X_0, Y_0, Z_0),               # Center
    (X_0 + L/2, Y_0, Z_0),         # Right boundary
    (X_0 - L/2, Y_0, Z_0),         # Left boundary
    (X_0, Y_0 + B/2, Z_0),         # Top boundary
    (X_0, Y_0 - B/2, Z_0)          # Bottom boundary
]

println("Laplacian values at special points:")
for (x, y, z) in points
    laplace_value = LT.Laplacian(phi, x, y, z, h)
    @printf("Laplacian at (%.2f, %.2f, %.2f): %.10e\n", x, y, z, laplace_value)
end

# --------------------------------------------------
# Print selected Laplacian values along x-axis line
# --------------------------------------------------
x_range = collect(range(X_0 - L, X_0 + L, length=400))

println("\nSelected Laplacian values along the x-axis (fixed y=3.0, z=3.0):")
for x in x_range[1:50:end]  # select and print every 50th value
    laplace_value = LT.Laplacian(phi, x, Y_0, Z_0, h)
    @printf("Laplacian at (%.3f, %.1f, %.1f): %.10e\n", x, Y_0, Z_0, laplace_value)
end


