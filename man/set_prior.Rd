% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/interface.R
\name{set_prior}
\alias{set_prior}
\alias{update_prior}
\alias{check_prior}
\title{Set priors for an mfbvar model}
\usage{
set_prior(Y, freq, prior_Pi_AR1 = rep(0, ncol(Y)), lambda1 = 0.2,
  lambda2 = 1, n_lags, n_fcst = 0, n_burnin, n_reps, d = NULL,
  d_fcst = NULL, prior_psi_mean = NULL, prior_psi_Omega = NULL,
  lambda3 = 10000, verbose = FALSE, smooth_state = FALSE,
  check_roots = TRUE)

update_prior(prior_obj, ...)

check_prior(prior_obj)
}
\arguments{
\item{Y}{The data matrix of size \code{(n_T + n_lags) * n_vars} with \code{NA} representing missingness. All monthly variables must be placed before quarterly variables.}

\item{freq}{Character vector with elements 'm' (monthly) or 'q' (quarterly) for sampling frequency. Monthly variables must precede all quarterly variables.}

\item{prior_Pi_AR1}{The prior means for the AR(1) coefficients.}

\item{lambda1}{The overall tightness.}

\item{lambda2}{The lag decay.}

\item{n_lags}{The number of lags.}

\item{n_fcst}{The number of periods to forecast.}

\item{n_burnin}{The number of burn-in replications.}

\item{n_reps}{The number of replications.}

\item{d}{(Steady state only) Either a matrix with same number of rows as \code{Y} and \code{n_determ} number of columns containing the deterministic terms or a string \code{"intercept"} for requesting an intercept as the only deterministic
term.}

\item{d_fcst}{(Steady state only) The deterministic terms for the forecasting period (not used if \code{d = "intercept"}).}

\item{prior_psi_mean}{(Steady state only) Vector of length \code{n_determ*n_vars} with the prior means of the steady-state parameters.}

\item{prior_psi_Omega}{(Steady state only) Matrix of size \code{(n_determ*n_vars) * (n_determ*n_vars)} with the prior covariance of the steady-state parameters.}

\item{lambda3}{(Minnesota only) Prior variance of the intercept.}

\item{verbose}{Logical, if progress should be printed to the console.}

\item{smooth_state}{Logical, if \code{TRUE} then the smoothed estimates of the latent states are also returned.}

\item{check_roots}{Logical, if roots of the companion matrix are to be checked to ensure stationarity.}

\item{prior_obj}{an object of class \code{mfbvar_prior}}

\item{...}{named arguments for prior attributes to update}
}
\description{
Create an object storing all information needed for estimation, including data as well as model and prior specifications for both a Minnesota or steady-state prior.
}
\details{
The first arguments (\code{Y} through \code{n_reps}) must be set for the model to be estimated irrespective of the choice
of prior, but some have default values (which will produce warnings if relied upon).

For the Minnesota prior, \code{lambda3} must also be set, but it too has a default that it relies on if not specified.

For the steady-state prior, the deterministic matrix needs to be supplied, or a string indicating that the intercept should be
the only deterministic term. If the latter, also \code{d_fcst} is set to be intercept only. Otherwise, if forecasts are requested
(\code{n_fcst > 0}) also \code{d_fcst} needs to be provided. Finally, the prior moments for the steady-state parameters must also be
provided.

The steady-state prior involves inverting the lag polynomial. For this reason, draws in which the largest eigenvalue
(in absolute value) of the lag polynomial is greater than 1 are discarded and new draws are made. The maximum number of
attempts is 1,000. The components in the output named \code{roots} and \code{num_tries} contain the largest roots and the
number of attempts, respectively, if \code{check_roots = TRUE} (the default).
}
\examples{
prior_obj <- set_prior(Y = mf_sweden, freq = c(rep("m", 4), "q"),
                       n_lags = 4, n_burnin = 100, n_reps = 100)
prior_obj <- update_prior(prior_obj, n_fcst = 4)
}
\seealso{
\code{\link{interval_to_moments}}, \code{\link{print.mfbvar_prior}}, \code{\link{summary.mfbvar_prior}}, \code{\link{estimate_mfbvar}}
}
