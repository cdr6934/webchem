context("cir")

chk_cir <- function(){
  qurl <- 'http://cactus.nci.nih.gov/chemical/structure/Triclosan/cas/xml'
  Sys.sleep(1.5)
  cont <- try(getURL(qurl, .encoding = 'UTF-8', .opts = list(timeout = 2)),
              silent = TRUE)
  if (inherits(cont, 'try-error'))
    skip("Server is down!")
}

test_that("cir()", {
  chk_cir()

  expect_equal(cir_query('Triclosan', 'mw', verbose = FALSE), '289.5451')
  expect_error(cir_query(c('Triclosan', 'Benzol'), 'mw'))
  expect_equal(cir_query('xxxxxxx', 'mw', verbose = FALSE), NA)
  expect_warning(cir_query(NA, 'mw', verbose = FALSE))
  chk_cir()
  expect_equal(cir_query("3380-34-5", 'stdinchikey', resolver = 'cas_number', verbose = FALSE), "InChIKey=XEFQLINVKFYRCS-UHFFFAOYSA-N")
  chk_cir()
  expect_true(length(cir_query('Triclosan', 'cas', verbose = FALSE)) > 1)
  chk_cir()
  expect_equal(length(cir_query('Triclosan', 'cas', first = TRUE, verbose = FALSE)), 1)
})
