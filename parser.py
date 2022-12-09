import json
import os
# assign directory
directory = 'donnes'

for filename in os.listdir(directory):
    fichier=open("donnes/"+filename)
    lines=fichier.readlines()[1]
    valeur= lines.split(" ")
    n=valeur[0]
    print(filename," : ",n)
    retour={'n':"",'cote':[]}
    retour["n"]=int(str(n))
    fichier=open("donnes/"+filename)
    lines=fichier.readlines()[2:]
    for line in lines:
        line=line.split(" ")
        retour['cote'].append([int(line[0]),int(line[1][:-1])])
    fichier.close()
    retourJson=json.dumps(retour,indent=4)
    f = open("json/"+str(filename)[:-8]+".json","w")
    f.write(retourJson)
    f.close()