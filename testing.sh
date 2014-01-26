#!/bin/bash
echo timestamp: $(date +"%F %T")
echo ""
echo Running vmstat

vmstat

echo ""
echo Running Deployment Unit Test Suite at $(date +"%F %T")
echo ""
. /home/nci/home/testuser/unit_test_apache.sh
echo ""
. /home/nci/home/testuser/unit_test_mysql.sh
echo ""
. /home/nci/home/testuser/system_tests.sh
echo ""

echo Deployment Testing Completed at $(date +"%F %T")
echo ""
echo Everything working well
echo ""

