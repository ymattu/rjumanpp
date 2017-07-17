##' jumanpp wakatigaki
##' @param input input text
##' @param pattern extract pattern i.e. "名詞|動詞"
##' @return seperated words of the input text
##' @export
##' @importFrom magrittr %>%
##' @importFrom stringr str_subset str_split str_detect
jumanpp_wakati <- function (input, pattern = NULL){

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
    res_morph <- unlist(sapply(res_list, function(x){return(x[1])}))
  } else {
    res_morph <- unlist(sapply(res_list, function(x){
      if(str_detect(x[4], pattern) == TRUE){
        return(x[1])
      }
    }))
  }

  wakati <- paste(res_morph, collapse = " ")

  return(wakati)

}
