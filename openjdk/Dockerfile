ARG TAG="20190418"
ARG CONTENTIMAGE1="tomcat:9-jre8-alpine"
ARG CONTENTSOURCE1="/usr/local/tomcat"
ARG CONTENTDESTINATION1="/buildfs$CONTENTSOURCE1"
ARG LIBJPEGTURBO_VERSION="2.0.2"
ARG CONTENTIMAGE2="huggla/libjpegturbo:$LIBJPEGTURBO_VERSION"
ARG CONTENTSOURCE2="/libjpegturbo/usr/lib/libturbojpeg.so.0.2.0"
ARG CONTENTDESTINATION2="/imagefs/usr/lib/libturbojpeg.so"
ARG MAKEDIRS="/usr/lib/ /usr/local/lib $CONTENTSOURCE1/conf/Catalina /tmp/tomcat"
ARG RUNDEPS="openjdk8-jre-base apr nss"
ARG EXCLUDEAPKS="libjpeg-turbo"
ARG BUILDCMDS=\
"   find '/imagefs$CONTENTSOURCE1/bin' -name '*.sh' -exec sed -ri 's|^#!/bin/bash$|#!/usr/local/bin/dash|' '{}' + "\
"&& find '/imagefs$CONTENTSOURCE1/bin' -name '*.sh' -exec sed -ri 's|^#!/usr/bin/env bash$|#!/usr/local/bin/dash|' '{}' + "\
"&& find '/imagefs$CONTENTSOURCE1' ! -name LICENSE ! -type d -maxdepth 1 -exec rm -rf "{}" + "\
"&& mv /imagefs/usr/lib/jvm/java-1.8-openjdk/jre/lib /imagefs/usr/local/"
ARG GID0WRITABLES="$CONTENTSOURCE1"
ARG GID0WRITABLESRECURSIVE="$CONTENTSOURCE1/webapps $CONTENTSOURCE1/work $CONTENTSOURCE1/temp $CONTENTSOURCE1/logs $CONTENTSOURCE1/conf"
ARG STARTUPEXECUTABLES="$CONTENTSOURCE1/bin/catalina.sh /usr/lib/jvm/java-1.8-openjdk/jre/bin/java"
ARG REMOVEDIRS="$CONTENTSOURCE1/webapps/examples $CONTENTSOURCE1/webapps/docs /usr/lib/jvm"
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
ARG LINUXUSEROWNEDRECURSIVE
COPY --from=build /imagefs /
#---------------------------------------------

ENV VAR_LINUX_USER="tomcat" \
    VAR_FINAL_COMMAND="LD_LIBRARY_PATH=\"$CONTENTSOURCE1/native-jni-lib\" JAVA_HOME=\"/usr/local\" CATALINA_HOME=\"$CONTENTSOURCE1\" CATALINA_OPTS=\"-Xms\$VAR_MIN_MEM -Xmx\$VAR_MAX_MEM \$VAR_CATALINA_OPTS\" JAVA_MAJOR=8 TOMCAT_MAJOR=9 CATALINA_OUT=\"\$VAR_CATALINA_OUT\" catalina.sh run" \
    VAR_CONFIG_DIR="/etc/tomcat" \
    VAR_WEBAPPS_DIR="/webapps" \
    VAR_WORK_DIR="$CONTENTSOURCE1/work" \
    VAR_LOGS_DIR="$CONTENTSOURCE1/logs" \
    VAR_TEMP_DIR="/tmp/tomcat" \
    VAR_MIN_MEM="128M" \
    VAR_MAX_MEM="1024M" \
    VAR_CATALINA_OPTS="-Djava.awt.headless=true -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:ParallelGCThreads=4 -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djavax.servlet.request.encoding=UTF-8 -Djavax.servlet.response.encoding=UTF-8 -Duser.timezone=GMT -Dorg.geotools.shapefile.datetime=true -server -Xrs -XX:PerfDataSamplingInterval=500 -Dorg.geotools.referencing.forceXY=true -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:NewRatio=2 -XX:+CMSClassUnloadingEnabled" \
    VAR_CATALINA_OUT="/dev/null" \
    VAR_WITH_MANAGERS="true"

#--------Generic template (don't edit)--------
USER starter
ONBUILD USER root
#---------------------------------------------
