### CYCLIC-BANDWIDTH CSP DOCKERFILE
## INSTALL PYTHON3 WITH CSP IN A DOCKER FOR EASIER DEPLOYEMENT OF TESTS
## CAN BE USED TO DEPLOY MULTIPLE TESTS AT THE SAME TIME

# Pull debian image
FROM minizinc/minizinc:latest

ENV VERSION=1

LABEL maintainer_one="Mateo Grimaud" \
      maintainer_one_email="mateo.grimaud@etud.univ-angers.fr" \
      maintainer_two="Anthony Guillot" \
      maintainer_two_email="anthony.guillot@etud.univ-angers.fr" \
      maintainer_three="Nathan Badoual" \
      maintainer_three_email="nathan.badoual@etud.univ-angers.fr" \
      maintainer_four="Alexandre Travers" \
      maintainer_four_email="altravers@etud.univ-angers.fr" \
      version="${VERSION}"

# APT upgrade and update + java 11 + minizinc
RUN apt upgrade && \
    apt update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq apt-utils python3 python3-pip openjdk-11-jdk && \
    rm -rf /var/lib/apt/lists/*

# Installing PyCSP3
RUN pip3 install --no-cache-dir pycsp3

CMD ["/bin/bash"]
