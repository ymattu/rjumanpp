##' Simple result of JUMAN++(file)
##'
##' @param filename input file
##' @return result of JUMAN++
##' @export
##' @importFrom magrittr %>%
jum_file <- function (filename) {

  if (!file.exists(filename)) {
        stop("file not found")
    }
    if (file.info(filename)$isdir) {
        stop("this is directory. Please input file name")
    }

  command <- paste("cat", filename, "| jumanpp --force-single-path")

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
##' @return result of JUMAN++
##' @export
##' @importFrom magrittr %>%
jum_text <- function (input) {
  if (!is.character(input)) {
    input <- as.character(input)
  }
  if (nchar(input) < 1) {
    stop("first argument must be specified")
  }

  # command <- paste("echo", input, "| jumanpp --force-single-path")
  # command <- paste("echo", input, "| ruby /Users/matsumura/Downloads/jumanpp-1.02/script/client.rb")
  command <- paste("echo", input, "| ruby /Users/matsumura/Downloads/jumanpp-1.02/script/client.rb")

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
