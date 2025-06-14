is_request_failure <- function(status) {
  #' Check for common failed request status codes
  #' @description Returns true if any common failed request status is encountered
  #' details These are for errors 403, 500, 502, 503 and 504
  #' @param status HTTP status code to check
  #' @return TRUE if the status is a common failed request, FALSE otherwise
  #' @export

  # List of common failed request status codes
  failed_statuses <- c("403", "500", "502", "503", "504")

  # Check if the status is in the list of common failed statuses
  return(status %in% failed_statuses)
}

api_request <- function(uri, handle = curl::new_handle()) {
  #' API requests with error handling using the curl package
  #' @description Basic function to retrieve data from an API using curl and handle common exceptions.
  #' @param uri A character string containing the URL to access the API.
  #' @param handle A curl handle object created using curl::new_handle(). It controls headers, proxies, and payload information.
  #' @return A list with two elements: (The payload if successful, warning message if not, NULL for other), the status of the request
  #' @details The function uses curl::curl_fetch_memory, which returns content in a list containing the payload and connection status.
  #'   - A status code of "200" signifies a successful connection, while any other code indicates an error.
  #'   - curl_fetch_memory returns an error in case of a timeout, which is handled using purrr::possibly().
  #' @export

  if (typeof(uri) != "character") {
    stop("[api_request] uri is not a character string!")
  }
  
  safe_fetch <- purrr::possibly(curl::curl_fetch_memory, otherwise = NULL)
  req <- safe_fetch(uri, handle = handle)
  
  if (is.null(req)) {
    res <- list(VALUE = NULL, STATE = 2, STATUS = NULL)
  } else if (req$status != 200) {
    res <- list(VALUE = rawToChar(req$content), STATE = 1, STATUS = req$status)
  } else {
    res <- list(VALUE = req$content, STATE = "0", STATUS = req$status)
  }
  
  return(res)
}
