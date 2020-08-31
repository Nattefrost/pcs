#!/bin/bash


sqlite=`which sqlite3` 
db_path=../data/rider_records_men.sqlite

function uci_rankings() {
    # Args : 
    #   $1 : number of rows to output
    #   $2 : year
    # usage example top get top20 uci ranking for 2019 : uci_rankings 20
    [ -z ${1} ] && limit="500" || limit="${1}"
    [ -z ${2} ] || date="${2}"
    local cmd="select rider, sum(pointsuci) as totaluci from records"
    local endcmd="group by rider order by totaluci desc limit ${limit};"
    if [ -n  "${2}" ]
    then
        local clause; 
        clause="where date like '${date}%'"
    fi
    cmd="${cmd} ${clause} ${endcmd}"
    "${sqlite}" "${db_path}"  "${cmd}" | awk '{print NR " - " $0 }'
}

