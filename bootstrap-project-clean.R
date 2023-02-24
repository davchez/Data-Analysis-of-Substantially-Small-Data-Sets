#GLOBAL PACKAGES AND FUNCTIONS
library(tidyverse)
library(moderndive)
library(infer) 
library(gridExtra)

distance <- c(0, 0.125, 0.250, 0.380, 0.440, 0.500)

distanceX <- seq(0,0.5,0.005)

boot <- function(a) { as.numeric(rep_sample_n(a, size=1, replace=TRUE, reps=1)[2]) }

graph <- function(ds, a, b, c, d, e, title) { ggplot() + geom_boxplot(data = ds, aes(x = x, y = y, group = x)) +
    geom_line(data = NULL, size=2, aes(x = distanceX, y = a * cos(2 * pi * b * distanceX + c) * (1 - d * distanceX) + e, color = "fit")) +
    labs(title = title, subtitle = paste0("frequency: ", round(mean(b), digits = 3)), x = "Distance", y = "y", colour = "Legend") + ylim(-1, 1) }

cf <- function() { data.frame(list(a=mean(unlist(datalist)[c(TRUE, FALSE, FALSE, FALSE)]), b=mean(unlist(datalist)[c(FALSE, TRUE, FALSE, FALSE)]), c=mean(unlist(datalist)[c(FALSE, FALSE, TRUE, FALSE)]), d=mean(unlist(datalist)[c(FALSE, FALSE, FALSE, TRUE)]))) }

ds <- function() { data.frame(x = unlist(as.numeric(unlist(plotlist))[c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)]), y = unlist(as.numeric(unlist(plotlist))[c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)])) }

bootstrap <- function() { data.frame(y = c(boot(data[1]), boot(data[2]), boot(data[3]), boot(data[4]), boot(data[5]), boot(data[6])), x = distance) }

#S-1 SUBJECT
plotlist <- list()
datalist <- list()

data <- read.table("C:/Users/david/Dropbox/David_Dinh/Data/S-subject/LO1-S.txt")

for(i in 1:1000)
{
  #Bootstrap and fitting procedure
  samplefit <- nls(y ~ a * cos(2 * pi * b * x + c) * (1 - d * x), # -- model we will be using
                   data = bootstrap(),
                   upper = c(a=1.95, b=1.1, c=8, d=2.8), # -- upper bound of parameter estimate
                   start = c(a=1.6, b=0.9, c=7, d=2.4), # -- starting parameter estimates
                   lower = c(a=1.5, b=0.8, c=6, d=2.1), # -- lower bound of parameter estimates
                   algorithm = "port",
                   control = list(maxiter = 500, warnOnly=TRUE))
  
  plotlist[i] <- list(c(list(c(predict(samplefit, list(x = distance)))), list(distance)))
  datalist[i] <- list(c(summary(samplefit)$coefficients[1:4]))
}

cf1 <- cf() 
ds1 <- ds()
p1 <- graph(ds1, cf1$a, cf1$b, cf1$c, cf1$d, 0, "S-1 Graph")

#S-2 SUBJECT
plotlist <- list()
datalist <- list()

data <- read.table("C:/Users/david/Dropbox/David_Dinh/Data/S-subject/LO2-S.txt")

for(i in 1:1000)
{
  #Bootstrap and fitting procedure
  samplefit <- nls(y ~ a * cos(2 * pi * b * x + c) * (1 - d * x), # -- model we will be using
                   data = bootstrap(),
                   upper = c(a=1.4, b=1.1, c=7.6, d=3.0), # -- upper bound of parameter estimates
                   start = c(a=0.85, b=0.8, c=7.4, d=2.9), # -- starting parameter estimates
                   lower = c(a=0.7, b=0.65, c=7.25, d=2.8), # -- lower bound of parameter estimates
                   algorithm = "port",
                   control = list(maxiter = 500, warnOnly=TRUE))
  
  plotlist[i] <- list(c(list(c(predict(samplefit, list(x = distance)))), list(distance)))
  datalist[i] <- list(c(summary(samplefit)$coefficients[1:4]))
}

cf2 <- cf()
ds2 <- ds()
p2 <- graph(ds2, cf2$a, cf2$b, cf2$c, cf2$d, 0, "S-2 Graph")

#S-3 SUBJECT
plotlist <- list()
datalist <- list()

data <- read.table("C:/Users/david/Dropbox/David_Dinh/Data/S-subject/LO3-S.txt")

for(i in 1:1000)
{
  #Bootstrap and fitting procedure
  samplefit <- nls(y ~ a * cos(2 * pi * b * x + c) * (1 - d * x), # -- model we will be using
                   data = bootstrap(),
                   upper = c(a=0.6, b=1.1, c=2.6, d=0.4), # -- upper bound of parameter estimates
                   start = c(a=0.5, b=0.8, c=2.3, d=0.0), # -- starting parameter estimates
                   lower = c(a=0.35, b=0.7, c=1.8, d=-0.4), # -- lower bound of parameter estimates
                   algorithm = "port",
                   control = list(maxiter = 500, warnOnly=TRUE))
  
  plotlist[i] <- list(c(list(c(predict(samplefit, list(x = distance)))), list(distance)))
  datalist[i] <- list(c(summary(samplefit)$coefficients[1:4]))
}

cf3 <- cf()
ds3 <- ds()
p3 <- graph(ds3, cf3$a, cf3$b, cf3$c, cf3$d, 0, "S-3 Graph")

#D-1 SUBJECT
plotlist <- list()
datalist <- list()

data <- read.table("C:/Users/david/Dropbox/David_Dinh/Data/D-subject/LO1-D.txt")

for(i in 1:1000)
{
  #Bootstrap and fitting procedure
  samplefit <- nls(y ~ a * cos(2 * pi * b * x + c) * (1 - d * x), # -- model we will be using
                   data = bootstrap(),
                   upper = c(a=2, b=1.3, c=9, d=5), # -- upper bound of parameter estimates
                   start = c(a=1, b=1, c=7, d=1), # -- starting parameter estimates
                   lower = c(a=0.1, b=0.8, c=6.5, d=0.1), # -- lower bound of parameter estimates
                   algorithm = "port",
                   control = list(maxiter = 500, warnOnly=TRUE))
  
  plotlist[i] <- list(c(list(c(predict(samplefit, list(x = distance)))), list(distance)))
  datalist[i] <- list(c(summary(samplefit)$coefficients[1:4]))
}

cf4 <-cf()
ds4 <- ds()
p4 <- graph(ds4, cf4$a, cf4$b, cf4$c, cf4$d, 0, "D-1 Graph")

#D-2 SUBJECT
plotlist <- list()
datalist <- list()

data <- read.table("C:/Users/david/Dropbox/David_Dinh/Data/D-subject/LO2-D.txt")

for(i in 1:1000)
{
  #Bootstrap and fitting procedure
  samplefit <- nls(y ~ a * cos(2 * pi * b * x + c) * (1 - d * x) + e, # -- model we will be using
                   data = bootstrap(),
                   upper = c(a=1.3, b=1.3, c=8.75, d=5, e=0.2), # -- upper bound of parameter estimates
                   start = c(a=0.8, b=1, c=7, d=2, e=0.1), # -- starting parameter estimates
                   lower = c(a=0.1, b=0.8, c=6.5, d=0.1, e=0), # -- lower bound of parameter estimates
                   algorithm = "port",
                   control = list(maxiter = 500, warnOnly=TRUE))
  
  plotlist[i] <- list(c(list(c(predict(samplefit, list(x = distance)))), list(distance)))
  datalist[i] <- list(c(summary(samplefit)$coefficients[1:5]))
}

cf5 <- data.frame(list(a=mean(unlist(datalist)[c(TRUE, FALSE, FALSE, FALSE, FALSE)]), b=mean(unlist(datalist)[c(FALSE, TRUE, FALSE, FALSE, FALSE)]), 
                       c=mean(unlist(datalist)[c(FALSE, FALSE, TRUE, FALSE, FALSE)]), d=mean(unlist(datalist)[c(FALSE, FALSE, FALSE, TRUE, FALSE)]),
                       e=mean(unlist(datalist)[c(FALSE, FALSE, FALSE, FALSE, TRUE)])))
ds5 <- ds()
p5 <- graph(ds5, cf5$a, cf5$b, cf5$c, cf5$d, cf5$e, "D-2 Graph")

#D-3 SUBJECT
plotlist <- list()
datalist <- list()

data <- read.table("C:/Users/david/Dropbox/David_Dinh/Data/D-subject/LO3-D.txt")

for(i in 1:1000)
{
  #Bootstrap and fitting procedure
  samplefit <- nls(y ~ a * cos(2 * pi * b * x + c) * (1 - d * x), # -- model we will be using
                   data = bootstrap(),
                   upper = c(a=1, b=2, c=9, d=2.25), # -- upper bound of parameter estimates
                   start = c(a=0.4, b=1, c=7, d=1), # -- starting parameter estimates
                   lower = c(a=0.1, b=0.5, c=6.5, d=0.1), # -- lower bound of parameter estimates
                   algorithm = "port",
                   control = list(maxiter = 500, warnOnly=TRUE))
  
  plotlist[i] <- list(c(list(c(predict(samplefit, list(x = distance)))), list(distance)))
  datalist[i] <- list(c(summary(samplefit)$coefficients[1:4]))
}

cf6 <- cf()
ds6 <- ds()
p6 <- graph(ds6, cf6$a, cf6$b, cf6$c, cf6$d, 0, "D-3 Graph")

#GRAPHING EVERYTHING
grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 3, nrow = 2)
