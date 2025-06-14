check_create_dir <- function(path, recursive = TRUE) {
	#' Checks if a directory exists and creates it if it doesn't.
	#' 
	#' @param path The path of the directory to be checked or created.
	#' @param recursive Logical; if TRUE, creates subfolders if they don't exist.
	#' 
	#' @return None. The function creates the directory if it doesn't exist.
	#' 
	#' @export
	if (!dir.exists(path)) {
		dir.create(path, recursive = recursive) # make subfolders if set to TRUE
	}
}


set_studio_wd <- function() {
	#' Sets the working directory to the directory containing the active R script.
	#' @return A character string representing the path of the active R script.
	#' @export
	current_script_path <- rstudioapi::getSourceEditorContext()$path
	setwd(current_script_path)
	return (current_script_path)
}

create_nested_directories <- function(path) {
    # Split the path into levels
    levels <- unlist(strsplit(path, "/"))

    # Initialize the root path
    root_path <- ""

    # Create nested directories
    i <- 0
    for (level in levels) {
        # Append the current level to the root path
        if (root_path != "") {
            root_path <- file.path(root_path, level)
        } else {
            root_path <- level
        }

        # Check if the directory exists
        if (i > 0) {
            check_create_dir(root_path)
        }
        i <- i + 1
    }
}

