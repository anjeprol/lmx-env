#!/bin/bash

echo 'Running docker entry point'
echo 'Changing permissions to '$SITE_DIR_NAME
chmod ugo+w $SITE_DIR_NAME
echo 'Moving setting from maven to point --> amk nexus'
mv ./settings.xml /etc/maven/
echo 'Exporting MAVEN_OPTS'
export MAVEN_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'
echo 'Entry points finished'
