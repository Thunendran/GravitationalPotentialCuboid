# Gravitational Potential Calculation for a Cuboid using Extended Precision (BigFloat)
# Author: Thunendran Periyandy and Michael Bevis
# Date: 03-21-2025

include("Gravitational_Potential_of_Cuboid.jl")
using .Gravitational_Potential_of_Cuboid

# Import required library for formatted printing
using Printf

# Set global precision (e.g., 512 bits for high accuracy calculations)
setprecision(BigFloat, 512)

# Constants with BigFloat precision
G, roh = big"1.0", big"1.0"
X_0, Y_0, Z_0 = big"3.0", big"3.0", big"3.0"
L, B, D = big"2.0", big"2.0", big"2.0"
x, y, z = big"4.0", big"4.0", big"4.0"

# Compute gravitational potential
V = Gravitational_potential_cuboid(x - X_0, y - Y_0, z - Z_0, L/2, B/2, D/2, roh, G)

# Output with extended precision
@printf("The gravitational potential at point (%.1f, %.1f, %.1f) is %.50e m^2/s^2\n", x, y, z, V)
