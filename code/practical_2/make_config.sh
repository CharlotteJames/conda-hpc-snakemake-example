#!/bin/bash

cd ../

Rscript 0_get_conditions.R


echo "CONDITIONS:" > config.yml
{       read
        while IFS=, read -r line;
        do
                printf "  - ${line}\n">>config.yml

        done

} < ../data/derived/top_conditions.csv

