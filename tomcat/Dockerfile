# Secure and Minimal image of Tomcat
# https://hub.docker.com/repository/docker/huggla/sam-tomcat

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.6-3.16"
ARG IMAGETYPE="application,base"
ARG TOMCAT_MAJOR_VERSION="8"
ARG TOMCAT_MINOR_VERSION="0.53"
ARG TOMCAT_VERSION="$TOMCAT_MAJOR_VERSION.$TOMCAT_MINOR_VERSION"
ARG LIBJPEGTURBO_VERSION="2.1.4"
ARG CATALINA_HOME="/usr/local/tomcat"
ARG TOMCAT_NATIVE_LIBDIR="$CATALINA_HOME/native-jni-lib"
ARG CONTENTIMAGE2="huggla/sam-content:libjpegturbo-$LIBJPEGTURBO_VERSION"
ARG CONTENTSOURCE2="/content-*"
ARG CONTENTDESTINATION2="/"
ARG EXCLUDEAPKS="libjpeg-turbo"
ARG INITCMDS='sed -i "/^\/usr\/lib\/libturbojpeg[.]so.*>libturbojpeg/d" /tmp/onbuild/exclude.filelist'
ARG MAKEDIRS="/var/log /usr/lib /usr/local/lib $CATALINA_HOME/conf/Catalina /tmp/tomcat $CATALINA_HOME/logs $CATALINA_HOME/work/Catalina/localhost"
ARG RUNDEPS="openjdk11-jre apr nss tomcat-native ttf-font-awesome"
ARG DOWNLOADS="http://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR_VERSION/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz"
ARG BUILDCMDS="cp -a apache-tomcat-$TOMCAT_VERSION/* /finalfs$CATALINA_HOME"
ARG FINALCMDS=\
"   rm -rf $CATALINA_HOME/webapps/examples $CATALINA_HOME/webapps/docs "\
"&& find '$CATALINA_HOME/bin' -name '*.sh' -exec sed -ri 's|^#!/bin/sh\$|#!/usr/local/bin/dash|' '{}' \; "\
"&& find '$CATALINA_HOME/bin' -name '*.sh' -exec sed -ri 's|^#!/bin/bash\$|#!/usr/local/bin/dash|' '{}' \; "\
"&& find '$CATALINA_HOME/bin' -name '*.sh' -exec sed -ri 's|^#!/usr/bin/env bash\$|#!/usr/local/bin/dash|' '{}' \; "\
"&& find '$CATALINA_HOME' ! -name LICENSE ! -type d -maxdepth 1 -delete "\
"&& cd /usr/local/lib "\
'&& ln -s ../../lib/jvm/java-11-openjdk/lib/* ../../share/java/*.jar ./ '\
'&& cd /var/log '\
"&& ln -s ../..$CATALINA_HOME/logs tomcat "\
"&& sed -i 's/autoDeploy=\"true\"/autoDeploy=\"true\" deployIgnore=\".snapshot\"/' $CATALINA_HOME/conf/server.xml "\
"&& chmod -R g+rwX $CATALINA_HOME/conf "\
"&& mv $CATALINA_HOME/webapps /webapps-nobind"
ARG GID0WRITABLES="$CATALINA_HOME"
ARG GID0WRITABLESRECURSIVE="/webapps-nobind $CATALINA_HOME/work $CATALINA_HOME/logs $CATALINA_HOME/conf"
ARG STARTUPEXECUTABLES="$CATALINA_HOME/bin/catalina.sh /usr/lib/jvm/java-11-openjdk/bin/java"
ARG REMOVEDIRS="$CATALINA_HOME/include $CATALINA_HOME/temp"
ARG REMOVEFILES="$CATALINA_HOME/bin/tomcat-native.tar.gz $CATALINA_HOME/bin/commons-daemon* $CATALINA_HOME/bin/*.bat"
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base} as base
FROM ${INITIMAGE:-scratch} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-build} as build
FROM ${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================
# ARGs passed from Init <BEGIN>
ARG CATALINA_HOME
# ARGs passed from Init </END>

ENV VAR_LINUX_USER="tomcat" \
    VAR_FINAL_COMMAND="JRE_HOME=\"/usr/local\" CATALINA_HOME=\"$CATALINA_HOME\" CATALINA_TMPDIR=\"\$VAR_TEMP_DIR\" CATALINA_OPTS=\"\$VAR_CATALINA_OPTS\" JAVA_MAJOR=11 TOMCAT_MAJOR=$TOMCAT_MAJOR_VERSION CATALINA_OUT=\"\$VAR_CATALINA_OUT\" /usr/local/bin/catalina.sh run" \
    VAR_CONFIG_DIR="/etc/tomcat" \
    VAR_PREFS_DIR="\$VAR_CONFIG_DIR/prefs" \
    VAR_WEBAPPS_DIR="" \
    VAR_TEMP_DIR="/tmp/tomcat" \
    VAR_MIN_MEM="128M" \
    VAR_MAX_MEM="1024M" \
    VAR_CATALINA_OPTS="-Xms\$VAR_MIN_MEM -Xmx\$VAR_MAX_MEM -Djava.awt.headless=true -XX:+UseG1GC -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djavax.servlet.request.encoding=UTF-8 -Djavax.servlet.response.encoding=UTF-8 -Dorg.geotools.shapefile.datetime=true -server -Xrs -XX:PerfDataSamplingInterval=500 -Dorg.geotools.referencing.forceXY=true -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:NewRatio=2 -XX:+CMSClassUnloadingEnabled -Djava.util.prefs.userRoot=\$VAR_PREFS_DIR/.userPrefs -Djava.util.prefs.systemRoot=\$VAR_PREFS_DIR" \
    VAR_CATALINA_OUT="/dev/null" \
    VAR_WITH_MANAGERS="true" \
    VAR_MANAGER_ROLES="status" \
    VAR_MANAGER_PASSWORD="s3cret" \
    VAR_MANAGER_LISTEN="127.d+.d+.d+|::1|0:0:0:0:0:0:0:1"

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
