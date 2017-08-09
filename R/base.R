##' Simple result of JUMAN++(file)
##'
##' @param filename input file
##' @param server if TRUE, JUMAN++ server is used. In such a case, you have to \command{jum_start_server} to start JUMAN++ server.
##' @return result of JUMAN++
##' @export
##' @importFrom magrittr %>%
jum_file <- function (filename, server = FALSE) {

  if (!file.exists(filename)) {
        stop("file not found")
    }
    if (file.info(filename)$isdir) {
        stop("this is directory. Please input file name")
    }

  # input command
  if(server == TRUE) {
    rb_client <- system.file("ruby/client.rb", package = "rjumanpp")
    command <- paste("cat", filename, "| ruby", rb_client)
  } else {
    command <- paste("cat", filename, "| jumanpp --force-single-path")
  }

  # result from JUMAN++
  res <- system(command, intern = T) %>%
    str_subset("^(?!EOS)") # EOSを削除

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
jum_text <- function (input, server = FALSE) {
  if (!is.character(input)) {
    input <- as.character(input)
  }
  if (nchar(input) < 1) {
    stop("first argument must be specified")
  }

  # input command
  if(server == TRUE) {
    rb_client <- system.file("inst/client.rb", package = "rjumanpp")
    command <- paste("echo", input, "| ruby", rb_client)
  } else {
    command <- paste("echo", input, "| jumanpp --force-single-path")
  }

  # result from JUMAN++
  res <- system(command, intern = T) %>%
    str_subset("^(?!EOS)") # EOSを削除

  # make a list
  res_list <- lapply(res, function(x){
    out <- unlist(str_split(x, pattern = " "))
    return(unlist(out))
  })

  return(res_list)

}
