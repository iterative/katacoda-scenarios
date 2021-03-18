FROM python:3.7

WORKDIR /root

RUN wget \
       https://dvc.org/deb/dvc.list \
       -O /etc/apt/sources.list.d/dvc.list

RUN wget -qO - https://dvc.org/deb/iterative.asc | apt-key add -

RUN apt update -y && apt install -y dvc

CMD ["/bin/bash", "-i"]





