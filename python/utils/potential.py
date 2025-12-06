# Written by Thunendran Periyandy, 2024
# Geodetic Science, The Ohio State University

# utils/potential.py
import numpy as np
from multiprocessing import Pool, cpu_count

from utils.surfaces import (
    Front, Back, Right, Left, Top, Bottom
)


# =========================================================
# SINGLE-POINT GRAVITATIONAL POTENTIAL
# =========================================================

def Gravitational_potential_cuboid(x, y, z, L, B, D, rho, G):
    """
    Compute the potential at a single point (x,y,z).
    Uses the optimized face functions in surfaces.py.
    """

    X1 = (L - x)
    X2 = (L + x)
    X3 = (B - y)
    X4 = (B + y)
    X5 = (D - z)
    X6 = (D + z)

    V = (
        Front(X1, X2, X3, X4, X5, X6) +
        Back (X1, X2, X3, X4, X5, X6) +
        Right(X1, X2, X3, X4, X5, X6) +
        Left (X1, X2, X3, X4, X5, X6) +
        Top  (X1, X2, X3, X4, X5, X6) +
        Bottom(X1, X2, X3, X4, X5, X6)
    )

    return G * rho * V


# =========================================================
# PARALLEL HELPERS
# =========================================================

def _potential_single_point(args):
    """
    Helper for Pool.map — evaluate the potential for one point.
    """
    x, y, z, L, B, D, rho, G = args
    return Gravitational_potential_cuboid(x, y, z, L, B, D, rho, G)


# =========================================================
# PARALLEL + VECTOR BATCH POTENTIAL EVALUATION
# =========================================================

def potential_batch(points, L, B, D, rho, G, parallel_threshold=100):
    """
    Evaluate gravitational potential for N points.

    If N > parallel_threshold:
        use multiprocessing for speed
    Else:
        compute sequentially (lower overhead)

    Parameters
    ----------
    points : array_like shape (N, 3)
        Coordinates [[x0,y0,z0], [x1,y1,z1], ...].

    Returns
    -------
    V : ndarray shape (N,)
        Potential at each point.
    """

    pts = np.asarray(points, dtype=float)
    
    if pts.ndim != 2 or pts.shape[1] != 3:
        raise ValueError("points must be shape (N, 3)")

    N = pts.shape[0]

    # Build argument list for Pool.map
    args_list = [(p[0], p[1], p[2], L, B, D, rho, G) for p in pts]

    # Decide parallel vs. serial
    if N > parallel_threshold:
        print(f"Using parallel processing ({cpu_count()} CPUs)...")
        with Pool(cpu_count()) as pool:
            V = pool.map(_potential_single_point, args_list)
    else:
        V = [_potential_single_point(a) for a in args_list]

    return np.array(V, dtype=float)
