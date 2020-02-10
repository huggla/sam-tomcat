# Secure and Minimal image of Tomcat, Epanet-Swmm.
# https://hub.docker.com/repository/docker/huggla/sam-tomcat

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.0"
ARG IMAGETYPE="application"
ARG TOMCAT_VERSION="9.0.20"
ARG EPANET_VERSION="2.00.12"
ARG SWMM_VERSION="5.1.013"
ARG CONTENTIMAGE1="huggla/content-alpine:epanet_$EPANET_VERSION-$TAG"
ARG CONTENTSOURCE1="/content-*"
ARG CONTENTDESTINATION1="/"
ARG CONTENTIMAGE2="huggla/content-alpine:swmm_$SWMM_VERSION-$TAG"
ARG CONTENTSOURCE2="/content-*"
ARG CONTENTDESTINATION2="/"
ARG MAKEDIRS="/usr/local/tomcat/work/epanet /usr/local/tomcat/work/swmm"
ARG BASEIMAGE="huggla/tomcat-alpine:$TOMCAT_VERSION-$TAG"
ARG EXECUTABLES="/usr/bin/epanet2 /usr/bin/swmm5"
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
# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
