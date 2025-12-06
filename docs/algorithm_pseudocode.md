# Algorithm Pseudocode  
### Gravitational Potential of a Homogeneous Cuboid

This document provides a high-level pseudocode description of the analytical algorithm used to compute the gravitational potential of a homogeneous cuboid.  
The full derivation and mathematical development are available in the manuscript:

**Periyandy, T. & Bevis, M. (2025)**  
*A Generalized Algorithm for the Gravitational Potential of a Homogeneous Cuboid.*  
Physics International, 16(1), 7–17.  
[Download manuscript PDF](https://thescipub.com/abstract/pisp.2025.7.17)

---

## 📐 1. Coordinate Transform

Given a point *(x, y, z)* and a cuboid centered at the origin with semi-dimensions *(L, B, D)*:

```
X1 = L - x
X2 = L + x
X3 = B - y
X4 = B + y
X5 = D - z
X6 = D + z
```

These distances define all expressions in the hexagonal graph representation of the cuboid.

---

## 🧮 2. Define Auxiliary Operations (Safe Functions)

Safe logarithm:

```
function sp_log(a):
    if a <= 0:
        return 0
    return log(a)
```

Safe arctangent:

```
function sp_atan(num, den):
    if num == 0 or den == 0:
        return 0
    return atan(num / den)
```

These prevent undefined behavior inside/on the cuboid.

---

## 🔷 3. Define R-Term

Used repeatedly in face expressions:

```
R(a, b, c) = sqrt(a^2 + b^2 + c^2)
```

---

## 🟥 4. Hexagonal Graph Face Contributions

Each cuboid face contributes a combination of:

- logarithmic terms (L-terms)  
- arctangent terms (T-terms)

General structure for each face *F*:

```
function FACE(X1, X2, X3, X4, X5, X6):

    # Compute required logs
    log_i = sp_log(expression involving Xi + R(...))

    # Compute required arctangents
    atan_i = sp_atan(b*c, X*R(...))

    # Linear-log contribution
    F_L = sum(coeff_i * log_i)

    # Quadratic-arctan contribution
    F_T = -(X^2 / 2) * sum(atan_i)

    return F_L + F_T
```

The six faces:

```
Front()
Back()
Right()
Left()
Top()
Bottom()
```

Each face uses the correct *X* values per the manuscript.

---

## 🧲 5. Total Potential

```
V(x, y, z) = Front + Back + Right + Left + Top + Bottom
```

Finally multiply by density and gravitational constant:

```
Potential = G * rho * V
```

---

## 🧪 6. Laplacian Test (Poisson / Laplace Equation)

Inside the cuboid:

```
∇²V = -4π G ρ
```

Outside the cuboid:

```
∇²V = 0
```

Numerically approximated using central differences:

```
Laplacian(phi, x, y, z, h):
    d2x = (phi(x+h) - 2phi(x) + phi(x-h)) / h²
    d2y = (phi(y+h) - 2phi(y) + phi(y-h)) / h²
    d2z = (phi(z+h) - 2phi(z) + phi(z-h)) / h²
    return d2x + d2y + d2z
```

This confirms correctness of the analytical expression.

---

## 📘 Notes

- This pseudocode reflects the mathematical structure used in Python, MATLAB, and Julia implementations.
- The safe-log and safe-arctan rules ensure stability for interior and boundary points.
- The hexagonal-face arrangement corresponds to the graph-based description given in the manuscript.

---

## 📎 Reference

Please cite:

**Periyandy, T. & Bevis, M. (2025).  
*A Generalized Algorithm for the Gravitational Potential of a Homogeneous Cuboid.*  
Physics International, 16(1), 7–17.  
https://doi.org/10.3844/pisp.2025.7.17**
