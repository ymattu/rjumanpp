##' Simple Morphological Analysis
##'
##' @param input input text
##' @param pos extract pattern i.e. "名詞|動詞"
##' @param redirect Whether or not redirect to Wikipedia redirect. Default is FALSE.
##' @return named list of Morphological Analysis
##' @export
##' @importFrom magrittr %>%
##' @importFrom stringr str_subset str_split str_detect str_replace
jum_c <- function (input, pos = NULL, redirect = FALSE) {
  res_list <- jum_text(input = input)

  # morph
  # select class
    if(is.null(pos) == TRUE) {
    res_morph <- unlist(sapply(res_list, function(x){
      # Wikipedia redirect(orthographical variants)
      if (redirect != TRUE) {
        return(x[1])
      } else
        if (str_detect(x[12], "Wikipedia") == TRUE){
          redirect_word <- str_replace(x[13], "Wikipedia\u30ea\u30c0\u30a4\u30ec\u30af\u30c8:", "") %>% # Wikioediaリダイレクト
            str_replace("\\\"", "")
          return(redirect_word)
        } else
        {
          return(x[1])
        }
    }
    ))
  } else {
    res_morph <- unlist(sapply(res_list, function(x){
      if(str_detect(x[4], pos) == TRUE){
        # Wikipedia redirect(orthographical variants)
        if (redirect != TRUE) {
          return(x[1])
        } else
          if (str_detect(x[12], "Wikipedia") == TRUE){
            redirect_word <- str_replace(x[13], "Wikipedia\u30ea\u30c0\u30a4\u30ec\u30af\u30c8:", "") %>% # Wikioediaリダイレクト
              str_replace("\\\"", "")
            return(redirect_word)
          } else
          {
            return(x[1])
          }
      }
    }))
  }


  # class
  res_names <- unlist(sapply(res_list, function(x){
    if(is.null(pos) == TRUE) {
      res_names <- unlist(sapply(res_list, function(x){
        return(x[4])
      }))
  } else {
    res_names <- unlist(sapply(res_list, function(x){
      if(str_detect(x[4], pos) == TRUE){
        return(x[4])
      }
    }))
  }
  }))

  # output
  res_c_list <- list()
  for (i in 1:length(res_morph)) {
    res_c_list[[i]] <- res_morph[i]
    names(res_c_list[[i]]) <- res_names[i]
  }

  return(res_c_list)
}
