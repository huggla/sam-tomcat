ARG TAG="20190115"
ARG CONTENTIMAGE1="tomcat:9-jre8-alpine"
ARG CONTENTSOURCE1="/usr/local/tomcat"
ARG CONTENTDESTINATION1="$CONTENTSOURCE1"
ARG CONTENTIMAGE2="anapsix/alpine-java:9"
ARG CONTENTSOURCE2="/opt/jdk"
ARG CONTENTDESTINATION2="$CONTENTSOURCE2"
ARG MAKEDIRS="/usr/lib/"
ARG RUNDEPS="libssl1.0 libcrypto1.0 apr musl"
ARG BUILDCMDS=\
"   mv $CONTENTSOURCE1/native-jni-lib/* /imagefs/usr/lib/ "\
"&& rm -rf $CONTENTSOURCE1/native-jni-lib "\
"&& chmod -R o= "$CONTENTSOURCE1" "\
"&& find $CONTENTSOURCE1/bin/ -name '*.sh' -exec sed -ri 's|^#!/bin/bash$|#!/usr/local/bin/dash|' '{}' +"

#---------------Don't edit----------------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init
FROM ${BUILDIMAGE:-huggla/build} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as image
ARG CONTENTDESTINATION1
ARG CONTENTDESTINATION2
COPY --from=build /imagefs /
#-----------------------------------------

ENV VAR_LINUX_USER="tomcat" \
    VAR_FINAL_COMMAND="JAVA_HOME=\"$CONTENTDESTINATION2\" CATALINA_HOME=\"$CONTENTDESTINATION1\" CATALINA_OPTS=\"\$VAR_CATALINA_OPTS\" JAVA_MAJOR=9 TOMCAT_MAJOR=9 CATALINA_OUT=\"\$VAR_CATALINA_OUT\" PATH=\"\$PATH:$CONTENTDESTINATION2/bin:$CONTENTDESTINATION1/bin\" catalina.sh" \
    VAR_CATALINA_OPTS="'-Xms128m -Xmx756M -XX:SoftRefLRUPolicyMSPerMB=36000'" \
    VAR_CATALINA_OUT="'/dev/null'"

#---------------Don't edit----------------
USER starter
ONBUILD USER root
#-----------------------------------------
