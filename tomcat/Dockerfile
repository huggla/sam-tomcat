# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="1.1-edge"
ARG TAG="20191112"
ARG IMAGETYPE="application,base"
ARG CONTENTIMAGE1="tomcat:9-jre8-alpine"
ARG CONTENTSOURCE1="/usr/local/tomcat"
ARG CONTENTDESTINATION1="/finalfs$CONTENTSOURCE1"
ARG LIBJPEGTURBO_VERSION="2.0.3"
ARG CONTENTIMAGE2="huggla/content-alpine:libjpegturbo_$LIBJPEGTURBO_VERSION-$TAG"
ARG CONTENTSOURCE2="/content-*"
ARG CONTENTDESTINATION2="/"
ARG EXCLUDEAPKS="libjpeg-turbo"
ARG INITCMDS='sed -i "/^\/usr\/lib\/libturbojpeg[.]so.*>libturbojpeg/d" /tmp/onbuild/exclude.filelist'
ARG MAKEDIRS="/usr/lib/ /usr/local/lib $CONTENTSOURCE1/conf/Catalina /tmp/tomcat $CONTENTSOURCE1/logs $CONTENTSOURCE1/work/Catalina/localhost"
ARG RUNDEPS="openjdk8-jre-base apr nss"
ARG BUILDCMDS=\
'   cd / '\
'&& gzfiles="$(ls *.gz | grep -ve "-doc[.]gz$" | grep -ve "-dev[.]gz$" | xargs)" '\
'&& echo "$gzfiles" '\
'&& content="$(zcat $gzfiles | sort -u - | xargs)" '\
'&& for file in $content; '\
'   do '\
'      if [ ! -e "/finalfs$file" ] || [ -f "/finalfs$file" ]; '\
'      then '\
'         cp -a "$file" "/finalfs$file"; '\
'      fi; '\
'   done'
ARG FINALCMDS=\
"   rm -rf $CONTENTSOURCE1/webapps/examples $CONTENTSOURCE1/webapps/docs "\
"&& find '$CONTENTSOURCE1/bin' -name '*.sh' -exec sed -ri 's|^#!/bin/bash\$|#!/usr/local/bin/dash|' '{}' \; "\
"&& find '$CONTENTSOURCE1/bin' -name '*.sh' -exec sed -ri 's|^#!/usr/bin/env bash\$|#!/usr/local/bin/dash|' '{}' \; "\
"&& find '$CONTENTSOURCE1' ! -name LICENSE ! -type d -maxdepth 1 -delete "\
"&& cd /usr/local/lib "\
'&& ln -s ../../lib/jvm/java-1.8-openjdk/jre/lib/* ../../share/java/*.jar ./ '\
'&& cd /usr/lib '\
'&& ln -s ../local/tomcat/native-jni-lib/* ./ '\
'&& cd /var/log '\
'&& ln -s ../../usr/local/tomcat/logs tomcat '\
"&& mv $CONTENTSOURCE1/webapps /webapps-nobind"
ARG GID0WRITABLES="$CONTENTSOURCE1"
ARG GID0WRITABLESRECURSIVE="/webapps-nobind $CONTENTSOURCE1/work $CONTENTSOURCE1/logs $CONTENTSOURCE1/conf"
ARG STARTUPEXECUTABLES="$CONTENTSOURCE1/bin/catalina.sh /usr/lib/jvm/java-1.8-openjdk/jre/bin/java"
ARG REMOVEDIRS="$CONTENTSOURCE1/include $CONTENTSOURCE1/temp"
ARG REMOVEFILES="$CONTENTSOURCE1/bin/commons-daemon*"
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/sam_$SaM_VERSION:base-$TAG}} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-huggla/sam_$SaM_VERSION:build-$TAG} as build
FROM ${BASEIMAGE:-huggla/sam_$SaM_VERSION:base-$TAG} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================
# ARGs passed from Init <BEGIN>
ARG CONTENTSOURCE1
# ARGs passed from Init </END>

ENV VAR_LINUX_USER="tomcat" \
    VAR_FINAL_COMMAND="JRE_HOME=\"/usr/local\" CATALINA_HOME=\"$CONTENTSOURCE1\" CATALINA_TMPDIR=\"\$VAR_TEMP_DIR\" CATALINA_OPTS=\"\$VAR_CATALINA_OPTS\" JAVA_MAJOR=8 TOMCAT_MAJOR=9 CATALINA_OUT=\"\$VAR_CATALINA_OUT\" /usr/local/bin/catalina.sh run" \
    VAR_CONFIG_DIR="/etc/tomcat" \
    VAR_PREFS_DIR="\$VAR_CONFIG_DIR/prefs" \
    VAR_WEBAPPS_DIR="" \
    VAR_TEMP_DIR="/tmp/tomcat" \
    VAR_MIN_MEM="128M" \
    VAR_MAX_MEM="1024M" \
    VAR_CATALINA_OPTS="-Xms\$VAR_MIN_MEM -Xmx\$VAR_MAX_MEM -Djava.awt.headless=true -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:ParallelGCThreads=4 -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djavax.servlet.request.encoding=UTF-8 -Djavax.servlet.response.encoding=UTF-8 -Dorg.geotools.shapefile.datetime=true -server -Xrs -XX:PerfDataSamplingInterval=500 -Dorg.geotools.referencing.forceXY=true -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:NewRatio=2 -XX:+CMSClassUnloadingEnabled -Djava.util.prefs.userRoot=\$VAR_PREFS_DIR/.userPrefs -Djava.util.prefs.systemRoot=\$VAR_PREFS_DIR" \
    VAR_CATALINA_OUT="/dev/null" \
    VAR_WITH_MANAGERS="true" \
    VAR_MANAGER_ROLES="status" \
    VAR_MANAGER_PASSWORD="s3cret" \
    VAR_MANAGER_LISTEN="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1"

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
