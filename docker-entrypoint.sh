#!/bin/bash

echo 'Running docker entry point'
echo 'Changing permissions to '$SITE_DIR_NAME
chmod ugo+w $SITE_DIR_NAME
mv ./settings.xml /etc/maven/
export MAVEN_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'
