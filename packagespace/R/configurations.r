read_yaml_config <- function(config_path = "config.yaml", file_type = "yaml") {
  #' Read a config file with sanity checks
  #' @description Read YAML file with basic tests to ensure it has been loaded
  #' @param config_path string. Path to configuration file
  #' @param file_type string. Type of config file (yaml, json)
  #' @returns Loaded configuration file
  #' @export
  
  if (!file.exists(config_path)) {
    stop(paste("Cannot find", config_path, "- check path"))
  }
  
  config <- configr::read.config(config_path, file_type = file_type)
  
  if (typeof(config) != "list") {
    stop(paste("Failed to load", config_path, "- check config syntax"))
  }
  
  return(config)
}
