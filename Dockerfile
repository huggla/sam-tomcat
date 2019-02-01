ARG TAG="20190129"
ARG CONTENTIMAGE1="tomcat:9-jre8-alpine"
ARG CONTENTSOURCE1="/usr/local/tomcat"
ARG CONTENTDESTINATION1="/buildfs$CONTENTSOURCE1"
ARG CONTENTIMAGE2="anapsix/alpine-java:9"
ARG CONTENTSOURCE2="/opt/jdk"
ARG CONTENTDESTINATION2="/buildfs$CONTENTSOURCE2"
ARG MAKEDIRS="/usr/lib/ /usr/local/lib $CONTENTSOURCE1/conf/Catalina/localhost"
ARG RUNDEPS="tomcat-native"
ARG EXCLUDEAPKS="openjdk8-jre-base"
ARG EXCLUDEDEPS="openjdk8-jre-base"
ARG BUILDCMDS=\
"   find '/imagefs$CONTENTSOURCE1/bin' -name '*.sh' -exec sed -ri 's|^#!/bin/bash$|#!/usr/local/bin/dash|' '{}' + "\
"&& find '/imagefs$CONTENTSOURCE1/bin' -name '*.sh' -exec sed -ri 's|^#!/usr/bin/env bash$|#!/usr/local/bin/dash|' '{}' + "\
"&& chmod -R g=rwX '/imagefs$CONTENTSOURCE1/logs' '/imagefs$CONTENTSOURCE1/temp' '/imagefs$CONTENTSOURCE1/work' "\
"&& cp -a /imagefs$CONTENTSOURCE2/lib /imagefs/usr/local/"
ARG STARTUPEXECUTABLES="$CONTENTSOURCE1/bin/catalina.sh $CONTENTSOURCE2/bin/java"
ARG REMOVEDIRS="$CONTENTSOURCE1/webapps/examples $CONTENTSOURCE1/webapps/docs $CONTENTSOURCE1/native-jni-lib $CONTENTSOURCE1/include $CONTENTSOURCE2"
ARG REMOVEFILES="$CONTENTSOURCE1/* $CONTENTSOURCE1/bin/commons-daemon*"

#--------Generic template (don't edit)--------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init
FROM ${BUILDIMAGE:-huggla/build} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as image
ARG CONTENTSOURCE1
ARG CONTENTSOURCE1="${CONTENTSOURCE1:-/}"
ARG CONTENTDESTINATION1
ARG CONTENTDESTINATION1="${CONTENTDESTINATION1:-/buildfs/}"
ARG CONTENTSOURCE2
ARG CONTENTSOURCE2="${CONTENTSOURCE2:-/}"
ARG CONTENTDESTINATION2
ARG CONTENTDESTINATION2="${CONTENTDESTINATION2:-/buildfs/}"
ARG CLONEGITSDIR
ARG DOWNLOADSDIR
ARG MAKEDIRS
ARG MAKEFILES
ARG EXECUTABLES
ARG STARTUPEXECUTABLES
ARG EXPOSEFUNCTIONS
COPY --from=build /imagefs /
ENV VAR_STARTUPEXECUTABLES="$STARTUPEXECUTABLES"
#---------------------------------------------

ENV VAR_LINUX_USER="tomcat" \
    VAR_FINAL_COMMAND="JAVA_HOME=\"/usr/local\" CATALINA_HOME=\"$CONTENTSOURCE1\" CATALINA_OPTS=\"\$VAR_CATALINA_OPTS\" JAVA_MAJOR=9 TOMCAT_MAJOR=9 CATALINA_OUT=\"\$VAR_CATALINA_OUT\" catalina.sh run" \
    VAR_CATALINA_OPTS="-Xms128m -Xmx756M -XX:SoftRefLRUPolicyMSPerMB=36000" \
    VAR_CATALINA_OUT="/dev/null"

#--------Generic template (don't edit)--------
USER starter
ONBUILD USER root
#---------------------------------------------
