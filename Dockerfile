FROM anapsix/alpine-java:9 as jre
FROM tomcat:9.0.7-jre8-alpine as tomcat
FROM huggla/alpine:20180424

ENV JAVA_MAJOR=9 \
    JAVA_HOME=/opt/jdk \
    PATH=${PATH}:/opt/jdk/bin:/usr/local/tomcat/bin \
    TOMCAT_MAJOR=9 \
    CATALINA_HOME=/usr/local/tomcat \
    CATALINA_OUT=/dev/null

COPY ./bin ${BIN_DIR}
COPY --from=tomcat ${CATALINA_HOME} ${CATALINA_HOME}
COPY --from=jre /opt /opt

RUN apk add --no-cache libssl1.0 libcrypto1.0 apr musl \
 && mv $CATALINA_HOME/native-jni-lib/* /usr/lib/ \
 && rm -rf $CATALINA_HOME/native-jni-lib \
 && chmod -R o= "$CATALINA_HOME" \
 && chmod g+rx /bin /usr/bin \
 && cd $CATALINA_HOME \
 && find ./bin/ -name '*.sh' -exec sed -ri 's|^#!/bin/bash$|#!/usr/bin/env sh|' '{}' +

ENV REV_LINUX_USER="tomcat" \
    REV_param_JAVA_HOME="$JAVA_HOME" \
    REV_param_CATALINA_HOME="$CATALINA_HOME" \
    REV_param_CATALINA_OPTS="-Xms128m -Xmx756M -XX:SoftRefLRUPolicyMSPerMB=36000"

USER sudoer
