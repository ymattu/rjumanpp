##' Simple result of JUMAN++(file)
##'
##' @param filename input file
##' @param server if TRUE, JUMAN++ server is used. In such a case, you have to \command{jum_start_server} to start JUMAN++ server.
##' @return result of JUMAN++
##' @export
##' @importFrom magrittr %>%
##' @importFrom stringr str_subset
##' @importFrom purrr map
jum_file <- function (filename, server = FALSE) {

  if (!file.exists(filename)) {
        stop("file not found")
    }
    if (file.info(filename)$isdir) {
        stop("this is directory. Please input file name")
    }

  # input command
  if(server == TRUE) {
    pid <- system("ps -aefw | grep 'ruby/server.rb' | grep -v ' grep ' | awk '{print $2}'",
                   intern = TRUE)
    if(length(pid) == 0) {
      stop("JUMAN++ server is not running.")
    }

    rb_client <- system.file("ruby/client.rb", package = "rjumanpp")

    hostn <- system("ps -aefw | grep 'ruby/server.rb' | grep -v ' grep ' | awk '{print $15}'",
                    intern = TRUE)
    if(identical(hostn, "")) {
      host <- ""
    } else {
      host <- paste("--host", hostn)
    }

    portn <- system("ps -aefw | grep 'ruby/server.rb' | grep -v ' grep ' | awk '{print $18}'",
                    intern = TRUE)
    if(identical(portn, "")) {
      port <- ""
    } else {
      port <- paste("--host", portn)
    }

    command <- paste("cat", filename, "| ruby", rb_client, host, port)
  } else {
    command <- paste("cat", filename, "| jumanpp --force-single-path")
  }

  # result from JUMAN++
  res <- system(command, intern = T) %>%
    str_subset("^(?!EOS)") # delete EOS

  # make a list
  res_list <- lapply(res, function(x){
    out <- unlist(str_split(x, pattern = " "))
    return(unlist(out))
  })

  return(res_list)

}


##' Simple result of JUMAN++(text)
##'
##' @param input input text
##' @param server if TRUE, JUMAN++ server is used. In such a case, you have to \command{jum_start_server} to start JUMAN++ server.
##' @return result of JUMAN++
##' @export
##' @importFrom magrittr %>%
##' @importFrom stringr str_subset
jum_text <- function (input, server = FALSE) {
  if (!is.character(input)) {
    input <- as.character(input)
  }
  if (nchar(input) < 1) {
    stop("first argument must be specified")
  }

  input <- shQuote(input)

  # input command
  if(server == TRUE) {
    if ("server_host" %in% ls(.options) &&
        "server_port" %in% ls(.options)) {
      host <- .options$server_host
      port <- .options$server_post
    } else {
      pid <- system("ps -aefw | grep 'ruby/server.rb' | grep -v ' grep ' | awk '{print $2}'",
                    intern = TRUE)
      if(length(pid) == 0) {
        stop("JUMAN++ server is not running.")
      }

      hostn <- system("ps -aefw | grep 'ruby/server.rb' | grep -v ' grep ' | awk '{print $15}'",
                      intern = TRUE)
      if(identical(hostn, "")) {
        host <- ""
      } else {
        host <- paste("--host", hostn)
      }

      portn <- system("ps -aefw | grep 'ruby/server.rb' | grep -v ' grep ' | awk '{print $18}'",
                      intern = TRUE)
      if(identical(portn, "")) {
        port <- ""
      } else {
        port <- paste("--host", portn)
      }
    }

    rb_client <- system.file("ruby/client.rb", package = "rjumanpp")

    command <- paste("echo", input, "| ruby", rb_client, host, port)
  } else {
    command <- paste("echo", input, "| jumanpp --force-single-path")
  }

  # result from JUMAN++
  res <- system(command, intern = T) %>%
    str_subset("^(?!EOS)") # delete EOS

  # make a list
  res_list <- res %>%
    map(function(x){
      out <- unlist(str_split(x, pattern = " "))
      return(out)
  })

  return(res_list)

}
