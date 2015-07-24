\name{tglm.fit}
\alias{tglm.fit}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Fit a Binary Regression under Independent Student-t Priors
}
\description{
Use Gibbs sampler with Polya-Gamma data augmentation to fit logistic and probit regression under independent Student-t priors (including Cauchy priors and normal priors as special cases). 
}
\usage{
tglm.fit(y, X, iter = 1e+05, thin = max(1, round(iter/2000)), 
         burnin = 0.5, method = "logistic", df = 1, slope.scale = 2.5, 
         intercept.scale = 10, save.latent = FALSE, 
         center.binary = TRUE, scale.continuous = TRUE, 
         beta.original = TRUE, track.time = TRUE, show.summary = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{y}{
a numerical vector of length \eqn{n}. Binary responses.
}
  \item{X}{
an \eqn{n} by \eqn{p} matrix. Design matrix, not including the intercept.
}
  \item{iter}{
total number of iterations of MCMC.
}
  \item{thin}{
thinning; save one iteration in every \code{thin} number of iterations.
}
  \item{burnin}{
ratio between number of burnin iterations and total number of iterations.
}
  \item{method}{
\code{"logistic"} for logistic regression, or \code{"probit"} for probit regression.
}
  \item{df}{
degree freedom of the independent Student-t priors on both intercept and slopes. 
If \code{Inf}, use independent normal priors.
}
  \item{slope.scale}{
a scalar or a vector of length \eqn{p}. 
The scale (or standard deviation) parameter of the Student-t (or normal) priors on slopes.
}
  \item{intercept.scale}{
the scale (or sd) parameter of the Student-t (or normal) prior on the intercept.
}
  \item{save.latent}{
logical, indicating whether to save the MCMC samples for the latent variable \eqn{z}. 
Since latent variable is of length \eqn{n}, it takes a lot of space when \var{n} is large.
}
  \item{center.binary}{
logical, indicating whether to center binary predictors. 
}
  \item{scale.continuous}{
logical, indicating whether to center and rescale the non-binary predictors. 
}
  \item{beta.original}{
logical, indicating whether to post-process the posterior samples of beta 
to the orginal scale. This is only meaningful if 
predictors are centered/rescaled in the pre-processing step.
}
  \item{track.time}{
logical, indicating whether to show process time.
}
  \item{show.summary}{
logical, indicating whether to show summary of posterior inferences.
}
}
\details{
See references. 
}
\value{
  \item{Beta}{
a \code{(iter / thin + 1)} by (\eqn{p} + 1) matrix.
MCMC samples of \eqn{beta} (the first dimemsion is the intercept).
}
  \item{Gamma}{
a \code{(iter / thin + 1)} * (\eqn{p} + 1) matrix.
MCMC samples of \eqn{gamma}.
}
  \item{Inference}{
a (\eqn{p} + 1) by 4 matrix.
Sample posterior mean, stanard deviation, and 95\% HDP interval for the intercept and coefficients.
}
  \item{Z}{
a \code{(iter / thin + 1)} * \eqn{n} matrix.
MCMC samples of \var{z}. Only returned when \code{save.latent == TRUE}.
}
}
\references{
James H. Albert and Siddhartha Chib. (1993) "Bayesian Analysis of Binary and Polychotomous Response Data." Journal of the American statistical Association, 88(422), 669-679.

Nicholas G. Polson, James G. Scott, and Jesse Windle. (2013) "Bayesian Inference for Logistic Models Using Polya-Gamma Latent Variables." Journal of the American statistical Association, 108(504), 1339-1349. 

Joyee Ghosh, Yingbo Li, and Robin Mitra. "On the Use of Cauchy Prior Distributions for Bayesian Logistic Regression." Working paper. 
}
\author{
Yingbo Li

Maintainer: Yingbo Li <ybli@clemson.edu>
}

\examples{
## create a dataset for logistic regression
n = 200; p = 2; beta0 = c(0.5, 1, 2);
X = matrix(rnorm(n * p), ncol = p);
p = 1 / (1 + exp(- beta0[1] - X \%*\% beta0[-1]));
y = rbinom(n, 1, prob = p);

## Cauchy priors
results.cauchy = tglm.fit(y, X, iter = 1e3);

## Not run: ##
#### Student-t priors with df = 7
## results.t7 = tglm.fit(y, X, iter = 1e3, df = 7);
#### Normal priors 
##results.normal = tglm.fit(y, X, iter = 1e3, df = Inf);
#### Probit regression
##results.probit = tglm.fit(y, X, iter = 1e3, method = 'probit');
## End(Not run)
}

\keyword{ package }
\keyword{ logistic regression }
\keyword{ probit regression }
\keyword{ Cauchy prior }
\keyword{ MCMC }
