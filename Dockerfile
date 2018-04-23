FROM anapsix/alpine-java:8 as jre
FROM tomcat:jre8-alpine as tomcat
FROM huggla/alpine

ENV JAVA_VERSION_MAJOR="8" \
    JAVA_VERSION_MINOR="172" \
    JAVA_VERSION_BUILD="11" \
    JAVA_PACKAGE="server-jre" \
    JAVA_JCE="standard" \
    JAVA_HOME="/opt/jdk" \
    PATH="${PATH}:/opt/jdk/bin:/usr/local/tomcat/bin" \
    GLIBC_REPO="https://github.com/sgerrand/alpine-pkg-glibc" \
    GLIBC_VERSION="2.27-r0" \
    LANG="C.UTF-8" \
    TOMCAT_MAJOR="9" \
    TOMCAT_VERSION="9.0.7" \
    TOMCAT_HOME="/usr/local/tomcat" \
    CATALINA_HOME="/usr/local/tomcat" \
    CATALINA_OUT="/dev/null"
ENV TOMCAT_NATIVE_LIBDIR="$CATALINA_HOME/native-jni-lib"
ENV LD_LIBRARY_PATH="$TOMCAT_NATIVE_LIBDIR"

COPY --from=tomcat /usr/local/tomcat /usr/local/tomcat
COPY --from=jre /opt /opt
COPY ./bin /usr/local/bin

ENV REV_LINUX_USER="tomcat" \
    REV_param_JAVA_HOME="$JAVA_HOME" \
    REV_param_CATALINA_HOME="$CATALINA_HOME"
