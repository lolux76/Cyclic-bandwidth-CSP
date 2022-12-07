#!/bin/bash

#getting models number
models_number=$(ls /data/models/ | wc -l)
echo "nombre de modèles à traiter : $models_number"

#generating each model

python3 /data/pycsp/m1.py
python3 /data/pycsp/m2.py
python3 /data/pycsp/m3.py

for file in /data/models/*; do
    time_start=date +%s
    echo "Traitement de l'instance : ${file##*/}"
    python3 /data/pycsp/m1.py -solve
    
done


exit 0