
# optimizador de constantes k1 y k2

import numpy as np
import matplotlib.pyplot as plt
import math
import random

# Constantes de la planta
A1 = 0.0154
A2 = 5e-5
az = 1
H_max = 0.62
g = 9.8
ro = 1000
Qmax = 0.5
Qmin = 0
H_star = H_max/2
Q_star = ro*A2*az*math.sqrt(2*g*H_star)
num1 = 1/(ro*A1)
den1 = 1
den2 = ((az*A2)**2*g*ro)/(A1*Q_star)

ts=0.1 #periodo
num = [0, 0.0065]
den = [1, -0.9987]

kp = 1.06160
ki = 0.03014
kd = -2.20023

M1 = H_max/3
M2 = H_max/6
epsilon = 0.01
tiempo_total = 300
sz = int(tiempo_total/ts)

def simulacion(k1, k2):
    error_acum = 0.0
    time = np.zeros(shape=sz, dtype=float)
    yd = np.zeros(shape=sz, dtype=float)
    y = np.zeros(shape=sz, dtype=float)
    error = np.zeros(shape=sz, dtype=float)
    derror = np.zeros(shape=sz, dtype=float)
    ei = 0
    u = np.zeros(shape=sz, dtype=float)
    error[0] = H_star
    error[1] = H_star
    yd[0] = H_star
    yd[1] = H_star
    y[0] = 0
    y[1] = 0
    time[1] = ts

    for i in range(2, sz):
        time[i] = i*ts
        yd[i] = H_star
        y[i] = -den[1]*y[i-1] + num[1]*u[i-1]
        error[i] = yd[i] - y[i]
        error_acum += math.fabs(error[i]) # linea agregada
        derror[i] = error[i] - error[i-1]
        ei = ei+error[i]*ts

        aplicar_regla = 0

        if math.fabs(error[i]) > M1:
            aplicar_regla = 1
            if error[i] > 0:
                u[i] = Qmax*0.5
            else:
                u[i] = Qmin
        elif math.fabs(error[i]) <= epsilon:
            aplicar_regla = 5
            u[i] = u[i-1] + kp*(error[i] - error[i-1]) + ki*ei
        elif error[i]*derror[i] < 0 and derror[i]*derror[i-1] < 0:
            aplicar_regla = 4
            if abs(error[i]) >= M2:
                u[i] = u[i-1] + k1*kp*error[i]
            else:
                u[i] = u[i-1] + k2*kp*error[i]
        elif (error[i]*derror[i] < 0 and derror[i]*derror[i-1] > 0) or error[i] == 0:
            aplicar_regla = 3
            u[i] = u[i-1]
        elif error[i]*derror[i] > 0 or derror[i] == 0:
            aplicar_regla = 2
            if abs(error[i]) >= M2:
                u[i] = u[i-1] + k1*kp*(error[i] - error[i-1]) + k1*ki*error[i] + k1*kd*(error[i] - 2*error[i-1] + error[i-2])
            else:
                u[i] = u[i-1] + kp*(error[i] - error[i-1]) + ki*error[i] + kd*(error[i] - 2*error[i-1] + error[i-2])
        else:
            aplicar_regla = 0
            u[i] = kp*error[i] + (kd*derror[i])/ts + ki*ei

    return (error_acum, error, time)


def getMinK(iters):
    integral = math.inf
    error = np.zeros(shape=sz, dtype=float)
    tiempo = np.zeros(shape=sz, dtype=float)
    k1_best = 0
    k2_best = 0
    for i in range(iters):
        k2 = random.random()
        k1 = random.random()*9 + 1
        tempint, temperr, temptiempo = simulacion(k1, k2)
        tempint = math.fabs(tempint)
        if tempint < integral:
            integral = tempint
            error = temperr.copy()
            tiempo = temptiempo.copy()
            k1_best = k1
            k2_best = k2
    return (k1_best, k2_best, integral, error, tiempo)

def main():
    error_acum, error, time = simulacion(4.614171795099491, 0.028760277298039982)
    print("error acum:", error_acum)
    fig, ax = plt.subplots()
    ax.plot(np.zeros(tiempo_total))
    ax.plot(time, error)
    plt.show()


main()