# Written by Thunendran Periyandy, 2024
# Geodetic Science, The Ohio State University

# utils/surfaces.py
import numpy as np
from utils.safe_math import sp_log, sp_arctan

# ============================================
# COMMON RADIUS + LOG + ATAN UTILS
# ============================================

def _R(a, b, c):
    """Efficient scalar sqrt(a^2 + b^2 + c^2)"""
    return np.sqrt(a*a + b*b + c*c)

def _log_term(a, b, c, X):
    """Compute sp_log(X + R(a,b,c)) with cached R."""
    R = _R(a, b, c)
    return sp_log(X + R), R

def _atan_term(a, b, c, X):
    """Compute sp_arctan(b*c, X*R(a,b,c)) with cached R."""
    R = _R(a, b, c)
    return sp_arctan(b*c, X*R), R


# ============================================
# FACES — OPTIMIZED WITH PRECOMPUTATION
# ============================================

def Front(X1, X2, X3, X4, X5, X6):
    """
    Front face uses terms involving (-X2 + R).
    """
    # Precompute needed Rs and logs
    log1, _ = _log_term(X2, X4, X6, -X2)
    log2, _ = _log_term(X2, X4, X5, -X2)
    log3, _ = _log_term(X2, X3, X5, -X2)
    log4, _ = _log_term(X2, X3, X6, -X2)

    atan1, _ = _atan_term(X2, X4, X6, X2)
    atan2, _ = _atan_term(X2, X4, X5, X2)
    atan3, _ = _atan_term(X2, X3, X5, X2)
    atan4, _ = _atan_term(X2, X3, X6, X2)

    F_L = -(
        X6*X4*log1 +
        X4*X5*log2 +
        X5*X3*log3 +
        X3*X6*log4
    )

    F_T = -(X2*X2/2)*(
        atan1 + atan2 + atan3 + atan4
    )

    return F_L + F_T



def Back(X1, X2, X3, X4, X5, X6):
    # logs
    log1, _ = _log_term(X1, X4, X5, X1)
    log2, _ = _log_term(X1, X4, X6, X1)
    log3, _ = _log_term(X1, X3, X5, X1)
    log4, _ = _log_term(X1, X3, X6, X1)

    # atans
    atan1, _ = _atan_term(X1, X4, X5, X1)
    atan2, _ = _atan_term(X1, X4, X6, X1)
    atan3, _ = _atan_term(X1, X3, X5, X1)
    atan4, _ = _atan_term(X1, X3, X6, X1)

    B_L = (
        X4*X5*log1 +
        X6*X4*log2 +
        X5*X3*log3 +
        X3*X6*log4
    )

    B_T = -(X1*X1/2)*(
        atan1 + atan2 + atan3 + atan4
    )

    return B_L + B_T




def Right(X1, X2, X3, X4, X5, X6):
    log1, _ = _log_term(X1, X3, X6, X3)
    log2, _ = _log_term(X1, X3, X5, X3)
    log3, _ = _log_term(X2, X3, X5, X3)
    log4, _ = _log_term(X2, X3, X6, X3)

    atan1, _ = _atan_term(X3, X1, X6, X3)
    atan2, _ = _atan_term(X3, X1, X5, X3)
    atan3, _ = _atan_term(X3, X2, X5, X3)
    atan4, _ = _atan_term(X3, X2, X6, X3)

    R_L = (
        X6*X1*log1 +
        X1*X5*log2 +
        X5*X2*log3 +
        X2*X6*log4
    )

    R_T = -(X3*X3/2)*(
        atan1 + atan2 + atan3 + atan4
    )

    return R_L + R_T



def Left(X1, X2, X3, X4, X5, X6):
    log1, _ = _log_term(X1, X4, X6, -X4)
    log2, _ = _log_term(X1, X4, X5, -X4)
    log3, _ = _log_term(X2, X4, X5, -X4)
    log4, _ = _log_term(X2, X4, X6, -X4)

    atan1, _ = _atan_term(X4, X1, X6, X4)
    atan2, _ = _atan_term(X4, X1, X5, X4)
    atan3, _ = _atan_term(X4, X2, X5, X4)
    atan4, _ = _atan_term(X4, X2, X6, X4)

    L_L = -(
        X6*X1*log1 +
        X1*X5*log2 +
        X5*X2*log3 +
        X2*X6*log4
    )

    L_T = -(X4*X4/2)*(
        atan1 + atan2 + atan3 + atan4
    )

    return L_L + L_T



def Top(X1, X2, X3, X4, X5, X6):
    log1, _ = _log_term(X1, X4, X6, -X6)
    log2, _ = _log_term(X2, X4, X6, -X6)
    log3, _ = _log_term(X2, X3, X6, -X6)
    log4, _ = _log_term(X1, X3, X6, -X6)

    atan1, _ = _atan_term(X6, X1, X4, X6)
    atan2, _ = _atan_term(X6, X4, X2, X6)
    atan3, _ = _atan_term(X6, X2, X3, X6)
    atan4, _ = _atan_term(X6, X3, X1, X6)

    T_L = -(
        X1*X4*log1 +
        X4*X2*log2 +
        X2*X3*log3 +
        X3*X1*log4
    )

    T_T = -(X6*X6/2)*(
        atan1 + atan2 + atan3 + atan4
    )

    return T_L + T_T



def Bottom(X1, X2, X3, X4, X5, X6):
    log1, _ = _log_term(X1, X4, X5, X5)
    log2, _ = _log_term(X2, X4, X5, X5)
    log3, _ = _log_term(X2, X3, X5, X5)
    log4, _ = _log_term(X1, X3, X5, X5)

    atan1, _ = _atan_term(X5, X1, X4, X5)
    atan2, _ = _atan_term(X5, X2, X4, X5)
    atan3, _ = _atan_term(X5, X2, X3, X5)
    atan4, _ = _atan_term(X5, X3, X1, X5)

    B_L = (
        X1*X4*log1 +
        X4*X2*log2 +
        X2*X3*log3 +
        X3*X1*log4
    )

    B_T = -(X5*X5/2)*(
        atan1 + atan2 + atan3 + atan4
    )

    return B_L + B_T
