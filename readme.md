# glenforge

<div style="display: flex; align-items: center;">
  <div style="flex: 1;">
    A collection of custom R functions and utilities developed by Daniel SS for data analysis and statistical computing.
  </div>
  <div>
    <img src="https://raw.githubusercontent.com/uaineteine/glenforge/refs/heads/master/icon/icon.png" alt="Icon" style="width: 128px; height: 128px;">
  </div>
</div>

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

## Documentation

For detailed documentation of all functions, please refer to the package manual which is generated using roxygen2.

## License

This package is licensed under the GPL-3 license.
