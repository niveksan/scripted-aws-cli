#!/bin/sh 
# run scripted-aws-cli.sh once on container start to ensure it works
/scripted-aws-cli.sh
# start crond in foreground on Amazon Linux
exec crond -n
