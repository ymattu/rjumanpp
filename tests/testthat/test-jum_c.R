context("Simple Morphological Analysis")

test_that("wakatigaki", {
  res <- jum_c("私はミルクティを飲みます")
  word <- "ミルクティ"

  expect_equal(length(res), 6)
  expect_equal(res[[3]][[1]], word)
  expect_equal(names(res[[3]]), "名詞")
})

test_that("wakatigaki pos", {
  res <- jum_c("私はミルクティを飲みます", pos = "名詞")
  word <- "ミルクティ"

  expect_equal(length(res), 2)
  expect_equal(res[[2]][[1]], word)
  expect_equal(names(res[[2]]), "名詞")
})

test_that("wakatigaki rediect", {
  res <- jum_c("私はミルクティを飲みます", redirect = TRUE)
  word <- "ミルクティー"
  morph <- "名詞"

  res2 <- jum_c("私はミルクティを飲みます", pos = "名詞", redirect = TRUE)

  expect_equal(length(res), 6)
  expect_equal(res[[3]][[1]], word)
  expect_equal(names(res[[3]]), morph)

  expect_equal(length(res2), 2)
  expect_equal(res2[[2]][[1]], word)
  expect_equal(names(res2[[2]]), morph)
})

