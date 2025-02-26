# Use example data
pobs <- enw_example("preprocessed")

test_that("enw_missing produces the expected model components", {
  expect_snapshot({
    miss <- enw_missing(formula = ~ 1 + rw(week), data = pobs)
    miss$inits <- NULL
    miss
  })
  miss <- enw_missing(~ 1 + (1 | day_of_week), data = pobs)
  expect_named(
    miss$init(miss$data, miss$priors)(),
    c("miss_beta", "miss_beta_sd")
  )
})

test_that("enw_missing fails when insupported options are used", {
  expect_error(enw_missing(~0, data = pobs))
  pobs$missing_reference[[1]] <- data.table::data.table()
  expect_error(enw_missing(data = pobs))
})
