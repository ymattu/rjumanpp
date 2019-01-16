.onAttach <- function(...) {
  whichjuman <- system("which jumanpp", intern = T)
  if (is.null(whichjuman)) {stop("JUMAN++ is NOT installed. Please install it.")}
  packageStartupMessage("This package depends on JUMAN++ 1.02")
}

.onLoad <- function(libname, pkgname) {
  # Create Option Environment -----------------------------------------------
  package_option_env <- new.env(parent = emptyenv())
  package_namespace <- asNamespace(pkgname)
  assign(".options", package_option_env, envir = package_namespace)
}
