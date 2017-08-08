##' Start JUMAN++ server.
##'
##' @param host.name host name if necessary
##' @param port port number if necessary. Default is 12000
##' @export
jum_start_server <- function(host.name = NULL, port = NULL) {
  rubypath <- Sys.which("ruby")
  if(identical(rubypath, "")){
    stop("PATH to Ruby not found. Please check Ruby is installed.")
  }

  rb_file <- system.file("inst/server.rb", package = "rjumanpp")
  command <- paste("ruby", rb_file, "--cmd", "'jumanpp --force-single-path'")
  return(command)
}

