context("Special Pattern")

test_that("only spaces", {
  res <- jum_wakati("   ")
  res2 <- jum_wakati("   ", pos = "名詞")
  res3 <- jum_wakati("                 ")
  res4 <- jum_wakati("                 ", pos = "名詞")
  wakati <- ""

  expect_equal(res, wakati)
  expect_equal(res2, wakati)
  expect_equal(res3, wakati)
  expect_equal(res4, wakati)
})

test_that("only spaces, server mode", {
  jum_start_server()
  res <- jum_wakati("   ", server = TRUE)
  res2 <- jum_wakati("   ", server = TRUE, pos = "名詞")
  res3 <- jum_wakati("               ", server = TRUE)
  res4 <- jum_wakati("               ", server = TRUE, pos = "名詞")
  wakati <- ""
  jum_close_server()

  expect_equal(res, wakati)
  expect_equal(res2, wakati)
  expect_equal(res3, wakati)
  expect_equal(res4, wakati)
})

test_that("new line code", {
  jum_start_server()
  res <- jum_wakati("私は大学院生です \n", server = TRUE, pos = "名詞")
  res2 <- jum_wakati("私は大学院生です \n", server = FALSE, pos = "名詞")
  wakati <- "私 大学 院生"
  jum_close_server()

  expect_equal(res, wakati)
  expect_equal(res2, wakati)
})

test_that("space at the start and end", {
  jum_start_server()
  res <- jum_wakati("私は大学院生です ", server = TRUE, pos = "名詞")
  res2 <- jum_wakati("私は大学院生です ", server = FALSE, pos = "名詞")
  res3 <- jum_wakati("   私は大学院生です ", server = FALSE, pos = "名詞")
  wakati <- "私 大学 院生"
  jum_close_server()

  expect_equal(res, wakati)
  expect_equal(res2, wakati)
  expect_equal(res3, wakati)
})
