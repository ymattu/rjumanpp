##' Simple Morphological Analysis
##' @param input input text
##' @return named list of Morphological Analysis
##' @export
##' @importFrom magrittr %>%
##' @importFrom stringr str_subset str_split
rjumanpp_c <- function (input) {
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

  # 形態素
  res_c <- unlist(sapply(res_list, function(x){
    return(x[1])
  }))

  # 品詞
  res_names <- unlist(sapply(res_list, function(x){
    return(x[4])
  }))

  # 出力
  res_c_list <- list()
  for (i in 1:length(res)) {
    res_c_list[[i]] <- res_c[i]
    names(res_c_list[[i]]) <- res_names[i]
  }

  return(res_c_list)
}
