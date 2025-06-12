# Use an official OpenJDK base image
FROM openjdk:11-jdk-slim

# Set environment variables
ENV JMETER_VERSION=5.6.3 \
    JMETER_HOME=/opt/jmeter \
    CATALINA_HOME=/opt/tomcat \
    TOMCAT_VERSION=9.0.85

# Install dependencies and download JMeter and Tomcat
RUN apt-get update && apt-get install -y wget unzip && \
    # Install JMeter
    wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz && \
    tar -xzf apache-jmeter-${JMETER_VERSION}.tgz -C /opt && \
    mv /opt/apache-jmeter-${JMETER_VERSION} ${JMETER_HOME} && \
    rm apache-jmeter-${JMETER_VERSION}.tgz && \
    # Install Tomcat
    wget https://downloads.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt && \
    mv /opt/apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME} && \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    apt-get clean

# Expose ports
EXPOSE 8080 1099

# Set working directory
WORKDIR ${CATALINA_HOME}

# Start both Tomcat and JMeter in background (example only)
CMD ${CATALINA_HOME}/bin/startup.sh && tail -f ${CATALINA_HOME}/logs/catalina.out
