# Written by Thunendran Periyandy, 2024
# Geodetic Science, The Ohio State University

# utils/safe_math.py
import numpy as np

def sp_log(argument):
    """Safely handle logarithmic terms to avoid invalid values."""
    if argument <= 0:
        return 0
    return np.log(argument)

def sp_arctan(numerator, denominator):
    """Safely handle arctan terms to avoid invalid values."""
    if numerator == 0 or denominator == 0:
        return 0
    return np.arctan(numerator / denominator)
