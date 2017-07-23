##' jumanpp wakati
##' @param input input text
##' @param pattern extract pattern i.e. "名詞|動詞"
##' @param redirect Whether or not redirect to Wikipedia redirect. Default is FALSE.
##' @return wakatigaki of the input text
##' @importFrom magrittr %>%
##' @importFrom stringr str_subset str_split str_detect str_replace
jum_wakati <- function (input, pattern = NULL, redirect = FALSE){
  if (!is.character(input)) {
    input <- as.character(input)
  }
  if (nchar(input) < 1) {
    stop("first argument must be specified")
  }

  command <- paste("echo", input, "| jumanpp --force-single-path")

  # 素の結果を出力
  res <- system(command, intern = T) %>%
    str_subset("^(?!EOS)") # EOSを削除

  # リスト化
  res_list <- lapply(res, function(x){
    out <- unlist(str_split(x, pattern = " "))
    return(unlist(out))
  })

  # 品詞の指定があれば、指定したものだけを出力
  if(is.null(pattern) == TRUE) {
    res_morph <- unlist(sapply(res_list, function(x){
      # 表記ゆれ(Wikipediaリダイレクトに対応)
      if (redirect != TRUE) {
        return(x[1])
      } else
        if (str_detect(x[12], "Wikipedia") == TRUE){
          redirect_word <- str_replace(x[13], "Wikipediaリダイレクト:", "") %>%
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
      if(str_detect(x[4], pattern) == TRUE){
        # 表記ゆれ(Wikipediaリダイレクトに対応)
        if (redirect != TRUE) {
          return(x[1])
        } else
          if (str_detect(x[12], "Wikipedia") == TRUE){
            redirect_word <- str_replace(x[13], "Wikipediaリダイレクト:", "") %>%
              str_replace("\\\"", "")
            return(redirect_word)
          } else
          {
            return(x[1])
          }
      }
    }))
  }

  wakati <- paste(res_morph, collapse = " ")

  return(wakati)

}
