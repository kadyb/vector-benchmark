#!/bin/bash

R_packages=(sf terra s2 geos)
Python_packages=(geopandas)

mkdir results

# run R benchmarks
for i in ${R_packages[*]}
do
  for path in "${i}"/*
  do
    echo "$path"
    Rscript "$path"
  done
done

# run Python benchmarks
for i in ${Python_packages[*]}
do
  for path in "${i}"/*
  do
    echo "$path"
    python3 "$path"
  done
done
