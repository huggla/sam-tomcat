ARG TAG="20190220"
ARG CONTENTIMAGE1="tomcat:9-jre8-alpine"
ARG CONTENTSOURCE1="/usr/local/tomcat"
ARG CONTENTDESTINATION1="/buildfs$CONTENTSOURCE1"
ARG CONTENTIMAGE2="huggla/tomcat-native:1.2.21"
ARG CONTENTSOURCE2="/tomcat-native"
ARG CONTENTIMAGE3="anapsix/alpine-java:9"
ARG CONTENTSOURCE3="/opt/jdk"
ARG CONTENTDESTINATION3="/buildfs$CONTENTSOURCE3"
ARG MAKEDIRS="/usr/lib/ /usr/local/lib $CONTENTSOURCE1/conf/Catalina /tmp/tomcat"
ARG RUNDEPS="apr libssl1.1"
ARG BUILDCMDS=\
"   find '/imagefs$CONTENTSOURCE1/bin' -name '*.sh' -exec sed -ri 's|^#!/bin/bash$|#!/usr/local/bin/dash|' '{}' + "\
"&& find '/imagefs$CONTENTSOURCE1/bin' -name '*.sh' -exec sed -ri 's|^#!/usr/bin/env bash$|#!/usr/local/bin/dash|' '{}' + "\
"&& find '/imagefs$CONTENTSOURCE1' ! -name LICENSE ! -type d -maxdepth 1 -exec rm -rf "{}" + "\
"&& cp -a '/imagefs$CONTENTSOURCE3/lib' '/imagefs/usr/local/'"
ARG GID0WRITABLESRECURSIVE="$CONTENTSOURCE1/webapps $CONTENTSOURCE1/work $CONTENTSOURCE1/temp $CONTENTSOURCE1/logs $CONTENTSOURCE1/conf"
ARG STARTUPEXECUTABLES="$CONTENTSOURCE1/bin/catalina.sh $CONTENTSOURCE2/bin/java"
ARG REMOVEDIRS="$CONTENTSOURCE1/webapps/examples $CONTENTSOURCE1/webapps/docs $CONTENTSOURCE1/native-jni-lib $CONTENTSOURCE2"
ARG REMOVEFILES="$CONTENTSOURCE1/bin/commons-daemon* $CONTENTSOURCE1/temp/*"

#--------Generic template (don't edit)--------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
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
ARG CONTENTSOURCE3
ARG CONTENTSOURCE3="${CONTENTSOURCE3:-/}"
ARG CONTENTDESTINATION3
ARG CONTENTDESTINATION3="${CONTENTDESTINATION3:-/buildfs/}"
ARG CLONEGITSDIR
ARG DOWNLOADSDIR
ARG MAKEDIRS
ARG MAKEFILES
ARG EXECUTABLES
ARG STARTUPEXECUTABLES
ARG EXPOSEFUNCTIONS
ARG GID0WRITABLES
ARG GID0WRITABLESRECURSIVE
ARG LINUXUSEROWNED
COPY --from=build /imagefs /
RUN [ -n "$LINUXUSEROWNED" ] && chown 102 $LINUXUSEROWNED || true
#---------------------------------------------

ENV VAR_LINUX_USER="tomcat" \
    VAR_FINAL_COMMAND="JAVA_HOME=\"/usr/local\" CATALINA_HOME=\"$CONTENTSOURCE1\" CATALINA_OPTS=\"\$VAR_CATALINA_OPTS\" JAVA_MAJOR=9 TOMCAT_MAJOR=9 CATALINA_OUT=\"\$VAR_CATALINA_OUT\" catalina.sh run" \
    VAR_CONFIG_DIR="/etc/tomcat" \
    VAR_WEBAPPS_DIR="/webapps" \
    VAR_WORK_DIR="/usr/local/tomcat/work" \
    VAR_LOGS_DIR="/usr/local/tomcat/logs" \
    VAR_TEMP_DIR="/tmp/tomcat" \
    VAR_CATALINA_OPTS="-Xms128m -Xmx756M -XX:SoftRefLRUPolicyMSPerMB=36000" \
    VAR_CATALINA_OUT="/dev/null"

#--------Generic template (don't edit)--------
USER starter
ONBUILD USER root
#---------------------------------------------
