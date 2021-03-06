##' Start JUMAN++ server.
##'
##' @param host.name host name if necessary
##' @param port port number if necessary. By default, 12000
##' @export
jum_start_server <- function(host.name = NULL, port = NULL) {
  rubypath <- Sys.which("ruby")
  if(identical(rubypath, "")){
    stop("PATH to Ruby not found. Please check Ruby is installed.")
  }

  pid <- system("ps -aefw | grep 'ruby/server.rb' | grep -v ' grep ' | awk '{print $2}'",
                intern = TRUE)

  if(length(pid) != 0) {
    stop("JUMAN++ server is already running.")
  }

  bg <- "nohup"
  rb_file <- system.file("ruby/server.rb", package = "rjumanpp")
  cmd <- "--cmd"
  jumanpp_option <- "--force-single-path"
  jumanpp <- paste("jumanpp", jumanpp_option)
  jum <- shQuote(jumanpp)

  if(is.null(host.name) == FALSE) {
    host <- paste("-- host", host.name)
  } else{
    host <- ""
  }

  if(is.null(port) == FALSE) {
    port_num <- paste("-- port", port)
  } else{
    port_num <- ""
  }

  server_command <- paste(bg,
                          rubypath,
                          rb_file,
                          cmd,
                          jum,
                          host,
                          port_num,
                          "> /dev/null 2>&1",
                          "&")
  system(server_command)

  # Register Server Information ---------------------------------------------
  .options$server_host <- host
  .options$server_port <- port
}

##' Close JUMAN++ server.
##'
##' @export
jum_close_server <- function() {
  pid <- system("ps -aefw | grep 'ruby/server.rb' | grep -v ' grep ' | awk '{print $2}'",
                intern = TRUE)

  if(length(pid) == 0) {
    stop("JUMAN++ server is not running.")
  }

  cmd <- paste("kill", pid)
  system(cmd)
}
