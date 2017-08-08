pipe_files <- function(){
  errTfile <- tempfile(fileext = ".txt")
  write(character(), errTfile)
  outTfile <- tempfile(fileext = ".txt")
  write(character(), outTfile)
  list(out = outTfile, err = errTfile)
}

unix_spawn_tofile <- function(command, args, outfile, errfile, ...){
  tfile <- tempfile(fileext = ".sh")
  write("#!/bin/sh", tfile)
  write(paste(c(shQuote(command), args, ">",
                shQuote(outfile), "2>", shQuote(errfile)), collapse = " "),
        tfile, append = TRUE)
  Sys.chmod(tfile)
  subprocess::spawn_process(tfile, ...)
}
