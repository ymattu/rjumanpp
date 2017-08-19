##' Wakatigaki by JUMAN++
##'
##' @description
##' This function  make a Japanese sentence with a space between words.
##'
##' @param input input text
##' @param pos extract pattern i.e. "名詞|動詞"
##' @param redirect Whether or not redirect to Wikipedia redirect. Default is FALSE.
##' @param mypref Default being 0, the same morphemic forms that appear on the text are returned. If 1 is designated, the basic forms of them are instead.
##' @param server if TRUE, JUMAN++ server is used. In such a case, you have to \command{jum_start_server} to start JUMAN++ server.
##' @return wakatigaki of the input text
##' @importFrom magrittr %>% %<>%
##' @importFrom stringr str_c str_replace str_replace_all str_trim
##' @importFrom purrr map_chr
##' @export
jum_wakati <- function (input,
                        mypref = 0,
                        pos = NULL,
                        redirect = FALSE,
                        server = FALSE){
  if (!is.character(input)) {
    input <- as.character(input)
  }
  if (nchar(input) < 1) {
    stop("first argument must be specified")
  }

  wakati <- jum_c(input = input, mypref = mypref, pos = pos, redirect = redirect, server = server) %>%
    map_chr(function(x) {return(x[[1]])}) %>%
    str_c(collapse = " ")


  if(str_detect(wakati, "\\\\") == TRUE) {
    wakati %<>%
      str_replace_all("\\\\", "")
  }

  return(str_trim(wakati))

}
