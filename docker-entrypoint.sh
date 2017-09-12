#!/bin/bash
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 
# Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.

VER="1.1"

echo "* Starting App Version ($VER) *"

if [[ -z $ADMIN_PASSWORD ]]; then
	ADMIN_PASSWORD=$(date| md5sum | fold -w 8 | head -n 1)
	echo "########## GENERATED ADMIN PASSWORD: $ADMIN_PASSWORD  ##########"
fi
echo "AS_ADMIN_PASSWORD=" > /tmp/glassfishpwd
echo "AS_ADMIN_NEWPASSWORD=${ADMIN_PASSWORD}" >> /tmp/glassfishpwd
domainName=domain1
asadmin --user=admin --passwordfile=/tmp/glassfishpwd change-admin-password --domain_name $domainName
asadmin start-domain
echo "AS_ADMIN_PASSWORD=${ADMIN_PASSWORD}" > /tmp/glassfishpwd
asadmin --user=admin --passwordfile=/tmp/glassfishpwd enable-secure-admin
asadmin --user=admin stop-domain

cp /pipeline/source/lib/jar/* $GLASSFISH_HOME/glassfish/domains/$domainName/autodeploy/bundles/
cp /pipeline/source/lib/dbDriver/* $GLASSFISH_HOME/glassfish/domains/$domainName/lib/
cp /pipeline/source/lib/domain.xml $GLASSFISH_HOME/glassfish/domains/$domainName/config/domain.xml

exec "$@"

logFile=$GLASSFISH_HOME/glassfish/domains/$domainName/logs/server.log
export logFile
./start-domain.sh
