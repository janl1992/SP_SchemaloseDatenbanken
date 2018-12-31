#!/bin/sh

export PGPASSWORD=postgres
export PGBENCH=/usr/lib/postgresql/11/bin/pgbench
export PGHOST=10.20.110.43
export PGPORT=5413
export PGUSER=postgres
export PGDB=team22
export PGSTATEMENT="$PGBENCH -h $PGHOST -p $PGPORT -U $PGUSER -d $PGDB -c 10 -t 5 -f"



for dir in ./*/
do
    dir=${dir%*/}
    echo ${dir##*/}
    cd ${dir}
    pwd
    for f in *.sh; do  # or wget-*.sh instead of *.sh
        bash "$f" -H   || break # if needed
    done
    cd ..
done
