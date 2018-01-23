FROM ubuntu:16.04

RUN apt-get update && apt-get install -y git
RUN apt-get install -y vim
RUN cd /home;git clone https://github.com/ciberdarc/testssis.git
RUN cd /home/testssis; sh ./NewFormat.sh valuations.csv
RUN ln -s /home/testssis/NewFormat.sh /NewFormat.sh
RUN ln -s /home/testssis/valuations.csv valuations.csv
RUN ln -s /home/testssis/2valuations.csv 2valuations.csv

--Configurar el servicio de ssh

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]