% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shapeR.R
\name{outline.reconstruction.plot}
\alias{outline.reconstruction.plot}
\title{Plot outline reconstruction}
\usage{
outline.reconstruction.plot(outline.rec.list,ref.w.level=5,
                            ref.f.harmonics=12,max.num.harmonics=32,...)
}
\arguments{
\item{outline.rec.list}{The output from \link{estimate.outline.reconstruction}}

\item{ref.w.level}{Reference level for graphical purposes. The default is 5 as is the default of \linkS4class{shapeR}.}

\item{ref.f.harmonics}{Reference Fourier harmonize. The default is 12 as is the default in \linkS4class{shapeR}.}

\item{max.num.harmonics}{Maxinum number of Fourier harmonics to be shown}

\item{...}{Additional parameters to be passed to 'plot'}
}
\description{
Show graphs of the reconstruction using different number of levels of wavelet reconstruction and Fourier power using different number of Fourier harmonics. 
Uses the output from \link{estimate.outline.reconstruction}
}
\examples{
\dontrun{data(shape)
est.list = estimate.outline.reconstruction(shape)
outline.reconstruction.plot(est.list,panel.first = grid())}
}
\author{
Lisa Anne Libungan
}
