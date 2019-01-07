#!/bin/sh
now=$(date +"%m_%d_%Y")
date > pgbench_$now.log
 for f in *.sql; do  # or wget-*.sh instead of *.sh
        $PGSTATEMENT "$f" >> pgbench_$now.log  || break # if needed
    done




