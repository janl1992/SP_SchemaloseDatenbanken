#!/bin/sh
date > pgbench.log
 for f in *.sql; do  # or wget-*.sh instead of *.sh
        $PGSTATEMENT "$f" >> pgbench.log  || break # if needed
    done




