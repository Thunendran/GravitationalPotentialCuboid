# Julia Implementation — Gravitational Potential of a Homogeneous Cuboid

This directory contains the Julia implementation of the analytical gravitational potential of a homogeneous cuboid using `BigFloat` extended precision.  
This version provides maximal numerical accuracy and serves as the validation baseline for the MATLAB and Python implementations.

Based on:

**Periyandy, T. & Bevis, M. (2025).**  
*A Generalized Algorithm for the Gravitational Potential of a Homogeneous Cuboid.*  
Physics International, 16(1), 7–17.  
https://doi.org/10.3844/pisp.2025.7.17

---

## 📂 Folder Structure

```
julia/
│
├── Gravitational_Potential_of_Cuboid.jl        # Main BigFloat potential function
├── LaplacianTest.jl                            # Arbitrary precision Laplacian evaluator
├── GP_Example1.jl                               # Basic potential evaluation
├── GP_Example2.jl                               # Gradient + boundary experiments
├── GP_Laplacian_Test_Example_02.jl              # Extended Laplacian tests
└── README_julia.md
```

---

## 🚀 Usage

Load the module:

```julia
include("Gravitational_Potential_of_Cuboid.jl")
using .Gravitational_Potential_of_Cuboid

setprecision(BigFloat, 512)
```

Compute the potential:

```julia
x = BigFloat(4)
y = BigFloat(4)
z = BigFloat(4)

L = BigFloat(2)
B = BigFloat(2)
D = BigFloat(2)

ρ = BigFloat(1)
G = BigFloat(1)

V = Gravitational_potential_cuboid(x, y, z, L/2, B/2, D/2, ρ, G)
println(V)
```

Run examples:

```julia
include("GP_Example1.jl")
include("GP_Example2.jl")
include("GP_Laplacian_Test_Example_02.jl")
```

---

## ⭐ Features

- Arbitrary numerical precision using `BigFloat`  
- Most accurate version of the cuboid potential implementation  
- Robust evaluation of logarithmic and arctangent expressions  
- Laplacian test verifies behavior inside and outside the cuboid  
- Cross-validation framework for Python and MATLAB versions  

---

## 📘 Citation

If you use this Julia implementation, please cite:

**Periyandy, T. & Bevis, M. (2025).  
*A Generalized Algorithm for the Gravitational Potential of a Homogeneous Cuboid.*  
Physics International, 16(1), 7–17.  
https://doi.org/10.3844/pisp.2025.7.17**
