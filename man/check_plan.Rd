% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check.R
\name{check_plan}
\alias{check_plan}
\title{Function \code{check_plan}}
\usage{
check_plan(plan = workplan(), targets = drake::possible_targets(plan),
  envir = parent.frame(), cache = drake::get_cache(verbose = verbose),
  verbose = TRUE)
}
\arguments{
\item{plan}{workflow plan data frame, possibly from
\code{\link{workplan}()}.}

\item{targets}{character vector of targets to make}

\item{envir}{environment containing user-defined functions}

\item{cache}{optional drake cache. See \code{\link{new_cache}()}}

\item{verbose}{logical, whether to log progress to the console.}
}
\value{
Invisibly return \code{plan}.
}
\description{
Check a workflow plan, etc. for obvious
errors such as circular dependencies and
missing input files.
}
\examples{
\dontrun{
load_basic_example() # Load drake's canonical example.
check_plan(my_plan) # Check the workflow plan dataframe for obvious errors.
unlink('report.Rmd') # Remove an import file mentioned in the plan.
check_plan(my_plan) # check_plan() tells you that 'report.Rmd' is missing.
}
}
\seealso{
\code{ink{workplan}}, \code{\link{make}}
}
