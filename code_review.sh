#!/usr/bin/env bash

GERRIT_CHANGE_NUMBER=$1
GERRIT_PATCHSET_UPLOADER=$2

if [ ! -f config.cfg ]; then
    echo "ERROR: Config file config.cfg missing. Please create it from config.cfg-template. Aborting."
    exit 0
fi
source config.cfg

# check if file exists
# file was auto created in: ./var/lib/jenkins/workspace/Faktoria-Frontend-FO Verify/ignore_change_numbers.txt
if [ -f ignore_change_numbers.txt ]; then
    declare -a ignore_change_numbers
    mapfile -t ignore_change_numbers < ignore_change_numbers.txt
    
    for i in "${ignore_change_numbers[@]}"
    do
        if [ "$i" == "$GERRIT_CHANGE_NUMBER" ]; then
            echo "A reviewer had already been assigned to this change. Exiting."
            exit 0
        fi
    done
fi

# add change number to file
echo "$GERRIT_CHANGE_NUMBER" >> ignore_change_numbers.txt

# TODO extract author from commit
echo "Commit author: "${GERRIT_PATCHSET_UPLOADER}

devs_length=${#DEVS[@]}
index=$(($RANDOM%$devs_length))
dev=${DEVS[$index]}

URL=${GERRIT_URL}${GERRIT_CHANGE_NUMBER}

curl -X POST --data-urlencode "payload={\"text\": \"<@"${dev}"> | <"${URL}">\"}" ${SLACK_URL}
