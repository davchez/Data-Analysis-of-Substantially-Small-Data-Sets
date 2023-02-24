#Libraries/packages in R necessary to run code
library(tidyverse)
library(moderndive)
library(infer) 
library(gridExtra)

#-----------------------------------------------------------------------------------------------------------------------------------------#

plotlist <- list()
datalist <- list()
  
#S-1 SUBJECT

for(i in 1:1000)
{
  #Col(n) is bootstrapping each column once to make an individual point every time the function loops
  bootstrap <- data.frame(y = as.numeric(c(
    ( rep_sample_n(data.frame(c(0.4121, 0.5898, 0.6861, 0.1917, 0.4146)), size = 1, replace = TRUE, reps = 1) )[2], 
    ( rep_sample_n(data.frame(c(-0.2706, -0.4627, -0.1075, -0.5948, -0.8761)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(-0.0300, -0.5702, 0.2543, -0.8374, -1.1026)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.2314, -0.3368, -0.4339, -0.4830, -0.2975)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.4284, 0.0804, 0.0493, 0.3007, 0.1700)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.3935, 0.4718, 0.3074, 0.0868, -0.2783)), size = 1, replace = TRUE, reps = 1) )[2])),
    x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500))
  
  #Applying the model w/ parameter estimates to the bootstrapped points
  samplefit <- nls(y ~ a * cos(2 * pi * b * x + c) * (1 - d * x), # -- model we will be using
                   data = bootstrap,
                   
                   upper = c(a=1.95, b=1.1, c=8, d=2.8), # -- upper bound of parameter estimates
                   
                   start = c(a=1.6, b=0.9, c=7, d=2.4), # -- starting parameter estimates
                   
                   lower = c(a=1.5, b=0.8, c=6, d=2.1), # -- lower bound of parameter estimates
                   
                   algorithm = "port",
                   control = list(maxiter = 500, warnOnly=TRUE))
  
  
  #Lists that will record the coefficients of the model every time the for loop completes
  
  plotlist[i] <- list(c(list(c(predict(samplefit, list(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500))))),
                        list(c(0, 0.125, 0.250, 0.380, 0.440, 0.500))))
  
  datalist[i] <- list(c((summary(samplefit)$coefficients[1]), 
                        (summary(samplefit)$coefficients[2]), 
                        (summary(samplefit)$coefficients[3]), 
                        (summary(samplefit)$coefficients[4])))
  
}

coeff_set1 <- data.frame(list(a=mean(as.numeric(unlist(datalist))[c(TRUE, FALSE, FALSE, FALSE)]), 
                              b=mean(as.numeric(unlist(datalist))[c(FALSE, TRUE, FALSE, FALSE)]), 
                              c=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, TRUE, FALSE)]), 
                              d=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, FALSE, TRUE)])))

pset1 <- 1/mean(coeff_set1$b)

data_set1 <- data.frame(x = unlist(as.numeric(unlist(plotlist))[c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)]), 
                        y = unlist(as.numeric(unlist(plotlist))[c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)]))

p1 <- ggplot() +
  
  geom_boxplot(data = data_set1, aes(x = x, y = y, group = x)) +
  
  geom_line(data = NULL, size=2,
            aes(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500),
                y = c(0.4588, -0.4623, -0.4572, -0.2639, 0.2057, 0.1963),
                color = "average")) +
  
  geom_line(data = NULL, size=2,
            aes(x = seq(0,0.5,0.01), 
                y = coeff_set1$a * cos(2 * pi * coeff_set1$b * seq(0,0.5,0.01) + coeff_set1$c) * (1 - coeff_set1$d * seq(0,0.5,0.01)),
                color = "fit")) +
  
  geom_point(data = NULL, alpha = 0.5, size = 5, color = "red",
             aes(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500),
                 y = c(0.4588, -0.4623, -0.4572, -0.2639, 0.2057, 0.1963))) +
  
  labs(title = "S-1 Graph", subtitle = paste0("frequency: ", round(mean(coeff_set1$b), digits = 3)), 
       x = "Distance", y = "y", colour = "Legend") +
  
  ylim(-1, 1)

#-----------------------------------------------------------------------------------------------------------------------------------------#

plotlist <- list()
datalist <- list()

#S-2 SUBJECT

for(i in 1:1000)
{
  #Col(n) is bootstrapping each column once to make an individual point every time the function loops
  bootstrap <- data.frame(y = as.numeric(c(
    ( rep_sample_n(data.frame(c(-0.4785, -0.1237, 0.6874, 0.6416, 0.8509)), size = 1, replace = TRUE, reps = 1) )[2], 
    ( rep_sample_n(data.frame(c(0.0501, -0.4070, -0.3686, -0.2768, 0.1246)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.2069, -0.1873, -0.3248, -0.1080, -0.4945)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.4997, -0.0063, 0.2125, -0.1053, -0.0224)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.3875, 0.3783, 0.1027, 0.1173, 0.2188)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.5098, 0.2946, 0.4712, 0.1992, 0.1236)), size = 1, replace = TRUE, reps = 1) )[2])),
    x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500))
  
  #Applying the model w/ parameter estimates to the bootstrapped points
  samplefit <- nls(y ~ a * cos(2 * pi * b * x + c) * (1 - d * x), # -- model we will be using
                   data = bootstrap,
                   
                   upper = c(a=1.4, b=1.1, c=7.6, d=3.0), # -- upper bound of parameter estimates
                   
                   start = c(a=0.85, b=0.8, c=7.4, d=2.9), # -- starting parameter estimates
                   
                   lower = c(a=0.7, b=0.65, c=7.25, d=2.8), # -- lower bound of parameter estimates
                   
                   algorithm = "port",
                   control = list(maxiter = 500, warnOnly=TRUE))
  
  
  #Lists that will record the coefficients of the model every time the for loop completes
  
  plotlist[i] <- list(c(list(c(predict(samplefit, list(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500))))),
                        list(c(0, 0.125, 0.250, 0.380, 0.440, 0.500))))
  
  datalist[i] <- list(c((summary(samplefit)$coefficients[1]), 
                        (summary(samplefit)$coefficients[2]), 
                        (summary(samplefit)$coefficients[3]), 
                        (summary(samplefit)$coefficients[4])))
  
}

coeff_set2 <- data.frame(list(a=mean(as.numeric(unlist(datalist))[c(TRUE, FALSE, FALSE, FALSE)]), 
                              b=mean(as.numeric(unlist(datalist))[c(FALSE, TRUE, FALSE, FALSE)]), 
                              c=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, TRUE, FALSE)]), 
                              d=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, FALSE, TRUE)])))

pset2 <- 1/mean(coeff_set2$b)

data_set2 <- data.frame(x = unlist(as.numeric(unlist(plotlist))[c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)]), 
                        y = unlist(as.numeric(unlist(plotlist))[c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)]))

p2 <- ggplot() +
  
  geom_boxplot(data = data_set2, aes(x = x, y = y, group = x)) +
  
  geom_line(data = NULL, size=2,
            aes(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500),
                y = c(mean(c(-0.4785, -0.1237, 0.6874, 0.6416, 0.8509)), 
                      mean(c(0.0501, -0.4070, -0.3686, -0.2768, 0.1246)), 
                      mean(c(0.2069, -0.1873, -0.3248, -0.1080, -0.4945)), 
                      mean(c(0.4997, -0.0063, 0.2125, -0.1053, -0.0224)), 
                      mean(c(0.3875, 0.3783, 0.1027, 0.1173, 0.2188)), 
                      mean(c(0.5098, 0.2946, 0.4712, 0.1992, 0.1236))),
                color = "average")) +
  
  geom_line(data = NULL, size=2,
            aes(x = seq(0,0.5,0.01), 
                y = coeff_set2$a * cos(2 * pi * coeff_set2$b * seq(0,0.5,0.01) + coeff_set2$c) * (1 - coeff_set2$d * seq(0,0.5,0.01)),
                color = "fit")) +
  
  geom_point(data = NULL, alpha = 0.5, size = 5, color = "red",
             aes(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500),
                 y = c(mean(c(-0.4785, -0.1237, 0.6874, 0.6416, 0.8509)), 
                       mean(c(0.0501, -0.4070, -0.3686, -0.2768, 0.1246)), 
                       mean(c(0.2069, -0.1873, -0.3248, -0.1080, -0.4945)), 
                       mean(c(0.4997, -0.0063, 0.2125, -0.1053, -0.0224)), 
                       mean(c(0.3875, 0.3783, 0.1027, 0.1173, 0.2188)), 
                       mean(c(0.5098, 0.2946, 0.4712, 0.1992, 0.1236))))) +
  
  labs(title = "S-2 Graph", subtitle = paste0("frequency: ", round(mean(coeff_set2$b), digits = 3)), 
       x = "Distance", y = "y", colour = "Legend") +
  
  ylim(-1, 1)

#-----------------------------------------------------------------------------------------------------------------------------------------#

plotlist <- list()
datalist <- list()

#S-3 SUBJECT

for(i in 1:1000)
{
  #Col(n) is bootstrapping each column once to make an individual point every time the function loops
  bootstrap <- data.frame(y = as.numeric(c(
    ( rep_sample_n(data.frame(c(-0.6788, -0.9669, -0.8055, 0.5556, 0.3766)), size = 1, replace = TRUE, reps = 1) )[2], 
    ( rep_sample_n(data.frame(c(-0.5204, -0.6057, -0.8154, -0.4539, 0.0656)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(-0.0414, -0.4162, -0.6929, -0.6863, -0.5629)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(-0.0777, -0.3623, -0.3409, -0.1715, -0.3745)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(-0.1620, -0.0969, -0.1445, -0.1025, 0.1194)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.3224, 0.1569, -0.0238, 0.0318, -0.1024)), size = 1, replace = TRUE, reps = 1) )[2])),
    x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500))
  
  #Applying the model w/ parameter estimates to the bootstrapped points
  samplefit <- nls(y ~ a * cos(2 * pi * b * x + c) * (1 - d * x), # -- model we will be using
                   data = bootstrap,
                   
                   upper = c(a=0.6, b=1.1, c=2.6, d=0.4), # -- upper bound of parameter estimates
                   
                   start = c(a=0.5, b=0.8, c=2.3, d=0.0), # -- starting parameter estimates
                   
                   lower = c(a=0.35, b=0.7, c=1.8, d=-0.4), # -- lower bound of parameter estimates
                   
                   algorithm = "port",
                   control = list(maxiter = 500, warnOnly=TRUE))
  
  
  #Lists that will record the coefficients of the model every time the for loop completes
  
  plotlist[i] <- list(c(list(c(predict(samplefit, list(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500))))),
                        list(c(0, 0.125, 0.250, 0.380, 0.440, 0.500))))
  
  datalist[i] <- list(c((summary(samplefit)$coefficients[1]), 
                        (summary(samplefit)$coefficients[2]), 
                        (summary(samplefit)$coefficients[3]), 
                        (summary(samplefit)$coefficients[4])))
  
}

coeff_set3 <- data.frame(list(a=mean(as.numeric(unlist(datalist))[c(TRUE, FALSE, FALSE, FALSE)]), 
                              b=mean(as.numeric(unlist(datalist))[c(FALSE, TRUE, FALSE, FALSE)]), 
                              c=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, TRUE, FALSE)]), 
                              d=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, FALSE, TRUE)])))

pset3 <- 1/mean(coeff_set3$b)

data_set3 <- data.frame(x = unlist(as.numeric(unlist(plotlist))[c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)]), 
                        y = unlist(as.numeric(unlist(plotlist))[c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)]))

p3 <- ggplot() +
  
  geom_boxplot(data = data_set3, aes(x = x, y = y, group = x)) +
  
  geom_line(data = NULL, size=2,
            aes(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500),
                y = c(mean(c(-0.6788, -0.9669, -0.8055, 0.5556, 0.3766)), 
                      mean(c(-0.5204, -0.6057, -0.8154, -0.4539, 0.0656)), 
                      mean(c(-0.0414, -0.4162, -0.6929, -0.6863, -0.5629)), 
                      mean(c(-0.0777, -0.3623, -0.3409, -0.1715, -0.3745)), 
                      mean(c(-0.1620, -0.0969, -0.1445, -0.1025, 0.1194)), 
                      mean(c(0.3224, 0.1569, -0.0238, 0.0318, -0.1024))),
                color = "average")) +
  
  geom_line(data = NULL, size=2,
            aes(x = seq(0,0.5,0.01), 
                y = coeff_set3$a * cos(2 * pi * coeff_set3$b * seq(0,0.5,0.01) + coeff_set3$c) * (1 - coeff_set3$d * seq(0,0.5,0.01)),
                color = "fit")) +
  
  geom_point(data = NULL, alpha = 0.5, size = 5, color = "red",
             aes(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500),
                 y = c(mean(c(-0.6788, -0.9669, -0.8055, 0.5556, 0.3766)), 
                       mean(c(-0.5204, -0.6057, -0.8154, -0.4539, 0.0656)), 
                       mean(c(-0.0414, -0.4162, -0.6929, -0.6863, -0.5629)), 
                       mean(c(-0.0777, -0.3623, -0.3409, -0.1715, -0.3745)), 
                       mean(c(-0.1620, -0.0969, -0.1445, -0.1025, 0.1194)), 
                       mean(c(0.3224, 0.1569, -0.0238, 0.0318, -0.1024))))) +
  
  labs(title = "S-3 Graph", subtitle = paste0("frequency: ", round(mean(coeff_set3$b), digits = 3)), 
       x = "Distance", y = "y", colour = "Legend") +
  
  ylim(-1, 1)

#-----------------------------------------------------------------------------------------------------------------------------------------#

plotlist <- list()
datalist <- list()

#D-1 SUBJECT

for(i in 1:1000)
{
  #Col(n) is bootstrapping each column once to make an individual point every time the function loops
  bootstrap <- data.frame(y = as.numeric(c(
    ( rep_sample_n(data.frame(c(0.4445, 0.4491, 0.6240, 0.5516, 0.3257)), size = 1, replace = TRUE, reps = 1) )[2], 
    ( rep_sample_n(data.frame(c(-0.0174, -0.2074, 0.1609, -0.6433, 1.0333)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(-0.2625, -0.5114, -0.8693, -0.9699, -1.0045)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(-0.1203, -0.0609, -0.5065, -0.1917, -0.2423)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.2935, -0.0673, -0.1120, -0.3783, -0.1313)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.3180, 0.0724, -0.2109, -0.0476, 0.1431)), size = 1, replace = TRUE, reps = 1) )[2])),
    x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500))
  
  #Applying the model w/ parameter estimates to the bootstrapped points
  samplefit <- nls(y ~ a * cos(2 * pi * b * x + c) * (1 - d * x), # -- model we will be using
                   data = bootstrap,
                   
                   upper = c(a=2, b=1.3, c=9, d=5), # -- upper bound of parameter estimates
                   
                   start = c(a=1, b=1, c=7, d=1), # -- starting parameter estimates
                   
                   lower = c(a=0.1, b=0.8, c=6.5, d=0.1), # -- lower bound of parameter estimates
                   
                   algorithm = "port",
                   control = list(maxiter = 500, warnOnly=TRUE))
  
  
  #Lists that will record the coefficients of the model every time the for loop completes
  
  plotlist[i] <- list(c(list(c(predict(samplefit, list(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500))))),
                        list(c(0, 0.125, 0.250, 0.380, 0.440, 0.500))))
  
  datalist[i] <- list(c((summary(samplefit)$coefficients[1]), 
                        (summary(samplefit)$coefficients[2]), 
                        (summary(samplefit)$coefficients[3]), 
                        (summary(samplefit)$coefficients[4])))
  
}

coeff_set4 <- data.frame(list(a=mean(as.numeric(unlist(datalist))[c(TRUE, FALSE, FALSE, FALSE)]), 
                              b=mean(as.numeric(unlist(datalist))[c(FALSE, TRUE, FALSE, FALSE)]), 
                              c=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, TRUE, FALSE)]), 
                              d=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, FALSE, TRUE)])))

pset4 <- 1/mean(coeff_set4$b)

data_set4 <- data.frame(x = unlist(as.numeric(unlist(plotlist))[c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)]), 
                        y = unlist(as.numeric(unlist(plotlist))[c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)]))

p4 <- ggplot() +
  
  geom_boxplot(data = data_set4, aes(x = x, y = y, group = x)) +
  
  geom_line(data = NULL, size=2,
            aes(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500),
                y = c(mean(c(0.4445, 0.4491, 0.6240, 0.5516, 0.3257)),
                      mean(c(-0.0174, -0.2074, 0.1609, -0.6433, 1.0333)),
                      mean(c(-0.2625, -0.5114, -0.8693, -0.9699, -1.0045)),
                      mean(c(-0.1203, -0.0609, -0.5065, -0.1917, -0.2423)),
                      mean(c(0.2935, -0.0673, -0.1120, -0.3783, -0.1313)),
                      mean(c(0.3180, 0.0724, -0.2109, -0.0476, 0.1431))),
                color = "average")) +
  
  geom_line(data = NULL, size=2,
            aes(x = seq(0,0.5,0.01), 
                y = coeff_set4$a * cos(2 * pi * coeff_set4$b * seq(0,0.5,0.01) + coeff_set4$c) * (1 - coeff_set4$d * seq(0,0.5,0.01)),
                color = "fit")) +
  
  geom_point(data = NULL, alpha = 0.5, size = 5, color = "red",
             aes(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500),
                 y = c(mean(c(0.4445, 0.4491, 0.6240, 0.5516, 0.3257)),
                       mean(c(-0.0174, -0.2074, 0.1609, -0.6433, 1.0333)),
                       mean(c(-0.2625, -0.5114, -0.8693, -0.9699, -1.0045)),
                       mean(c(-0.1203, -0.0609, -0.5065, -0.1917, -0.2423)),
                       mean(c(0.2935, -0.0673, -0.1120, -0.3783, -0.1313)),
                       mean(c(0.3180, 0.0724, -0.2109, -0.0476, 0.1431))))) +
  
  labs(title = "D-1 Graph", subtitle = paste0("frequency: ", round(mean(coeff_set4$b), digits = 3)), 
       x = "Distance", y = "y", colour = "Legend") +
  
  ylim(-1, 1)

#-----------------------------------------------------------------------------------------------------------------------------------------#

plotlist <- list()
datalist <- list()

#D-2 SUBJECT

for(i in 1:1000)
{
  #Col(n) is bootstrapping each column once to make an individual point every time the function loops
  bootstrap <- data.frame(y = as.numeric(c(
    ( rep_sample_n(data.frame(c(-0.7151, -0.1442, 0.2699, -0.0682, 0.4404)), size = 1, replace = TRUE, reps = 1) )[2], 
    ( rep_sample_n(data.frame(c(-0.6375, -0.3074, -0.3535, -0.7775, -0.4378)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(-0.1959, -0.5887, -0.4876, -0.2457, -0.5132)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.1589, -0.6600, -0.0103, 0.0064, 0.0466)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(-0.0103, 0.0116, 0.3276, 0.0129, -0.1366)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.1445, 0.1538, -0.0138, 0.0501, -0.0981)), size = 1, replace = TRUE, reps = 1) )[2])),
    x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500))
  
  #Applying the model w/ parameter estimates to the bootstrapped points
  samplefit <- nls(y ~ a * cos(2 * pi * b * x + c) * (1 - d * x) + e, # -- model we will be using
                   data = bootstrap,
                   
                   upper = c(a=1.3, b=1.3, c=8.75, d=5, e=0.2), # -- upper bound of parameter estimates
                   
                   start = c(a=0.8, b=1, c=7, d=2, e=0.1), # -- starting parameter estimates
                   
                   lower = c(a=0.1, b=0.8, c=6.5, d=0.1, e=0), # -- lower bound of parameter estimates
                   
                   algorithm = "port",
                   control = list(maxiter = 500, warnOnly=TRUE))
  
  
  #Lists that will record the coefficients of the model every time the for loop completes
  
  plotlist[i] <- list(c(list(c(predict(samplefit, list(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500))))),
                        list(c(0, 0.125, 0.250, 0.380, 0.440, 0.500))))
  
  datalist[i] <- list(c((summary(samplefit)$coefficients[1]), 
                        (summary(samplefit)$coefficients[2]), 
                        (summary(samplefit)$coefficients[3]), 
                        (summary(samplefit)$coefficients[4]),
                        (summary(samplefit)$coefficients[5])))
  
}

coeff_set5 <- data.frame(list(a=mean(as.numeric(unlist(datalist))[c(TRUE, FALSE, FALSE, FALSE, FALSE)]), 
                              b=mean(as.numeric(unlist(datalist))[c(FALSE, TRUE, FALSE, FALSE, FALSE)]), 
                              c=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, TRUE, FALSE, FALSE)]), 
                              d=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, FALSE, TRUE, FALSE)]),
                              e=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, FALSE, FALSE, TRUE)])))

pset5 <- 1/mean(coeff_set5$b)

data_set5 <- data.frame(x = unlist(as.numeric(unlist(plotlist))[c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)]), 
                        y = unlist(as.numeric(unlist(plotlist))[c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)]))

p5 <- ggplot() +
  
  geom_boxplot(data = data_set5, aes(x = x, y = y, group = x)) +
  
  geom_line(data = NULL, size=2,
            aes(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500),
                y = c(mean(c(-0.7151, -0.1442, 0.2699, -0.0682, 0.4404)),
                      mean(c(-0.6375, -0.3074, -0.3535, -0.7775, -0.4378)),
                      mean(c(-0.1959, -0.5887, -0.4876, -0.2457, -0.5132)),
                      mean(c(0.1589, -0.6600, -0.0103, 0.0064, 0.0466)),
                      mean(c(-0.0103, 0.0116, 0.3276, 0.0129, -0.1366)),
                      mean(c(0.1445, 0.1538, -0.0138, 0.0501, -0.0981))),
                color = "average")) +
  
  geom_line(data = NULL, size=2,
            aes(x = seq(0,0.5,0.01), 
                y = coeff_set5$a * cos(2 * pi * coeff_set5$b * seq(0,0.5,0.01) + coeff_set5$c) * (1 - coeff_set5$d * seq(0,0.5,0.01)) + coeff_set5$e,
                color = "fit")) +
  
  geom_point(data = NULL, alpha = 0.5, size = 5, color = "red",
             aes(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500),
                 y = c(mean(c(-0.7151, -0.1442, 0.2699, -0.0682, 0.4404)),
                       mean(c(-0.6375, -0.3074, -0.3535, -0.7775, -0.4378)),
                       mean(c(-0.1959, -0.5887, -0.4876, -0.2457, -0.5132)),
                       mean(c(0.1589, -0.6600, -0.0103, 0.0064, 0.0466)),
                       mean(c(-0.0103, 0.0116, 0.3276, 0.0129, -0.1366)),
                       mean(c(0.1445, 0.1538, -0.0138, 0.0501, -0.0981))))) +
  
  labs(title = "D-2 Graph", subtitle = paste0("frequency: ", round(mean(coeff_set5$b), digits = 3)), 
       x = "Distance", y = "y", colour = "Legend") +
  
  ylim(-1, 1)

#-----------------------------------------------------------------------------------------------------------------------------------------#

plotlist <- list()
datalist <- list()

#D-3 SUBJECT

for(i in 1:1000)
{
  #Col(n) is bootstrapping each column once to make an individual point every time the function loops
  bootstrap <- data.frame(y = as.numeric(c(
    ( rep_sample_n(data.frame(c(-0.9561, -0.5857, 0.1631, 0.5443, 0.2383)), size = 1, replace = TRUE, reps = 1) )[2], 
    ( rep_sample_n(data.frame(c(-0.2166, -0.1379, 0.1115, -0.9695, -0.8886)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.1562, -0.2614, -0.1955, -0.5219, -0.7310)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(-0.2661, -0.1304, -0.4877, -0.3091, -0.4695)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(-0.0840, 0.1177, 0.0761, -0.0225, -0.2828)), size = 1, replace = TRUE, reps = 1) )[2],
    ( rep_sample_n(data.frame(c(0.0675, 0.2410, 0.4049, 0.0632, -0.1384)), size = 1, replace = TRUE, reps = 1) )[2])),
    x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500))
  
  
  #Applying the model w/ parameter estimates to the bootstrapped points
  samplefit <- nls(y ~ a * cos(2 * pi * b * x + c) * (1 - d * x), # -- model we will be using
                   data = bootstrap,
                   
                   upper = c(a=1, b=2, c=9, d=2.25), # -- upper bound of parameter estimates
                   
                   start = c(a=0.4, b=1, c=7, d=1), # -- starting parameter estimates
                   
                   lower = c(a=0.1, b=0.5, c=6.5, d=0.1), # -- lower bound of parameter estimates
                   
                   algorithm = "port",
                   control = list(maxiter = 500, warnOnly=TRUE))
  
  
  #Lists that will record the coefficients of the model every time the for loop completes
  plotlist[i] <- list(c(list(c(predict(samplefit, list(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500))))),
                        list(c(0, 0.125, 0.250, 0.380, 0.440, 0.500))))
  
  datalist[i] <- list(c((summary(samplefit)$coefficients[1]), 
                        (summary(samplefit)$coefficients[2]), 
                        (summary(samplefit)$coefficients[3]), 
                        (summary(samplefit)$coefficients[4])))
  
}

coeff_set6 <- data.frame(list(a=mean(as.numeric(unlist(datalist))[c(TRUE, FALSE, FALSE, FALSE)]), 
                              b=mean(as.numeric(unlist(datalist))[c(FALSE, TRUE, FALSE, FALSE)]), 
                              c=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, TRUE, FALSE)]), 
                              d=mean(as.numeric(unlist(datalist))[c(FALSE, FALSE, FALSE, TRUE)])))

pset6 <- 1/mean(coeff_set6$b)

data_set6 <- data.frame(x = unlist(as.numeric(unlist(plotlist))[c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)]), 
                        y = unlist(as.numeric(unlist(plotlist))[c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)]))

p6 <- ggplot() +
  
  geom_boxplot(data = data_set6, aes(x = x, y = y, group = x)) +
  
  geom_line(data = NULL, size=2,
            aes(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500),
                y = c(mean(c(-0.9561, -0.5857, 0.1631, 0.5443, 0.2383)),
                      mean(c(-0.2166, -0.1379, 0.1115, -0.9695, -0.8886)),
                      mean(c(0.1562, -0.2614, -0.1955, -0.5219, -0.7310)),
                      mean(c(-0.2661, -0.1304, -0.4877, -0.3091, -0.4695)),
                      mean(c(-0.0840, 0.1177, 0.0761, -0.0225, -0.2828)),
                      mean(c(0.0675, 0.2410, 0.4049, 0.0632, -0.1384))),
                color = "average")) +
  
  geom_line(data = NULL, size=2,
            aes(x = seq(0,0.5,0.01), 
                y = coeff_set6$a * cos(2 * pi * coeff_set6$b * seq(0,0.5,0.01) + coeff_set6$c) * (1 - coeff_set6$d * seq(0,0.5,0.01)),
                color = "fit")) +
  
  geom_point(data = NULL, alpha = 0.5, size = 5, color = "red",
             aes(x = c(0, 0.125, 0.250, 0.380, 0.440, 0.500),
                 y = c(mean(c(-0.9561, -0.5857, 0.1631, 0.5443, 0.2383)),
                       mean(c(-0.2166, -0.1379, 0.1115, -0.9695, -0.8886)),
                       mean(c(0.1562, -0.2614, -0.1955, -0.5219, -0.7310)),
                       mean(c(-0.2661, -0.1304, -0.4877, -0.3091, -0.4695)),
                       mean(c(-0.0840, 0.1177, 0.0761, -0.0225, -0.2828)),
                       mean(c(0.0675, 0.2410, 0.4049, 0.0632, -0.1384))))) +
  
  labs(title = "D-3 Graph", subtitle = paste0("frequency: ", round(mean(coeff_set6$b), digits = 3)), 
       x = "Distance", y = "y", colour = "Legend") +
  
  ylim(-1, 1)

#-----------------------------------------------------------------------------------------------------------------------------------------#

#AVERAGE FREQUENCIES

data <- data.frame(period = c(
  log_odds1 = pset1, log_odds2 = pset2, log_odds3 = pset3, log_odds4 = pset4, log_odds5 = pset5, log_odds6 = pset6,
  S_avg = mean(c(pset1,pset2,pset3)), D_avg = mean(c(pset4, pset5, pset6))),
  frequencies = c(coeff_set1$b, coeff_set2$b, coeff_set3$b, 
                  coeff_set4$b, coeff_set5$b, coeff_set6$b,
                  mean(unlist(c(coeff_set1$b, coeff_set2$b, coeff_set3$b))),
                  mean(unlist(c(coeff_set4$b, coeff_set5$b, coeff_set6$b)))
  ))

View(data)

grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 3, nrow = 2)
