get_package_buildtime <- function(package_name = "glenforge") {
  #' A loaded package's date/time
  #' @param package_name string. Optional. The package one wants the build time for
  #' @return string. Package date/time of build. Defaults to glenforge
  #' @export
  pkg_desc <- utils::packageDescription(package_name)
  if (!is.null(pkg_desc$Built)) {
    build_date <- pkg_desc$Built
    return(build_date)
  } else {
    return(NULL)
  }
}

log_pack_build_date <- function(package_name = "glenforge") {
  #' Log a loaded package's date/time. Defaults to glenforge
  #' @param package_name string. Optional. The package one wants the build time for
  #' @export
  build_date <- get_package_buildtime(package_name)
  if (!is.null(build_date)) {
    logger(paste("Build date for", package_name, ":", build_date))
  } else {
    logger(paste("Build date for", package_name, "could not be determined"))
  }
}
