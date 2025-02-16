% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotMetric.R
\name{plotCrossMetricPerFov}
\alias{plotCrossMetricPerFov}
\title{Plot a cross type spatial metric per field of view}
\usage{
plotCrossMetricPerFov(
  metricDf,
  theo = NULL,
  correction = NULL,
  x = NULL,
  imageId = NULL,
  ID = NULL,
  nrow = NULL,
  ncol = NULL,
  legend.position = "none",
  ...
)
}
\arguments{
\item{metricDf}{the metric dataframe as calculated by \code{calcMetricPerFov}}

\item{theo}{logical; if the theoretical line should be plotted}

\item{correction}{the border correction to plot}

\item{x}{the x-axis variable to plot}

\item{imageId}{the ID of the image/fov}

\item{ID}{the (optional) ID for plotting combinations}

\item{nrow}{the number of rows for the facet wrap}

\item{ncol}{the number of columns for the facet wrap}

\item{legend.position}{the position of the legend of the plot}

\item{...}{Other parameters passed to \code{ggplot2} functions}
}
\value{
a ggplot object
}
\description{
This function plots the cross function between two marks output from
\code{calcMetricPerFov}. It wraps around helper function and applies this
function to all samples.
}
\examples{
# retrieve example data from Damond et al. (2019)
spe <- .loadExample()
metricRes <- calcCrossMetricPerFov(spe, c("alpha", "beta"),
    subsetby = "image_number", fun = "Gcross", marks = "cell_type",
    rSeq = seq(0, 50, length.out = 50), by = c(
        "patient_stage", "patient_id",
        "image_number"
    ),
    ncores = 1
)

metricRes$ID <- paste0(
 metricRes$patient_stage, "|", metricRes$patient_id
)

metricRes <- subset(metricRes, image_number \%in\% c(138, 139, 140))
p <- plotCrossMetricPerFov(metricRes,
    theo = TRUE, correction = "rs",
    x = "r", imageId = "image_number", ID = "ID"
)
print(p)
}
