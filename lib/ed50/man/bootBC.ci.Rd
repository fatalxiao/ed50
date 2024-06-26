% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bootBC.ci.R
\name{bootBC.ci}
\alias{bootBC.ci}
\title{Estimate Confidence Interval of ED50 Using Isotonic Regression}
\usage{
bootBC.ci(tObserved, tBoot, conf = 0.95)
}
\arguments{
\item{tObserved}{the vector of observed statistics.}

\item{tBoot}{The matrix with R rows each of which is a bootstrap replicate of the statistics.}

\item{conf}{Confidence level.}
}
\description{
Estimate confidence interval of ED50 using isotonic regression based on bootstrap method.
}
\examples{
library(ed50)
library(boot)
pavaData <- preparePava(groupS)
bootResult <- boot(data = groupS,
              statistic = bootIsotonicRegression,
                      R = 10,
                    sim = 'parametric',
                ran.gen = bootIsotonicResample,
                    mle = list(baselinePava = pavaData,
                                  firstDose = 2.5,
                          PROBABILITY.GAMMA = 0.5),
           baselinePava = pavaData,
      PROBABILITY.GAMMA = 0.5)
bootBC.ci(tObserved = bootResult$t0[3],
              tBoot = bootResult$t[, 3],
               conf = 0.95)
}
