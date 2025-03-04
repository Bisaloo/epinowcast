
test_that("Nowcasts can be returned as expected", {
  expect_data_table(enw_example(type = "nowcast"))
  expect_data_table(enw_example(type = "now"))
})

test_that("Observations can be returned as expected", {
  expect_data_table(enw_example(type = "preprocessed_observations"))
})

test_that("Observations can be returned as expected", {
  expect_data_table(enw_example(type = "observations"))
})

test_that("Scripts can be returned as expected", {
  expect_type(enw_example(type = "s"), "character")
  expect_error(readLines(enw_example(type = "s")), NA)
})
