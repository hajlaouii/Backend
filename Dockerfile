FROM centos:7


RUN yum -y update && \
    yum -y clean all && \
    yum -y install java-1.8.0-openjdk



ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64
ENV JRE_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64/jre
ENV PATH=$PATH:/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64/bin:/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64/jre/bin
ENV CATALINA_HOME=/opt/apache-tomcat-8.5.53

COPY ./apache-tomcat-8.5.54 /opt/apache-tomcat-8.5.54

COPY ./G04R29C02 /opt/G04R29C02

RUN mkdir /opt/mysql-client
COPY ./mysql-community-client-5.6.37-2.el7.x86_64.rpm /opt/mysql-client
COPY ./mysql-community-libs-5.6.37-2.el7.x86_64.rpm /opt/mysql-client
COPY ./mysql-community-common-5.6.37-2.el7.x86_64.rpm /opt/mysql-client

WORKDIR /opt/mysql-client
RUN rpm -ivh mysql-community-common-5.6.37-2.el7.x86_64.rpm
RUN rpm -ivh mysql-community-libs-5.6.37-2.el7.x86_64.rpm
RUN rpm -ivh mysql-community-client-5.6.37-2.el7.x86_64.rpm --nodeps



RUN groupadd bulksmsgroup
RUN useradd -g bulksmsgroup bulksmsusr
RUN echo "bulksmspwd" | passwd --stdin bulksmsusr


CMD /opt/G04R29C02/start && tail -f /dev/null
