function isApacheRunning {
        isRunning apache2
        return $?
}


function isRunning {
PROCESS_NUM=$(ps -ef | grep "$1" | grep -v "grep" | wc -l)
if [ $PROCESS_NUM -gt 0 ] ; then
#        echo $PROCESS_NUM
        return 1
else
        return 0
fi
}

ERRORCOUNT=0

echo  "Apache Unit Test"
echo "Unit Test 1  - Is Apache Running?"

isApacheRunning
if [ "$?" -eq 1 ]; then
        echo Apache process is Running at timestamp: $(date +"%F %T")
else
        echo Apache process is not Running
        ERRORCOUNT=$((ERRORCOUNT+1))
fi

function isApacheListening {
        isTCPlisten 80
        return $?
}

function isTCPlisten {
TCPCOUNT=$(netstat -tupln | grep tcp | grep "$1" | wc -l)
if [ $TCPCOUNT -gt 0 ] ; then
        return 1
else
        return 0
fi
}


isApacheListening
if [ "$?" -eq 1 ]; then
        echo Apache is Listening at timestamp: $(date +"%F %T")
else
        echo Apache is not Listening
        ERRORCOUNT=$((ERRORCOUNT+1))
fi


function isTCPlisten {
TCPCOUNT=$(netstat -tupln | grep tcp | grep "$1" | wc -l)
if [ $TCPCOUNT -gt 0 ] ; then
        return 1
else
        return 0
fi
}


echo "End of process"


