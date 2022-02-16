# Vector processing benchmarks
This repository contains a collection of vector processing benchmarks for Python and R packages.
The tests cover the most common operations such as XXX.

Note that all operations were performed in the Cartesian coordinate system excluding [s2](https://github.com/r-spatial/s2) package, where calculations were performed on the sphere (this affects the longer calculation times).
For more information, see the [Spherical geometry in sf using s2geometry](https://r-spatial.github.io/sf/articles/sf7.html) article and [presentation](https://www.youtube.com/watch?v=zqRhF2XM1CE) at the FOSS4G 2021 conference.

The detailed results are available at XXX.

For high-performance data frames processing in R, check [data.table](https://grantmcdermott.com/fast-geospatial-datatable-geos/) and [collapse](https://sebkrantz.github.io/collapse/articles/collapse_and_sf.html).

You may also be interested in the [raster processing benchmarks](https://github.com/kadyb/raster-benchmark).

## Software
**Python**:
- [geopandas](https://github.com/geopandas/geopandas)

**R**:
- [sf](https://github.com/r-spatial/sf)
- [terra](https://github.com/rspatial/terra)
- [s2](https://github.com/r-spatial/s2)
- [geos](https://github.com/paleolimbot/geos)

## Reproduction
1. XXX.
2. Run all benchmarks using batch script (`run_benchmarks.sh`) or single benchmarks files.

**Batch script**
```
cd vector-benchmark
./run_benchmarks.sh
```

**Single benchmark**
```
Rscript sf/buffer.R
```

```
python3 geopandas/buffer.py
```

## Hardware configuration
- CPU: Intel Xeon CPU E5-2620 v2 @ 2.10GHz
- RAM: 64 GB
- OS: Pop!_OS 20.04 LTS
