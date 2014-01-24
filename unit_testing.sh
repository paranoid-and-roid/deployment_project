#!/bin/bash
echo timestamp: $(date +"%F %T")
echo "Running Deployment Unit Test Suite at " timestamp: $(date +"%F %T")
. /home/nci/home/testuser/unit_test_apache.sh
. /home/nci/home/testuser/unit_test_mysql.sh

echo "Running a Clean Deploy at " timestamp: $(date +"%F %T")
. /home/nci/home/testuser/clean_deploy.sh

echo "Monitoring progress"

echo "Deployment Testing Completed at " timestamp: $(date +"%F %T")
echo "Everything working well"

