#!/bin/bash

# initilize the Postgres DB
./setupDB-postgres.sh
RES=$?

if [[ $RES != 0 ]]; then
	echo -e "\n!!! Database Connect Filaed, Quit !!!\n"
	exit 1
fi

# start domain
#rm -rf /glassfish4/glassfish/domains/domain1/osgi-cache
#rm -rf /glassfish4/glassfish/domains/domain1/generated
echo -e "\n# starting domain #"
asadmin start-domain
RES=$?

if [[ $RES -eq 0 ]]; then
	# deploy the JavaApp
	#asadmin --user=admin --passwordfile=/tmp/glassfishpwd enable-secure-admin
	#rm -rf /glassfish4/glassfish/domains/domain1/osgi-cache
	#rm -rf /glassfish4/glassfish/domains/domain1/generated
	#ls -l /glassfish4/glassfish/domains/domain1/

	echo -e "\n# sleep for one minute for waiting glassfish load all required jars #"
	sleep 60
	JavaAppPath="$GLASSFISH_HOME/glassfish/domains/domain1/autodeploy/bundles/ZephyrWebSitesWebBundlesSoftware-1.0.0.war"
	echo -e "\n# deploying the Java App (${JavaAppPath}) #"
	echo "y" | asadmin --user=admin --passwordfile=/tmp/glassfishpwd deploy --name Zephyr-WebSites-WebBundles-Software --contextroot ZephyrWebSitesWebBundlesSoftware --force $JavaAppPath 
	RES=$?
fi

rm /tmp/glassfishpwd

if [[ $RES -eq 0 ]]; then
	echo -e "\n# viewing the log => ${logFile} #"
	tail -f $logFile 
else
	echo -e "\n!!! JavaApp deployed failed !!!"
fi
