# Run every companion script the way a student would: in a fresh R
# process, in a folder holding the script and copies of the CSVs.
# A script that stops with an error fails the check.
#
#   Rscript r_companion/tools/check_scripts.R      from the repo root

args <- commandArgs(trailingOnly = FALSE)
here <- dirname(normalizePath(sub("^--file=", "",
                                  grep("^--file=", args, value = TRUE))))
companion <- dirname(here)
data_dir <- file.path(dirname(companion), "data")

scripts <- sort(list.files(file.path(companion, "scripts"),
                           pattern = "\\.R$", full.names = TRUE))
if (length(scripts) == 0) stop("no scripts found in r_companion/scripts")

failed <- character(0)
for (script in scripts) {
  work <- tempfile("companion_")
  dir.create(work)
  file.copy(list.files(data_dir, pattern = "\\.csv$", full.names = TRUE),
            work)
  file.copy(script, work)
  log <- file.path(work, "log.txt")
  # system2 runs in the current directory, so run it from the work folder.
  status <- local({
    old <- setwd(work)
    on.exit(setwd(old))
    system2(file.path(R.home("bin"), "Rscript"),
            c("--vanilla", shQuote(basename(script))),
            stdout = log, stderr = log)
  })
  if (status == 0) {
    cat("PASS", basename(script), "\n")
  } else {
    cat("FAIL", basename(script), "\n")
    cat(tail(readLines(log), 15), sep = "\n")
    failed <- c(failed, basename(script))
  }
  unlink(work, recursive = TRUE)
}

if (length(failed) > 0) quit(status = 1)
