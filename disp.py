import numpy as np
a = np.loadtxt('final_movie_ids.mat')
# print a
import csv
f = open('data/movies.csv', 'r')
read = csv.reader(f, delimiter=',', quotechar='|')
read.next()
arr = dict()
count =1
print "\nRecommended movies: -\n"
for every in read:
	arr[count] = every[1]
	count+=1
for ab in a:
	print arr[int(ab)]
