echo "Unit Test For MySql"
echo "Is MySql Listening?"
function isMysqlListening {
        isTCPlisten 3306
        return $?
}

echo "Is MySql Running?"
function isMysqlRunning {
        isRunning mysqld
        return $?
}


function isRunning {
PROCESS_NUM=$(ps -ef | grep "$1" | grep -v "grep" | wc -l)
if [ $PROCESS_NUM -gt 0 ] ; then
        echo $PROCESS_NUM
        return 1
else
        return 0
fi
}


function isTCPlisten {
TCPCOUNT=$(netstat -tupln | grep tcp | grep "$1" | wc -l)
if [ $TCPCOUNT -gt 0 ] ; then
        return 1
else
        return 0
fi
}


isMysqlRunning
if [ "$?" -eq 1 ]; then
        echo Mysql is Running at timestamp: $(date +"%F %T")
else
        echo Mysql process is not Running
        ERRORCOUNT=$((ERRORCOUNT+1))
fi

isMysqlListening
if [ "$?" -eq 1 ]; then
        echo Mysql is Listening at timestamp: $(date +"%F %T")
else
        echo Mysql is not Listening
        ERRORCOUNT=$((ERRORCOUNT+1))
fi
echo "End of Process"
