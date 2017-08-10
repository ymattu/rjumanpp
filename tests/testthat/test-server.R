context("JUMAN++ Server mode check")

test_that("use server", {
  hd <- jum_start_server()

  res <- jum_wakati("私はミルクティを飲みます", server = TRUE)
  wakati <- "私 は ミルクティ を 飲み ます"
  expect_equal(res, wakati)

  jum_close_server()
})

test_that("dont use server", {
  res2 <- jum_wakati("私はミルクティを飲みます", server = FALSE)
  wakati2 <- "私 は ミルクティ を 飲み ます"
  expect_equal(res2, wakati2)
})
