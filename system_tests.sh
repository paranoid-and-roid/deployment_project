VAR=$(ps -ef | grep apache2 | wc -l)
echo There is/are $VAR apache2 processes running

VAR=$(ps -ef | grep mysql | wc -l)
echo There is/are $VAR mysql processes running

VAR=$(ps -ef | grep http | wc -l)
echo There is/are $VAR http processes running

VAR=$(ps -ef | grep tcp | wc -l)
echo There is/are $VAR TCP processes running
