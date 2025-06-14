create_message <- function(package_name, function_name, msg) {
  #' @title Create a Message
  #' @description This function creates a message string with the package name, function name, and a custom message.
  #' @param package_name A string that represents the name of the package.
  #' @param function_name A string that represents the name of the function.
  #' @param msg A string that represents the custom message.
  #' @return A string that represents the created message.
  #' @export
  sprintf("[%s::%s] %s", package_name, function_name, msg) %>%
    return()
}

#' @title Create a Message with Automatic Function Name
#' @description This function creates a message string with the package name, the name of the calling function, and a custom message.
#' @param msg A string that represents the custom message.
#' @return A string that represents the created message.
#' @export
create_message_auto <- function(msg) {
  function_name <- as.character(sys.call(-1)[1])
  create_message("", function_name, msg) %>%
    return()
}
