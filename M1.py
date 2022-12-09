from pycsp3 import *
n,cote=data
f = VarArray(size=n, dom=range(1,n+1))
satisfy(
    AllDifferent(f)
)
minimize(
    Maximum(min(abs(f[u-1] - f[v-1]),n-abs(f[u-1]-f[v-1]))for u, v in cote)
)
