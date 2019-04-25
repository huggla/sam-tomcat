ARG TAG="20190418"
ARG DESTDIR="/libjpegturbo"

FROM huggla/alpine as alpine

ARG LIBJPEGTURBO_VERSION="2.0.2"
ARG BUILDDEPS="build-base cmake nasm openjdk8"
ARG DOWNLOAD="https://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-$LIBJPEGTURBO_VERSION.tar.gz"
ARG JAVA_HOME="/usr/lib/jvm/java-1.8-openjdk"
ARG DESTDIR

RUN apk add $BUILDDEPS \
 && downloadDir="$(mktemp -d)" \
 && cd $downloadDir \
 && wget "$DOWNLOAD" \
 && buildDir="$(mktemp -d)" \
 && cd $buildDir \
 && tar -xvp -f "$downloadDir/$(basename "$DOWNLOAD")" --strip-components=1 \
 && rm -rf "$downloadDir" \
 && cmake \
       -DCMAKE_INSTALL_PREFIX=/usr \
       -DCMAKE_INSTALL_LIBDIR=/usr/lib \
       -DCMAKE_BUILD_TYPE=MinSizeRel \
       -DCMAKE_C_FLAGS="$CFLAGS" \
       -DWITH_JAVA=1 \
 && make \
 && make install \
 && mkdir -p $DESTDIR-dev/usr/lib $DESTDIR-doc/usr/share $DESTDIR-java/usr/share $DESTDIR-utils/usr \
 && mv $DESTDIR/usr/include $DESTDIR-dev/usr/ \
 && mv $DESTDIR/usr/lib/*.a $DESTDIR/usr/lib/pkgconfig $DESTDIR-dev/usr/lib/ \
 && mv $DESTDIR/usr/share/doc $DESTDIR/usr/share/man $DESTDIR-doc/usr/share/ \
 && mv $DESTDIR/usr/share/java $DESTDIR-java/usr/share/ \
 && mv $DESTDIR/usr/bin $DESTDIR-utils/usr/
 
FROM huggla/busybox:$TAG as image
 
ARG DESTDIR

COPY --from=alpine $DESTDIR* $DESTDIR/
