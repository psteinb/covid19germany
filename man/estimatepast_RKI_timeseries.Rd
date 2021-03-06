% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimatepast_RKI_timeseries.R
\name{estimatepast_RKI_timeseries}
\alias{estimatepast_RKI_timeseries}
\title{estimatepast_RKI_timeseries}
\usage{
estimatepast_RKI_timeseries(
  x,
  ...,
  prop_death,
  mean_days_until_death,
  doubling_time
)
}
\arguments{
\item{x}{data.frame. RKI data as downloaded with \code{\link{get_RKI_timeseries}}}

\item{...}{variable names. One or multiple grouping columns of x, so Bundesland, Landkreis, Gender or Age}

\item{prop_death}{numeric. Probability of death}

\item{mean_days_until_death}{integer. Mean number of days from infection to death (in case of death)}

\item{doubling_time}{numeric. Mean number of days for the number of infected to double}
}
\description{
This function implements two sequential methods to estimate the real number of infected based on the current 
cumulative death count as presented by Tomas Pueyo in this 
(\url{https://medium.com/@tomaspueyo/coronavirus-act-today-or-people-will-die-f4d3d9cd99ca}) blog post.
}
\details{
\emph{EstimationCumNumberIllPast}, the actual number of infected, is calculated with the current 
cumulative number of deaths \strong{CumNumberDead}, the death rate \strong{prop_death} and the average number 
of days \strong{mean_days_until_death} from infection to death (in case of death). 
This approach only allows to estimate values at least \strong{mean_days_until_death} days in the past.
\emph{EstimationCumNumberIllPresent} employs the last value in \emph{EstimationCumNumberIllPast} to estimate the number 
of actually infected people beyond the \strong{mean_days_until_death} threshold with a simple exponential growth model considering
\strong{doubling_time}.
With \emph{EstimationCumNumberIllPast}, \emph{EstimationCumNumberIllPresent} and \strong{prop_death} we can calculate an 
expected number of deaths \emph{EstimationCumNumberDeadFuture}.
}
\examples{
\donttest{
rki_timeseries <- get_RKI_timeseries()

estimatepast_RKI_timeseries(
  rki_timeseries, 
  prop_death = 0.01, mean_days_until_death = 17, doubling_time = 4
)

estimatepast_RKI_timeseries(
  rki_timeseries, Bundesland, Gender, 
  prop_death = 0.03, mean_days_until_death = 17, doubling_time = 3
)
}

}
