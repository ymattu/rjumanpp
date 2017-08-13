context("Special Pattern")

test_that("only spaces", {
  res <- jum_wakati("   ")
  wakati <- ""

  expect_equal(res, wakati)
})

test_that("only spaces, server mode", {
  jum_start_server()
  res <- jum_wakati("   ", server = TRUE)
  wakati <- ""
  jum_close_server()

  expect_equal(res, wakati)
})
