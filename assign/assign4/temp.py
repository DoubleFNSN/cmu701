# -*- coding: utf-8 -*-

import math

def h(model, x):
    if model[0] == 'x':
        if model[2]:
            return 1 if x[0] > model[1] else -1
        else:
            return -1 if x[0] > model[1] else 1
    else:
        if model[2]:
            return 1 if x[1] > model[1] else -1
        else:
            return -1 if x[1] > model[1] else 1


X = [(1,2),(2,3),(3,4),(3,2),(3,1),(4,4),(5,4),(5,2),(5,1)]
Y = [-1,-1,1,1,1,1,1,-1,-1]

M = 9
T = 3
D = [[] for i in range(T)]
epsilon = [0] * T
alpha = [0] * T
err = [0] * T
model = [0] * T
index = []

#temp_models = [('x',2.5)]
#models = [(x[0],x[1],False) for x in temp_models]

temp_models = [('x',0.5),('x',1.5),('x',2.5),('x',3.5),('x',4.5),('x',5.5)]
temp_models += [('y',0.5),('y',1.5),('y',2.5),('y',3.5),('y',4.5)]
models = [(x[0],x[1],True) for x in temp_models]
models += [(x[0],x[1],False) for x in temp_models]

for t in range(T):
    if t == 0:
        D[t] = [1 / float(M)] * M
    else:
        D[t] = [D[t-1][i] * math.exp(-alpha[t-1] * Y[i] * h(model[t-1], X[i])) for i in range(M)]
        temp_sum = sum(D[t])
        D[t] = [x / temp_sum for x in D[t]]

    best_model = models[0]
    best_error = 1
    best_idx = 0
    idx = 0
    for cur_model in models:
        cur_error = 0
        for i in range(M):
            if h(cur_model, X[i]) != Y[i]:
                cur_error += D[t][i]
        if cur_error < best_error:
            best_error = cur_error
            best_model = cur_model
            best_idx = idx
        idx += 1
    epsilon[t] = best_error
    alpha[t] = 0.5 * math.log((1-best_error) / best_error)
    model[t] = best_model
    index.append(best_idx)

    cur_err = 0
    for i in range(M):
        predicted_value = 0
        for t1 in range(t+1):
            predicted_value += h(model[t1], X[i]) * alpha[t1]
        if predicted_value * Y[i] < 0:
            cur_err += 1 / float(M)
    err[t] = cur_err


print epsilon
print alpha
print err
print D
print models[index[0]]
print models[index[1]]
print models[index[2]]
