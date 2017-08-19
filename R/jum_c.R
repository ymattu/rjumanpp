##' Simple Morphological Analysis
##'
##' @param input input text
##' @param mypref Default being 0, the same morphemic forms that appear on the text are returned. If 1 is designated, the basic forms of them are instead.
##' @param pos extract pattern i.e. "名詞|動詞"
##' @param redirect Whether or not redirect to Wikipedia redirect. Default is FALSE.
##' @param server if TRUE, JUMAN++ server is used. In such a case, you have to \command{jum_start_server} to start JUMAN++ server.
##' @return named list of Morphological Analysis
##' @export
##' @importFrom magrittr %>%
##' @importFrom stringr str_subset str_split str_detect str_replace
##' @importFrom purrr map map_chr
jum_c <- function (input,
                   mypref = 0,
                   pos = NULL,
                   redirect = FALSE,
                   server = FALSE) {
  res_list <- jum_text(input = input, server = server)

  if (!(mypref %in% c(0, 1))) {
    stop("Please specify 0 or 1 in mypref")
  } else if (mypref == 0) {
    app <- 1
  } else {
    app <- 3
  }

  if(length(res_list) == 0) {
    return("")
  }

  # morph
  # select class
  if(is.null(pos) == TRUE) {
      res_morph <- unlist(
        res_list %>%
          map_chr(function(x){
            # Wikipedia redirect(orthographical variants)
            if (redirect != TRUE) {
              return(x[app])
              } else if (is.na(str_detect(x[13], "\u30ea\u30c0\u30a4\u30ec\u30af\u30c8"))) {
                return(x[app])
                } else if (str_detect(x[13], "\u30ea\u30c0\u30a4\u30ec\u30af\u30c8") == TRUE ){
                  redirect_word <- str_replace(x[13], "Wikipedia\u30ea\u30c0\u30a4\u30ec\u30af\u30c8:", "") %>% # Wikioediaリダイレクト
                    str_replace("\\\"", "")
                  return(redirect_word)
                  } else {
                    return(x[app])
                  }
            }
            ))
      } else {
        res_morph <- unlist(
          res_list %>%
            map(function(x){

              if(x[1] %in% c(NA, "", "\\")){
                return("")
                }

              if(str_detect(x[4], pos) == TRUE){
                # Wikipedia redirect(orthographical variants)
                if (redirect != TRUE) {
                  return(x[app])
                  } else if (is.na(str_detect(x[13], "\u30ea\u30c0\u30a4\u30ec\u30af\u30c8"))) {
                    return(x[app])
                    } else if (str_detect(x[13], "\u30ea\u30c0\u30a4\u30ec\u30af\u30c8") == TRUE ){
                      redirect_word <- str_replace(x[13], "Wikipedia\u30ea\u30c0\u30a4\u30ec\u30af\u30c8:", "") %>% # Wikioediaリダイレクト
                        str_replace("\\\"", "")
                      return(redirect_word)
                      } else {
                        return(x[app])
                        }
                } else {
                  return(list())
                  }
              }))
        }

  if(length(res_morph) == 0) {
    return("")
    }

  # class
  if(is.null(pos) == TRUE) {
    res_names <- unlist(
      res_list %>%
        map(function(x){
          if(x[1] %in% c(NA, "", "\\")){
            return("\u7279\u6b8a") # 特殊
          }
          return(x[4])
          }))
    } else {
      res_names <- unlist(
        res_list %>%
          map(function(x){
            if(x[1] %in% c(NA, "", "\\")){
              return("\u7279\u6b8a")
            }
            if(str_detect(x[4], pos) == TRUE){
              return(x[4])
              }
          }))
      }

  # output
  res_c_list <- list()
  for (i in 1:length(res_morph)) {
    res_c_list[[i]] <- res_morph[i]
    names(res_c_list[[i]]) <- res_names[i]
  }
  return(res_c_list)
}

