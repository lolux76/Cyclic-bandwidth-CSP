# Cyclic-bandwidth-CSP

Resolving **cyclic-bandwidth** problem using CSP (minizinc + PyCSP + PySAT)

## How to install

 - clone the repository :
 ```
 git clone git@github.com:lolux76/Cyclic-bandwidth-CSP.git
 ```
 
## How to give it my own instances ?
Put your instances into the `/data/models` folder. The program will automatically execute the models on all of the instances in this folder.

## How to execute it ?

While in the program folder :

```
docker-compose up --build
```

/!\ First execution might take some time before opening the docker container while it downloads and build the image from scratch.