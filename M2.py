from pycsp3 import *
n,cote=data
k=2
f = VarArray(size=[n], dom=range(1,n+1))

print("k = " + str(k))
prepre=[]
for i in range(1,n+1):
    for j in range(1,n+1):
        if(abs(i-j)<=k and i<j):
            prepre.append([i,j])

satisfy(
    AllDifferent(f),
    ([f[u-1],f[v-1]] in prepre for u,v in cote)
)

while(solve() not in {SAT,OPTIMUM} and k <= n):
    unpost(ALL)
    k+=1
    print("k = " + str(k))
    prepre=[]
    for i in range(1,n+1):
        for j in range(1,n+1):
            if(abs(i-j)<=k and i<j):
                prepre.append([i,j])
                prepre.append([j,i])
    satisfy(
        AllDifferent(f),
        ([f[u-1],f[v-1]] in prepre for u,v in cote)
    )
    
if(n_solutions() is None):
    print("Aucun résultat trouvé")
else:
    print("BOUND : " + str(k))
    print(solution())