import math
from functools import reduce

class data:
    x = 0
    y = 0
    label = 0
    pred = 0
    weight = float(1/9)

    # init data
    def __init__(self, x, y, label):
        self.x = x
        self.y = y
        self.label = label
        self.init_pred()

    # x based hypothesis:
    # if x >= 3, then pred = -1
    def init_pred(self):
        self.pred = 1 if self.x < 3 else -1

    # debug function, print data value
    def debug(self):
        print(str(self.x) + " " + str(self.y) + " " + \
              str(self.label) + " " + str(self. pred))

###### em frame iteration
# e step, get error: epsilon and alpha,
def estep(data_l):
    wrong = filter(lambda x: x.pred != x.label, data_l)
    epsilon = reduce(lambda x,y: x.weight + y.weight, wrong)
    alpha = 0.5 * math.log((1-epsilon)/epsilon)
    return epsilon, alpha

# m step, update data, and get new data
def mstep(data_l, alpha, iter_num):
    # update weight at first
    z = 0.0
    for d in data_l:
        # different update function
        if d.pred == d.label: # right
            d.weight = d.weight * math.exp(-alpha)
            z += d.weight
        else: # wrong
            d.weight = d.weight * math.exp(alpha)
            z += d.weight

    #normalize weight
    for d in data_l:
        d.weight = d.weight/z

    # update pred
    for d in data_l:
        # first update is different
        if (iter_num == 1):
            d.pred = d.pred * alpha
            d.pred = 1 if d.pred > 0 else -1
        else:
            d.pred = d.pred * (alpha + 1)
            d.pred = 1 if d.pred > 0 else -1
    return data_l


if __name__ == '__main__':
    # init data
    data_l = []
    data_l.append(data(1,2,1))
    data_l.append(data(2,3,1))
    data_l.append(data(5,1,1))
    data_l.append(data(5,2,1))
    data_l.append(data(3,1,-1))
    data_l.append(data(3,2,-1))
    data_l.append(data(3,4,-1))
    data_l.append(data(4,4,-1))
    data_l.append(data(5,4,-1))

    #for d in data_l:
    #    d.debug()

    for iter_num in range(1, 4):
        # estep, sample
        e1, a1 = estep(data_l)
        print("e1 " + str(e1))
        print("a1 " + str(a1))
        temp = [x.weight for x in data_l]
        print(temp)

        # mstep, update
        data_l = mstep(data_l, a1, iter_num)
        error_l = filter(lambda x: x.pred != x.label, data_l)
        e2 = reduce(lambda x,y: x.weight+y.weight, error_l)
        print("e2 " + str(e2))
        print("----------")

