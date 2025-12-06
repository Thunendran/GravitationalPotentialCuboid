# MATLAB Implementation — Gravitational Potential of a Homogeneous Cuboid

This directory contains the MATLAB reference implementation of the analytical gravitational potential of a homogeneous cuboid.  
The algorithm follows the closed-form expressions developed in:

**Periyandy, T. & Bevis, M. (2025).**  
*A Generalized Algorithm for the Gravitational Potential of a Homogeneous Cuboid.*  
Physics International, 16(1), 7–17.  
https://doi.org/10.3844/pisp.2025.7.17

---

## 📂 Folder Structure

```
matlab/
│
├── Gravitational_potential_cuboid.m   # Main analytical potential function
├── laplacian.m                        # Central finite-difference Laplacian
├── Example_01.m                       # Basic potential evaluation
├── Example_02.m                       # Analytical Laplacian test (Vxx + Vyy + Vzz)
├── Example_03.m                       # Gradient and near-boundary behavior tests
└── README_matlab.md
```

---

## 🚀 Usage

Basic example:

```matlab
x = 4; 
y = 4; 
z = 4;

L = 2; B = 2; D = 2;
rho = 1; G = 1;

V = Gravitational_potential_cuboid(x, y, z, L, B, D, rho, G);
disp(V);
```

Vectorized evaluation over a grid:

```matlab
[X,Y,Z] = meshgrid(-5:0.1:5, -5:0.1:5, 0);
V = Gravitational_potential_cuboid(X, Y, Z, L, B, D, rho, G);
```

Run example scripts:

```matlab
Example_01
Example_02
Example_03
```

---

## ⭐ Features

- Fully analytical potential valid **inside**, **on**, and **outside** the cuboid  
- Numerically stable evaluation using "safe-log" and "safe-arctan" methods  
- MATLAB vectorization enables fast evaluation over 2D and 3D grids  
- Includes validation scripts for gradients and Laplacian  
- Cross-validated with Python and Julia implementations  

---

## 📘 Citation

If you use this MATLAB implementation, please cite:

**Periyandy, T. & Bevis, M. (2025).  
*A Generalized Algorithm for the Gravitational Potential of a Homogeneous Cuboid.*  
Physics International, 16(1), 7–17.  
https://doi.org/10.3844/pisp.2025.7.17**
