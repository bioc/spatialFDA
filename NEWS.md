# spatialFDA 0.99.4
* variable `ID` is no longer created in `calcMetricPerFov`
* adjusted examples and vignette to the above
* added option to extract gene expression directly in `calcMetricPerFov` if
`continuous = TRUE`

# spatialFDA 0.99.3
* adjusted `by` variable to work with length 1
* adjusted `...` in `plotMetricPerFov` to be passed only to `geom_line`

# spatialFDA 0.99.3
* adjust examples to build under 10 min

# spatialFDA 0.99.2
* Rewrote vignette with smaller dataset
* Implemented quasi likelihood family in vignette to improve variance estimation
* Adjustd calcMetricPerFov.R to be able to calculate cross functions

# spatialFDA 0.99.1
* Adressed Bioconductor review
* Added unit tests
* Added functional boxplots
* Added diagnostic plots to vignette

# spatialFDA 0.99.0

* Initial Bioconductor submission.
