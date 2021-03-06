\name{.parseISO8601}
\alias{ISO8601}
\Rdversion{1.1}
\alias{parseISO8601}
\alias{makeISO8601}
\alias{.parseISO8601}
\alias{.makeISO8601}
\title{
Internal ISO 8601:2004(e) Time Parser
}
\description{
This function is used internally in the subsetting
mechanism of xts.  The function is unexported, though
documented for use with xts subsetting.
}
\usage{
.parseISO8601(x, start, end, tz="")

.makeISO8601(x)
}
\arguments{
  \item{x}{
For .parseISO8601(x), a character string conforming 
to the ISO 8601:2004(e) rules. For .makeISO8601(x), \code{x}
should be a time-like object with
\code{start} and \code{end} methods.
}
  \item{start}{
lower constraint on range
}
  \item{end}{
upper constraint of range
}
  \item{tz}{
timezone (tzone) to use internally
}
}
\details{
This function replicates most of the ISO 
standard for expressing time and time-based
ranges in a universally accepted way.

The best documentation is now the official
ISO page as well as the Wikipedia entry for
ISO 8601:2004.

The basic idea is to create
the endpoints of a range, given a string
representation. These endpoints are aligned
in POSIXct time to the zero second of the day
at the beginning, and the 59.9999th second of the 59th
minute of the 23rd hour of the final day.

For dates prior to the epoch (1970-01-01) the
ending time is aligned to the 59.0000 second. This
is due to a bug/feature in the \R implementation of
asPOSIXct and mktime0 at the C-source level. This limits
the precision of ranges prior to 1970 to 1 minute
granularity with the current \pkg{xts} workaround.

Recurring times over multiple days may be specified
using the T notation. See the examples for details.
}
\value{
A list of length two, with an entry
named \sQuote{first.time} and one
names \sQuote{last.time}.

For .makeISO8601, a character vector of length
one describing the ISO-style format for a given
time-based object.
}
\references{
\url{http://en.wikipedia.org/wiki/ISO_8601}\cr
\url{http://www.iso.org/iso/support/faqs/faqs_widely_used_standards/widely_used_standards_other/iso8601}
}
\author{
Jeffrey A. Ryan
}
\note{
There is no checking done to test for a properly constructed
ISO format string.  This must be correctly entered by the user, lest
bad things may happen.

When using durations, it is important to note that the
time of the duration specified is not necessarily the
same as the realized periods that may be returned when
applied to an irregular time series.  This is not a bug,
rather it is a standards and implementation gotcha.
}
\examples{
# the start and end of 2000
.parseISO8601('2000')

# the start of 2000 and end of 2001
.parseISO8601('2000/2001')

# May 1, 2000 to Dec 31, 2001
.parseISO8601('2000-05/2001')

# May 1, 2000 to end of Feb 2001
.parseISO8601('2000-05/2001-02')

# Jan 1, 2000 to Feb 29, 2000; note the truncated time on the LHS
.parseISO8601('2000-01/02')

# 8:30 to 15:00 (used in xts subsetting to extract recurring times)
.parseISO8601('T08:30/T15:00')
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ utilities }
