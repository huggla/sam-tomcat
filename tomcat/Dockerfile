# Secure and Minimal image of Hajk
# https://hub.docker.com/repository/docker/huggla/sam-hajk

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="dev"
ARG IMAGETYPE="application,base"
ARG TOMCAT_MAJOR_VERSION="9"
ARG TOMCAT_MINOR_VERSION="0.30"
ARG TOMCAT_VERSION="$TOMCAT_MAJOR_VERSION.$TOMCAT_MINOR_VERSION"
ARG LIBJPEGTURBO_VERSION="2.0.3-20191024"
ARG CATALINA_HOME="/usr/local/tomcat"
ARG TOMCAT_NATIVE_LIBDIR="$CATALINA_HOME/native-jni-lib"
ARG CONTENTIMAGE2="huggla/content-alpine:libjpegturbo_$LIBJPEGTURBO_VERSION"
ARG CONTENTSOURCE2="/content-*"
ARG CONTENTDESTINATION2="/"
ARG EXCLUDEAPKS="libjpeg-turbo"
ARG INITCMDS='sed -i "/^\/usr\/lib\/libturbojpeg[.]so.*>libturbojpeg/d" /tmp/onbuild/exclude.filelist'
ARG MAKEDIRS="/usr/lib/ /usr/local/lib $CATALINA_HOME/conf/Catalina /tmp/tomcat $CATALINA_HOME/logs $CATALINA_HOME/work/Catalina/localhost"
ARG RUNDEPS="openjdk11-jre-headless apr nss"
ARG DOWNLOADS="https://apache.mirrors.spacedump.net/tomcat/tomcat-$TOMCAT_MAJOR_VERSION/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz"
ARG BUILDDEPS="apr-dev coreutils dpkg-dev dpkg libc-dev openjdk11 openssl-dev"
ARG BUILDCMDS=\
"   mkdir tomcat-native "\
"&& mv apache-tomcat-$TOMCAT_VERSION/bin/tomcat-native.tar.gz tomcat-native/ "\
"&& cp -a apache-tomcat-$TOMCAT_VERSION/* / "\
"&& cp -a apache-tomcat-$TOMCAT_VERSION/* /finalfs/ "\
"&& cd tomcat-native "\
"&& tar -xf tomcat-native.tar.gz --strip-components=1 "\
"&& cd native "\
'&& export CATALINA_HOME=$PWD '\
'&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" '\
'&& ./configure --build="$gnuArch" --libdir="$TOMCAT_NATIVE_LIBDIR" --prefix="$CATALINA_HOME" --with-apr="$(which apr-1-config)" --with-ssl=yes '\
'&& eval "$COMMON_MAKECMDS" '\
"&& scanelf --needed --nobanner --format '%n#p' --recursive $TOMCAT_NATIVE_LIBDIR | tr ',' '\n' | sort -u | awk 'system(\"[ -e /usr/local/lib/\" \$1 \" ]\") == 0 { next } { print \"so:\" \$1 }'"
ARG REMOVEFILES="/bin/*.bat"
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
ARG CATALINA_HOME
# ARGs passed from Init </END>

ENV VAR_LINUX_USER="tomcat" \
    VAR_FINAL_COMMAND="JRE_HOME=\"/usr/local\" CATALINA_HOME=\"$CATALINA_HOME\" CATALINA_TMPDIR=\"\$VAR_TEMP_DIR\" CATALINA_OPTS=\"\$VAR_CATALINA_OPTS\" JAVA_MAJOR=8 TOMCAT_MAJOR=9 CATALINA_OUT=\"\$VAR_CATALINA_OUT\" /usr/local/bin/catalina.sh run" \
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
    VAR_MANAGER_LISTEN="127.d+.d+.d+|::1|0:0:0:0:0:0:0:1"

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
