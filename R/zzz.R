.onAttach <- function(...) {
  whichjuman <- system("which jumanpp", intern = T)
  if (is.null(whichjuman)) {stop("JUMAN++ is NOT installed. Please install it.")}
  packageStartupMessage("This package depends on JUMAN++ 1.02")
}
