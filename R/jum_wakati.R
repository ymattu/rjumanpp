##' Wakatigaki by JUMAN++
##'
##' @description
##' This function  make a Japanese sentence with a space between words.
##'
##' @param input input text
##' @param pos extract pattern i.e. "名詞|動詞"
##' @param redirect Whether or not redirect to Wikipedia redirect. Default is FALSE.
##' @return wakatigaki of the input text
##' @importFrom magrittr %>%
##' @importFrom stringr str_subset str_split str_detect str_replace
##'
##' @export
jum_wakati <- function (input, pos = NULL, redirect = FALSE){
  if (!is.character(input)) {
    input <- as.character(input)
  }
  if (nchar(input) < 1) {
    stop("first argument must be specified")
  }

  res <- jum_c(input = input, pos = pos, redirect = redirect)

  res_word <- sapply(res, function(x){return(x[[1]])})
  wakati <- paste(res_word, collapse = " ")

  return(wakati)

}
