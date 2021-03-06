\name{subset}
\alias{subset}
\alias{subset.station}
\alias{subset.eof}
\alias{subset.pca}
\alias{subset.cca}
\alias{subset.events}
\alias{subset.trajectory}
\alias{subset.trend}
\alias{subset.corfield}
\alias{subset.ds}
\alias{subset.dsensemble}
\alias{subset.comb}
\alias{subset.field}
\alias{subset.spell}
\alias{subset.zoo}
\alias{subset.trajectory}
\alias{station.subset}
\alias{matchdate}
\alias{sort.station}
\alias{subset.stationmeta}
\title{Subsetting esd objects}
\description{
The subset method tries to be 'intelligent', and if the list has no names, then the list contains two vectors of length 2, then this is interpreted as a region, e.g. argument \code{is = list( c(lon.min,lon.max),c(lat.min,lat.max) )}. If, on the other hand, \code{is = list( lon=1:50,lat=55:65 )}, then the function picks the longitudes and latitudes which match these. This makes it flexible so that one can pick any irregular sequence.
}
\usage{
subset(x,it=NULL,is=NULL,...)
subset.station(x,it = NULL,is = NULL,verbose=FALSE)
subset.eof(x,it=NULL,is=NULL,verbose=FALSE)
subset.cca(x,it=NULL,is=NULL)
subset.mvr(x,it=NULL,is=NULL)
subset.pca(x,ip=NULL,it=NULL,is=NULL,verbose=FALSE)
subset.trend(x,it=NULL,is=NULL)
subset.corfield(x,it=NULL,is=NULL)
subset.comb(x,it=NULL,is=NULL)
subset.events(x,it=NULL,is=NULL) 
subset.trajectory(x,it=NULL,is=NULL) 
subset.field(x,it=NULL,is=NULL)
subset.spell(x,is=NULL,it=NULL) 
subset.ds(x,it=NULL,is=NULL)
subset.trend(x,it=NULL,is=NULL)
subset.dsensemble(x,it=NULL,is=NULL,
                  ensemble.aggregate=TRUE,verbose=FALSE,...)
subset.dsensemble.multi(x,ip=NULL,it=NULL,is=NULL,im=NULL,
                        verbose=FALSE,...)
subset.zoo(x,it=NULL)
subset.trajectory(x,it=NULL,is=NULL)
subset.stationmeta(x,it=NULL,is=NULL,verbose=FALSE)
matchdate(x,it)
sort.station(x,is=NULL,decreasing=TRUE)
}
\arguments{
\item{x}{Data object from which the subset is taken}
\item{it}{A list or data.frame providing time index, e.g. month}
\item{is}{A list or data.frame providing space index, e.g. station record}
\item{ip}{selection of patterns in PCA or EOF (used for e.g. filtreing
  the data)}
\item{verbose}{Dump diagnostics to the screen}
\item{ensemble.aggregate}{If TRUE, call \code{subset.dsensemble.multi}
  if appropriate.}
 }
\value{A field object}

\seealso{
}

\author{R.E. Benestad and A.  Mezghanil}
\examples{
data(Oslo)
# January months:
jan <- subset(Oslo,1)
# The last 10 years:
recent <- subset(Oslo,2003:2012)
# JJA season
jja <- subset(Oslo,it="jja")
# Seasonl values for MAM
mam <- subset(as.4seasons(Oslo),it=2)

data(ferder)
# Aggregated values for May (it=5)
may <- subset(as.monthly(Oslo),it=5)
# The last 10 aggregated annual values 
recent.ann <- subset(as.annual(Oslo),it=2004:2013)

gcm <- t2m.NorESM.M()
# Extract July months from a field:
gcm.jul <- subset(gcm,it=7)

# Extract a period from a field:
gcm.short <- subset(gcm.jul,it=1950:2030)

# Extract data for the region 0-50E/55-65N
X <-  subset(gcm,is=list(c(0,50),c(55,65)))

# Extract data for a specific set of longitudes and latitudes
Z <-  subset(gcm,is=list(lon=1:30,lat=58:63))

t2m <- t2m.NCEP(lon=c(-10,30),lat=c(50,70))
cal <- subset(t2m,it=c("1948-01-01","1980-12-31"))

# Example on how to split the data into two parts for
# split-sample test...

T2M <- as.annual(t2m.NCEP(lon=c(-10,30),lat=c(50,70)))
cal <- subset(T2M,it=c(1948,1980))
pre <- subset(T2M,it=c(1981,2012))
comb <- combine(cal,pre) 
X <- EOF(comb)
plot(X)

data(ferder)
y <- as.annual(ferder)
z <- DS(y,X)
plot(z)

# Test of subset the commutative property of subset and combine: 
T2M <- as.4seasons(t2m.NCEP(lon=c(-10,30),lat=c(50,70)))
GCM <- as.4seasons(t2m.NorESM.M(lon = range(lon(T2M))+c(-2,2), lat = range(lat(T2M))+c(-2,2)))
XY <- combine(T2M,GCM)
X1 <- subset(XY,it=3)
X2 <- combine(subset(T2M,it=3),subset(GCM,it=3))
eof1 <- EOF(X1)
eof2 <- EOF(X2)
eof3 <- biasfix(eof2)
plot(merge(eof1[,1],eof2[,1],eof3[,1]),plot.type='single',
     col=c('red','blue','green'),lty=c(1,1,2),lwd=c(4,2,2))
# OK - identical results

# Extract storm tracks for specific periods and regions
# from the example 'trajectory' object imilast.M03
data(imilast.M03)
# spring season (march, april, may)
x1 <- subset(imilast.M03,it='mam') 
plot(x1)

# region 10W-10E/55-65N
x2 <- subset(imilast.M03,is=list(lat=c(55,65),lon=c(-10,10)))
map(x2)

# storms longer than 3 days (12x6 hours)
x3 <- subset(imilast.M03,it=(param.trajectory(imilast.M03,param='n')>12))
map(x3)

}
\keyword{utilities}
