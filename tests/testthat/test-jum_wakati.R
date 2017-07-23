context("Simple Wakatigaki")

test_that("wakatigaki", {
  res <- jum_wakati("私はミルクティを飲みます")
  wakati <- "私 は ミルクティ を 飲み ます"
  expect_equal(res, wakati)
})

test_that("wakatigaki pos", {
  res <- jum_wakati("私はミルクティを飲みます", pos = "名詞")
  wakati <- "私 ミルクティ"
  expect_equal(res, wakati)
})

test_that("wakatigaki redirect", {
  res <- jum_wakati("私はミルクティを飲みます", redirect = TRUE)
  wakati <- "私 は ミルクティー を 飲み ます"

  res2 <- jum_wakati("私はミルクティを飲みます", pos = "名詞", redirect = TRUE)
  wakati2 <- "私 ミルクティー"

  expect_equal(res, wakati)
  expect_equal(res2, wakati2)
})


