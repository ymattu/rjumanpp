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
  cmd <- "--cmd"
  jum <- shQuote("jumanpp --force-single-path")

  pfile <- pipe_files()

  outres <- unix_spawn_tofile(rubypath, args = c(rb_file, cmd, jum),
                           pfile[["out"]], pfile[["err"]])
  if(!is.na(subprocess::process_return_code(outres))){
    stop("JUMAN++ server couldn't be started",
         subprocess::process_read(outres, "stderr"))
  }
  return(outres)
}

##' Close JUMAN++ server.
##'
##' @param handle Process handle obtained from \code{jum_start_server()}
##' @importFrom subprocess process_kill
##' @export
jum_close_server <- function(handle) {
  process_kill(handle)
}
