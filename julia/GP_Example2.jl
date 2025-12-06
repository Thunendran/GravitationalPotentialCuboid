# =========================
# Gravitational Potential and Gradient Computation for a Cuboid
# Authors: Thunendran Periyandy and Michael Bevis
# Date: 04-21-2025
# =========================

# Include your module
include("Gravitational_Potential_of_Cuboid.jl")
using .Gravitational_Potential_of_Cuboid

# Required for formatted output
using Printf

# Set precision
setprecision(BigFloat, 1024; base = 10)

# Define constants
G = big"1.0"
roh = big"1.0"
X_0, Y_0, Z_0 = big"3.0", big"3.0", big"3.0"
L, B, D = big"2.0", big"2.0", big"2.0"
h = big"1e-2"
epsilon = big"1e-10"

# Define gravitational potential function
function phi(x::BigFloat, y::BigFloat, z::BigFloat)
    return Gravitational_Potential_of_Cuboid.Gravitational_potential_cuboid(
        x - X_0, y - Y_0, z - Z_0, L/2, B/2, D/2, roh, G
    )
end

# Define gravity gradient (gx, gy, gz) using central difference
function compute_gradient(phi_func, x::BigFloat, y::BigFloat, z::BigFloat, h::BigFloat)
    gx = (phi_func(x + h, y, z) - phi_func(x - h, y, z)) / (2 * h)
    gy = (phi_func(x, y + h, z) - phi_func(x, y - h, z)) / (2 * h)
    gz = (phi_func(x, y, z + h) - phi_func(x, y, z - h)) / (2 * h)
    return gx, gy, gz
end

# Define test points
test_points = [
    ((3.5, 3.5, 3.5), "Interior (centered below face ABCD)"),
    ((3.5, 3.5, 4.0), "On face ABCD"),
    ((3.5, 3.5, 4.0 + epsilon), "Exterior (above face by epsilon)"),
    ((3.5, 3.5, 4.0 - epsilon), "Interior (below face by epsilon)"),
    ((4.0, 4.0, 4.0), "On vertex B"),
    ((4.0, 4.0 + epsilon, 4.0), "On extended edge AB"),
    ((4.0 + epsilon, 4.0, 4.0), "On extended edge CB"),
    ((3.0, 5.0, 4.0), "On extended face ABCD"),
    ((7.0, 7.0, 7.0), "Far exterior point"),
    ((7.0 + epsilon, 7.0 + epsilon, 7.0 + epsilon), "Far exterior + epsilon")
]

# Compute and print results
for ((x_raw, y_raw, z_raw), description) in test_points
    x, y, z = BigFloat(x_raw), BigFloat(y_raw), BigFloat(z_raw)
    V = phi(x, y, z)
    gx, gy, gz = compute_gradient(phi, x, y, z, h)
    
    println("==================================================")
    println("Test Point: ($x, $y, $z)")
    println("Description: $description")
    @printf("Potential V  = %.15e m^2/s^2\n", V)
    @printf("Gravity Gradient gx = %.15e m/s^2\n", gx)
    @printf("Gravity Gradient gy = %.15e m/s^2\n", gy)
    @printf("Gravity Gradient gz = %.15e m/s^2\n", gz)
    println()
end
