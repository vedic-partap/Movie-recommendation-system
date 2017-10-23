import csv
import numpy as np, scipy.io
no_users=0
curr_id=1
no_movies=0
movie_id={} #maps movie_id[their movie_id]=our_id
with open('data/ratings.csv') as r:
    reader = csv.reader(r, delimiter=",")
    reader.next()
    for row in reader:
    	if(int(row[0])>no_users):
        	no_users=int(row[0])


with open('data/movies.csv') as r:
    reader = csv.reader(r, delimiter=",")
    reader.next()
    for row in reader:
    	movie_id[row[0]]=curr_id
    	curr_id+=1

no_movies=len(movie_id)

Y=np.zeros((no_movies, no_users))
# np.set_printoptions(threshold=np.nan)
with open('data/ratings.csv') as r:
    reader = csv.reader(r, delimiter=",")
    reader.next()
    for row in reader:
    	Y[int(movie_id[row[1]])-1][int(row[0])-1]=float(row[2])

print("no_movies =",no_movies,"no_users=",no_users);
# np.savetxt('Y_matrix.txt',Y, delimiter=',')
scipy.io.savemat('Y_matrix1.mat', mdict={'Y':Y})
f=open("numbers_users_movies.txt",'w')
f.write(str(Y.shape[0])+" ")
f.write(str(Y.shape[1]))
