### SECTION 1  - SETUP ###
r_version <- paste0(R.Version()$major, ".", R.Version()$minor) # Get the R version

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Install required packages if not already installed
required_packages <- readLines("requirements.txt")
required_packages <- required_packages[required_packages != ""]  # Remove empty lines
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))   #import libs
source("libs.r")

# read the config
packagemeta <- yaml.load_file('package_build_manifest.yaml')
packageversion <- packagemeta$Packageversion
packagemeta$Output_directory <- stringr::str_glue(packagemeta$Output_directory) # replace the placeholder with the actual R version

# create directory if necessary
fs::dir_create(packagemeta$Output_directory)

### SECTION 2  - GENERATE CODE FILES ###
message("Generating meta code files")
auto_meta_text <- sprintf('%s_package_version <- function() {
  #\' package version
  #\' @return string. Package version and build number
  #\' @export
  return("%s:%s")
}
', packagemeta$Package, packagemeta$Packageversion, packagemeta$BuildNo)
writeLines(auto_meta_text, "packagespace/R/meta_auto.r")

### SECTION 3  - BUILD DOCUMENTATION ###
setwd("packagespace")

# Read requirements.txt and update DESCRIPTION
requirements <- readLines("../requirements.txt")
requirements <- requirements[requirements != ""]  # Remove empty lines

# Read and update DESCRIPTION
txt <- readLines("DESCRIPTION")
# Update version
txt <- stringr::str_replace(txt, "Version:.+", paste("Version:", packagemeta$Packageversion))

# Remove existing Imports section if it exists
imports_line <- which(grepl("^Imports:", txt))
if (length(imports_line) > 0) {
    # Find the next section
    next_section <- which(grepl("^[A-Za-z]+:", txt[imports_line:length(txt)]))[2]
    if (!is.na(next_section)) {
        # Remove the entire Imports section
        txt <- txt[-(imports_line:(imports_line + next_section - 2))]
    } else {
        # If no next section, remove from Imports to end
        txt <- txt[-(imports_line:length(txt))]
    }
}

# Add new Imports section
txt <- c(txt, paste("Imports:\n    ", paste(requirements, collapse = ",\n    ")))

writeLines(txt, "DESCRIPTION")
roxygen2::roxygenise(clean=TRUE)

### SECTION 4  - BUILD PACKAGE ###
message("Building glenforge library...")
message(sprintf("Version: %s.%s", packagemeta$Packageversion, packagemeta$BuildNo))
message(paste("Libpath:", packagemeta$Output_directory))
withr::with_libpaths(
  packagemeta$Output_directory, devtools::install(dependencies = TRUE, keep_source = TRUE)
)
devtools::check()
devtools::load_all()
devtools::document()

#pkgdown::build_site()

### SECTION 5  - UPDATE METADATA ###
setwd("..")
BuildNo <- packagemeta$BuildNo + 1 # Increment the build number
txt <- readLines("package_build_manifest.yaml") # update version in DESCRIPTION
txt <- stringr::str_replace(txt, "BuildNo:.+", paste("BuildNo:", BuildNo))
writeLines(txt, "package_build_manifest.yaml")

### SECTION 6  - CREATE HTML DOCUMENTATION ###
doc_path <- file.path(packagemeta$Output_directory, "glenforge", "html")
message("Documentation path: ", doc_path)
docs <- fs::dir_ls(doc_path, recurse = TRUE)
fs::dir_create("documentation")  # Create the folder if it doesn't exist
# Copy HTML files
done <- purrr::map(docs, ~fs::file_copy(., file.path("documentation", basename(.)), overwrite = TRUE))


print("COMPLETED EXECUTION SUCCESSFULLY")
