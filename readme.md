# glenforge

| A collection of custom R functions and utilities developed for API extracting software and shinyapps | ![Icon](https://raw.githubusercontent.com/uaineteine/glenforge/refs/heads/master/icon/icon.png) |
|----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|

**Author:** Daniel Stamer-Squair

## Installation

You can install the development version of glenforge from GitHub using the `devtools` package:

```r
# Install devtools if you haven't already
if (!require("devtools")) install.packages("devtools")

# Install glenforge
devtools::install_github("uaineteine/glenforge")
```

## Dependencies

This package requires the following R packages:
- configr
- curl
- rstudioapi
- parallel
- utils
- purrr
- stringr
- fs
- withr
- devtools
- roxygen2
- yaml
- tidyverse

## Building the Package

To build the package locally, follow these steps:

1. **Update the Manifest File**: Before building, ensure that the `package_build_manifest.yaml` file is correctly configured. This file contains metadata about the package, such as the version and build number. You can update the `Packageversion` and `BuildNo` fields as needed.

   Example:
   ```yaml
   Package: glenforge
   Packageversion: 1.0.0
   BuildNo: 1
   Output_directory: "path/to/output"
   ```

2. **Run the Build Script**: Execute the `build.bat` file to generate the package, update documentation, and increment the build number. This batch file will automatically run the `build.r` script.

   ```bash
   build.bat
   ```

3. **Check the Output**: The built package and documentation will be placed in the directory specified in the `Output_directory` field of the manifest.

## Documentation

For detailed documentation of all functions, please refer to the package manual which is generated using roxygen2.

## License

This package is licensed under the GPL-3 license.
