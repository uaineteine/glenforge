get_number_cores <- function() {
	#' Return the number of CPU cores
	#' @description Return the number of CPU cores on the machine, only the logical ones, not hyperthreads.
	#' @export
	numCores <- parallel::detectCores(all.tests = FALSE, logical = TRUE)
	return(max(numCores, 1)) #failsafe in case value ever returns null on future NGDs
}
