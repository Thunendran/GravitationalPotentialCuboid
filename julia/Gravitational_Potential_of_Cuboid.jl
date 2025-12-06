# Gravitational Potential Calculation for a Cuboid using Extended Precision (BigFloat)
# Author: Thunendran Periyandy and Michael Bevis
# Date: 03-21-2025

# Define the Gravitational Potential Module
module Gravitational_Potential_of_Cuboid

# Functions 
export Gravitational_potential_cuboid

# Import required library for formatted printing
using Printf

# Set global precision (e.g., 512 bits for high accuracy calculations)
setprecision(BigFloat, 512)

# Safely calculate logarithmic terms to prevent invalid values
function special_log(argument)
    if argument <= 0
        return big"0.0"  # Return 0 if argument is non-positive
    else
        return log(argument)  # Natural logarithm at extended precision
    end
end

# Safely calculate arctangent terms to prevent division by zero
function special_arctan(numerator, denominator)
    if numerator == 0 || denominator == 0
        return big"0.0"  # Return 0 if numerator or denominator is zero
    else
        return atan(numerator / denominator)  # Arctan at extended precision
    end
end

function Front(X1, X2, X3, X4, X5, X6)
    F_L = -( X6 * X4 * special_log(-X2 + sqrt(X2^2 + X4^2 + X6^2)) +
             X4 * X5 * special_log(-X2 + sqrt(X2^2 + X4^2 + X5^2)) +
             X5 * X3 * special_log(-X2 + sqrt(X2^2 + X3^2 + X5^2)) +
             X3 * X6 * special_log(-X2 + sqrt(X2^2 + X3^2 + X6^2)) )

    F_T = -( (X2^2) / 2 ) * (
             special_arctan(X6 * X4, X2 * sqrt(X2^2 + X4^2 + X6^2)) +
             special_arctan(X4 * X5, X2 * sqrt(X2^2 + X4^2 + X5^2)) +
             special_arctan(X5 * X3, X2 * sqrt(X2^2 + X3^2 + X5^2)) +
             special_arctan(X3 * X6, X2 * sqrt(X2^2 + X3^2 + X6^2)) )
    return F_L + F_T
end

function Back(X1, X2, X3, X4, X5, X6)
    B_L = ( X4 * X5 * special_log(X1 + sqrt(X1^2 + X4^2 + X5^2)) +
            X6 * X4 * special_log(X1 + sqrt(X1^2 + X4^2 + X6^2)) +
            X5 * X3 * special_log(X1 + sqrt(X1^2 + X3^2 + X5^2)) +
            X3 * X6 * special_log(X1 + sqrt(X1^2 + X3^2 + X6^2)) )

    B_T = -( (X1^2) / 2 ) * (
            special_arctan(X4 * X5, X1 * sqrt(X1^2 + X4^2 + X5^2)) +
            special_arctan(X6 * X4, X1 * sqrt(X1^2 + X4^2 + X6^2)) +
            special_arctan(X5 * X3, X1 * sqrt(X1^2 + X3^2 + X5^2)) +
            special_arctan(X3 * X6, X1 * sqrt(X1^2 + X3^2 + X6^2)) )
    return B_L + B_T
end

function Right(X1, X2, X3, X4, X5, X6)
    R_L = ( X6 * X1 * special_log(X3 + sqrt(X1^2 + X3^2 + X6^2)) +
            X1 * X5 * special_log(X3 + sqrt(X1^2 + X3^2 + X5^2)) +
            X5 * X2 * special_log(X3 + sqrt(X2^2 + X3^2 + X5^2)) +
            X2 * X6 * special_log(X3 + sqrt(X2^2 + X3^2 + X6^2)) )

    R_T = -( (X3^2) / 2 ) * (
            special_arctan(X6 * X1, X3 * sqrt(X1^2 + X3^2 + X6^2)) +
            special_arctan(X1 * X5, X3 * sqrt(X1^2 + X3^2 + X5^2)) +
            special_arctan(X5 * X2, X3 * sqrt(X2^2 + X3^2 + X5^2)) +
            special_arctan(X2 * X6, X3 * sqrt(X2^2 + X3^2 + X6^2)) )
    return R_L + R_T
end

function Left(X1, X2, X3, X4, X5, X6)
    L_L = -( X6 * X1 * special_log(-X4 + sqrt(X1^2 + X4^2 + X6^2)) +
             X1 * X5 * special_log(-X4 + sqrt(X1^2 + X4^2 + X5^2)) +
             X5 * X2 * special_log(-X4 + sqrt(X2^2 + X4^2 + X5^2)) +
             X2 * X6 * special_log(-X4 + sqrt(X2^2 + X4^2 + X6^2)) )

    L_T = -( (X4^2) / 2 ) * (
            special_arctan(X1 * X6, X4 * sqrt(X1^2 + X4^2 + X6^2)) +
            special_arctan(X1 * X5, X4 * sqrt(X1^2 + X4^2 + X5^2)) +
            special_arctan(X5 * X2, X4 * sqrt(X2^2 + X4^2 + X5^2)) +
            special_arctan(X2 * X6, X4 * sqrt(X2^2 + X4^2 + X6^2)) )
    return L_L + L_T
end

function Top(X1, X2, X3, X4, X5, X6)
    T_L = -(X1 * X4 * special_log(-X6 + sqrt(X1^2 + X4^2 + X6^2)) +
            X4 * X2 * special_log(-X6 + sqrt(X2^2 + X4^2 + X6^2)) +
            X2 * X3 * special_log(-X6 + sqrt(X2^2 + X3^2 + X6^2)) +
            X3 * X1 * special_log(-X6 + sqrt(X1^2 + X3^2 + X6^2)))

    T_T = -( (X6^2) / 2 ) * (
            special_arctan(X1 * X4, X6 * sqrt(X1^2 + X4^2 + X6^2)) +
            special_arctan(X4 * X2, X6 * sqrt(X2^2 + X4^2 + X6^2)) +
            special_arctan(X2 * X3, X6 * sqrt(X2^2 + X3^2 + X6^2)) +
            special_arctan(X3 * X1, X6 * sqrt(X1^2 + X3^2 + X6^2)))
    return T_L + T_T
end

function Bottom(X1, X2, X3, X4, X5, X6)
    B_L = (X1 * X4 * special_log(X5 + sqrt(X1^2 + X4^2 + X5^2)) +
           X4 * X2 * special_log(X5 + sqrt(X2^2 + X4^2 + X5^2)) +
           X2 * X3 * special_log(X5 + sqrt(X2^2 + X3^2 + X5^2)) +
           X3 * X1 * special_log(X5 + sqrt(X1^2 + X3^2 + X5^2)))

    B_T = -( (X5^2) / 2 ) * (
            special_arctan(X1 * X4, X5 * sqrt(X1^2 + X4^2 + X5^2)) +
            special_arctan(X2 * X4, X5 * sqrt(X2^2 + X4^2 + X5^2)) +
            special_arctan(X2 * X3, X5 * sqrt(X2^2 + X3^2 + X5^2)) +
            special_arctan(X1 * X3, X5 * sqrt(X1^2 + X3^2 + X5^2)))
    return B_L + B_T
end

function Gravitational_potential_cuboid(x, y, z, L, B, D, rho, G)
    X1 = (L - x)
    X2 = (L + x)
    X3 = (B - y)
    X4 = (B + y)
    X5 = (D - z)
    X6 = (D + z)

    V_xyz = Front(X1, X2, X3, X4, X5, X6) +
            Back(X1, X2, X3, X4, X5, X6) +
            Right(X1, X2, X3, X4, X5, X6) +
            Left(X1, X2, X3, X4, X5, X6) +
            Top(X1, X2, X3, X4, X5, X6) +
            Bottom(X1, X2, X3, X4, X5, X6)

    return G * rho * V_xyz
end

end