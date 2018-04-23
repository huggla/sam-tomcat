FROM anapsix/alpine-java:8_server-jre as jre
FROM tomcat:jre8-alpine as tomcat
FROM huggla/alpine

ENV JAVA_MAJOR=8 \
    JAVA_HOME=/opt/jdk \
    PATH=${PATH}:/opt/jdk/bin:/usr/local/tomcat/bin \
    TOMCAT_MAJOR=9 \
    CATALINA_HOME=/usr/local/tomcat \
    CATALINA_OUT=/dev/null
ENV TOMCAT_NATIVE_LIBDIR="$CATALINA_HOME/native-jni-lib"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$TOMCAT_NATIVE_LIBDIR"

COPY ./bin /usr/local/
COPY --from=tomcat /usr/local/tomcat /usr/local/
COPY --from=jre /opt /

RUN apk add --no-cache libressl2.6-libssl
# && cd $CATALINA_HOME \
# && find ./bin/ -name '*.sh' -exec sed -ri 's|^#!/bin/bash$|#!/usr/bin/env sh|' '{}' +

ENV REV_LINUX_USER="tomcat" \
    REV_param_JAVA_HOME="$JAVA_HOME" \
    REV_param_CATALINA_HOME="$CATALINA_HOME"

USER sudoer
