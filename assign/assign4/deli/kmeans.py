from collections import defaultdict
from random import uniform
from math import sqrt
import matplotlib.pyplot as plt


# get point average value
def point_avg(points):
    dimensions = len(points[0])

    new_center = []

    for dimension in xrange(dimensions):
        dim_sum = 0  # dimension sum
        for p in points:
            dim_sum += p[dimension]

        # average of each dimension
        new_center.append(dim_sum / float(len(points)))

    return new_center


# update centers
def update(data_set, assignments):
    new_means = defaultdict(list)
    centers = []
    for assignment, point in zip(assignments, data_set):
        new_means[assignment].append(point)

    for points in new_means.itervalues():
        centers.append(point_avg(points))

    return centers

# assign to the new center
def assign(data_points, centers):
    assignments = []
    for point in data_points:
        shortest = ()  # positive infinity
        shortest_index = 0
        for i in xrange(len(centers)):
            val = distance(point, centers[i])
            if val < shortest:
                shortest = val
                shortest_index = i
        assignments.append(shortest_index)
    return assignments


# calculate the distance of a data
def distance(a, b):
    """
    """
    dimensions = len(a)

    _sum = 0
    for dimension in xrange(dimensions):
        difference_sq = (a[dimension] - b[dimension]) ** 2
        _sum += difference_sq
    return sqrt(_sum)

# initialize the data
def kinit(data_set, k):
    centers = []
    dimensions = len(data_set[0])
    min_max = defaultdict(int)

    for point in data_set:
        for i in xrange(dimensions):
            val = point[i]
            min_key = 'min_%d' % i
            max_key = 'max_%d' % i
            if min_key not in min_max or val < min_max[min_key]:
                min_max[min_key] = val
            if max_key not in min_max or val > min_max[max_key]:
                min_max[max_key] = val

    for _k in xrange(k):
        rand_point = []
        for i in xrange(dimensions):
            min_val = min_max['min_%d' % i]
            max_val = min_max['max_%d' % i]

            rand_point.append(uniform(min_val, max_val))

        centers.append(rand_point)

    return centers

# general k_means function
def k_means(dataset, k, iter_num):
    k_points = kinit(dataset, k)
    assignments = assign(dataset, k_points)
    error = []
    for i in xrange(iter_num):
        new_centers = update(dataset, assignments)
        assignments = assign(dataset, new_centers)
        error.append( cal_iter_error(zip(assignments, dataset), k) )
    return error

# get iter error
def cal_iter_error(assignments, k):
    error = 0.0
    for i in xrange(k):
        k_cluster = filter(lambda x: x[0]== i, assignments)
        if len(k_cluster) > 0:
            error += cal_cluster_error([x[1] for x in k_cluster])
    return error

# get each cluster error in an iter
def cal_cluster_error(cluster):
    size = len(cluster)
    center = [0] * len(cluster[0])
    error = 0.0
    # get all error
    for x in cluster:
        for i in xrange(len(center)):
            center[i] += x[i]
    # normailize
    for i in xrange(len(center)):
        center[i] = float(center[i])/size
    # get error
    for d in cluster:
        for i in xrange(len(center)):
            error += (float(d[i]) - center[i]) ** 2
    return error

# load_data
def read_data(file_name):
    f = open(file_name)
    result = []
    for l in f:
        result.append([int(x) for x in l.strip().split(",")])
    f.close()
    return result

# print data
def print_data(error):
    x = [x for x in xrange(len(error[0]))]
    for e in error:
        plt.plot(x, e)
    plt.xlabel("iteration")
    plt.xlabel("error")
    plt.show()

if __name__=='__main__':
    data = read_data("data.csv")

    k = 10
    iter_num = 50

    error = []
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))
    error.append(k_means(data[:1000], k, iter_num))

    print error
    print_data(error)

