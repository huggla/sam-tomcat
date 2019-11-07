# tomcat-alpine
Tomcat on Alpine. You have to set VAR_WEBAPPS_DIR if you want to bind-mount the webapps-directory.

## Environment variables
### Runtime variables with default value
* VAR_LINUX_USER="tomcat" (User running VAR_FINAL_COMMAND)
* VAR_FINAL_COMMAND="JRE_HOME=\"/usr/local\" CATALINA_HOME=\"$CONTENTSOURCE1\" CATALINA_TMPDIR=\"\$VAR_TEMP_DIR\" CATALINA_OPTS=\"\$VAR_CATALINA_OPTS\" JAVA_MAJOR=8 TOMCAT_MAJOR=9 CATALINA_OUT=\"\$VAR_CATALINA_OUT\" /usr/local/bin/catalina.sh run" (Command run by VAR_LINUX_USER)
* VAR_CONFIG_DIR="/etc/tomcat" (Directory containing configuration files)
* VAR_PREFS_DIR="\$VAR_CONFIG_DIR/prefs"
* VAR_TEMP_DIR="/tmp/tomcat"
* VAR_MIN_MEM="128M"
* VAR_MAX_MEM="1024M"
* VAR_CATALINA_OPTS="-Xms\$VAR_MIN_MEM -Xmx\$VAR_MAX_MEM -Djava.awt.headless=true -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:ParallelGCThreads=4 -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djavax.servlet.request.encoding=UTF-8 -Djavax.servlet.response.encoding=UTF-8 -Dorg.geotools.shapefile.datetime=true -server -Xrs -XX:PerfDataSamplingInterval=500 -Dorg.geotools.referencing.forceXY=true -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:NewRatio=2 -XX:+CMSClassUnloadingEnabled -Djava.util.prefs.userRoot=\$VAR_PREFS_DIR/.userPrefs -Djava.util.prefs.systemRoot=\$VAR_PREFS_DIR"
* VAR_CATALINA_OUT="/dev/null"
* VAR_WITH_MANAGERS="true" (Set to false if you do not want to install the Tomcat admin-tools during new install)

### Optional runtime variables
* VAR_WEBAPPS_DIR="&lt;a directory&gt;" (/webapps-nobind if not set)
* VAR_ROOT_APP="&lt;a directory name&gt;"

## Capabilities
Can drop all but SETPCAP, SETGID and SETUID.
