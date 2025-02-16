#' Prepare data from calcMetricRes to be in the right format for FDA
#'
#' @param metricRes a dataframe as calculated by calcMetricRes - requires
#' the columns ID (unique identifier of each row)
#' @param x the name of the x-axis of the spatial metric
#' @param y the name of the y-axis of the spatial metric
#'
#' @return returns a list with three entries, the unique ID, the functional
#' response Y and the weights
#' @export
#'
#' @examples
#' # retrieve example data from Damond et al. (2019)
#' spe <- .loadExample()
#' metricRes <- calcMetricPerFov(spe, c("alpha", "beta"),
#'     subsetby = "image_number", fun = "Gcross", marks = "cell_type",
#'     rSeq = seq(0, 50, length.out = 50), by = c(
#'         "patient_stage", "patient_id",
#'         "image_number"
#'     ),
#'     ncores = 1
#' )
#'
#' # create a unique ID for each row
#' metricRes$ID <- paste0(
#'     metricRes$patient_stage, "|", metricRes$patient_id,
#'     "|", metricRes$image_number
#' )
#' dat <- prepData(metricRes, "r", "rs")
#' @import tidyr
#' @importFrom methods is
prepData <- function(metricRes, x, y) {
    # type checking
    stopifnot(is(metricRes, "data.frame"))
    stopifnot(is(x, "character"))
    stopifnot(is(y, "character"))
    # extract the functional response matrix
    mat <- metricRes %>%
        dplyr::select("ID", x, y) %>%
        tidyr::spread("ID", y) %>%
        dplyr::select(!x)
    # create a dataframe as required by pffr
    # the colnames of the matrix are the new row IDs
    dat <- data.frame(ID = colnames(mat))
    # transpose of the matrix to have the entire response in one row
    dat$Y <- t(mat)
    # extract the number of points as weights
    weights <- metricRes %>%
      dplyr::select("ID", "npoints") %>%
      unique()
    # add the weights to the data.frame
    dat <- dat %>% dplyr::left_join(weights, by = "ID")
    # extract the coordinates
    coords <- metricRes %>%
        dplyr::select("ID", "centroidx", "centroidy") %>%
        unique()
    # add the coordinates to the data.frame
    dat <- dat %>% dplyr::left_join(coords, by = "ID")

    return(dat)
}
