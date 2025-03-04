test_that("enw_filter_reference_dates filters as expected", {
  expect_error(enw_filter_reference_dates(
    germany_covid19_hosp,
    include_days = 10, earliest_date = "2021-09-01"
  ))
  filt_date <- enw_filter_reference_dates(
    germany_covid19_hosp,
    earliest_date = "2021-09-01"
  )
  expect_equal(max(filt_date$report_date), as.IDate("2021-10-20"))
  expect_equal(max(filt_date$reference_date), as.IDate("2021-10-20"))
  expect_equal(min(filt_date$report_date), as.IDate("2021-09-01"))
  expect_equal(min(filt_date$reference_date), as.IDate("2021-09-01"))
  filt_days <- enw_filter_reference_dates(
    germany_covid19_hosp,
    include_days = 10
  )
  expect_equal(max(filt_days$report_date), as.IDate("2021-10-20"))
  expect_equal(max(filt_days$reference_date), as.IDate("2021-10-20"))
  expect_equal(min(filt_days$report_date), as.IDate("2021-10-10"))
  expect_equal(min(filt_days$reference_date), as.IDate("2021-10-10"))

  expect_error(enw_filter_reference_dates(
    germany_covid19_hosp,
    remove_days = 10, latest_date = "2021-10-01"
  ))
  filt_date <- enw_filter_reference_dates(
    germany_covid19_hosp,
    latest_date = "2021-10-01"
  )
  expect_equal(max(filt_date$report_date), as.IDate("2021-10-20"))
  expect_equal(max(filt_date$reference_date), as.IDate("2021-10-01"))
  expect_equal(min(filt_date$report_date), as.IDate("2021-04-06"))
  expect_equal(min(filt_date$reference_date), as.IDate("2021-04-06"))
  filt_days <- enw_filter_reference_dates(
    germany_covid19_hosp,
    remove_days = 10
  )
  expect_equal(max(filt_days$report_date), as.IDate("2021-10-20"))
  expect_equal(max(filt_days$reference_date), as.IDate("2021-10-10"))
  expect_equal(min(filt_days$report_date), as.IDate("2021-04-06"))
  expect_equal(min(filt_days$reference_date), as.IDate("2021-04-06"))
})

test_that("enw_filter_reference_dates filters as expected when data is present
           with missing reference dates", {
  nat_germany_hosp <-
    germany_covid19_hosp[location == "DE"][age_group %in% "00+"]
  nat_germany_hosp <- enw_complete_dates(
    nat_germany_hosp,
    by = c("location", "age_group")
  )
  filt_days <- enw_filter_reference_dates(
    nat_germany_hosp,
    include_days = 10
  )
  expect_equal(max(filt_days$report_date), as.IDate("2021-10-20"))
  expect_equal(
    max(filt_days$reference_date, na.rm = TRUE), as.IDate("2021-10-20")
  )
  expect_equal(min(filt_days$report_date), as.IDate("2021-10-10"))
  expect_equal(
    min(filt_days$reference_date, na.rm = TRUE), as.IDate("2021-10-10")
  )
  filt_date <- enw_filter_reference_dates(
    nat_germany_hosp,
    earliest_date = "2021-09-01"
  )
  expect_equal(max(filt_date$report_date), as.IDate("2021-10-20"))
  expect_equal(
    max(filt_date$reference_date, na.rm = TRUE), as.IDate("2021-10-20")
  )
  expect_equal(min(filt_date$report_date), as.IDate("2021-09-01"))
  expect_equal(
    min(filt_date$reference_date, na.rm = TRUE), as.IDate("2021-09-01")
  )
})
