FROM ubuntu:16.04

RUN apt-get update && apt-get install -y git
RUN apt-get install -y vim
RUN cd /home;git clone https://github.com/ciberdarc/testssis.git;cd /
RUN cd /home/testssis; sh ./NewFormat.sh valuations.csv
RUN ln -s /home/testssis/NewFormat.sh /NewFormat.sh
RUN ln -s /home/testssis/valuations.csv valuations.csv
RUN ln -s /home/testssis/2valuations.csv 2valuations.csv
