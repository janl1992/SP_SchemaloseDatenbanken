#!/bin/sh
now=$(date +"%Y_%m_%d_%H_%M")
date > pgbench_$now.log
 for f in *.sql; do  # or wget-*.sh instead of *.sh
        $PGSTATEMENT "$f" >> pgbench_$now.log  || break # if needed
    done




