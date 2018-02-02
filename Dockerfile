#Configura la instancia de ubuntu
FROM ubuntu:16.04

#Instala git en la instancia
RUN apt-get update
RUN apt-get update && apt-get install -y git

#Instala vim
RUN apt-get install -y vim

RUN apt-get install -y python2.7 python-pip

#Configurar el servicio de ssh

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

#Clona el repositorio de git
#RUN cd /home;git clone https://github.com/ciberdarc/testssis.git

#WORKDIR /valuations
#RUN pwd

RUN rm -rf /home/testssis

RUN mkdir -p /home/testssis
RUN chmod 700 /home/testssis

RUN find /home/testssis -type f -exec chmod 644 {} \;

ADD valuations.csv /home/testssis
ADD FormatFileValuations.sh /home/testssis
ADD TabDelimiter.py /home/testssis

RUN cd /home/testssis; python TabDelimiter.py valuations.csv > file.csv

#Ejecuta el sh FormatFileValuations.sh y la pasa el paramtro del csv
RUN cd /home/testssis; sed -i -e 's/\r$//' FormatFileValuations.sh
RUN cd /home/testssis; sh ./FormatFileValuations.sh file.csv

#Crea los links simbolicos
#RUN ln -s /home/testssis/FormatFileValuations.sh /FormatFileValuations.sh
#RUN ln -s /home/testssis/valuations.csv valuations.csv
#RUN ln -s /home/testssis/2valuations.csv 2valuations.csv