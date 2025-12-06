# Written by Thunendran Periyandy, 2024
# Geodetic Science, The Ohio State University

def laplacian(phi, x, y, z, h):
    """
    Calculate the Laplacian of the potential using the central finite difference method.
    
    Parameters:
    - phi: Callable potential function phi(x, y, z)
    - x, y, z: Coordinates at which to evaluate the Laplacian
    - h: Step size for finite differences
    
    Returns:
    - float: The Laplacian ∇²φ at the point (x, y, z)
    """
    d2phi_dx2 = (phi(x + h, y, z) - 2 * phi(x, y, z) + phi(x - h, y, z)) / h**2
    d2phi_dy2 = (phi(x, y + h, z) - 2 * phi(x, y, z) + phi(x, y - h, z)) / h**2
    d2phi_dz2 = (phi(x, y, z + h) - 2 * phi(x, y, z) + phi(x, y, z - h)) / h**2
    return d2phi_dx2 + d2phi_dy2 + d2phi_dz2
