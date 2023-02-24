# Data Analysis of Substantially-Small Data Sets
R program that analyzes sinusoidal trends in 6 substantially small sets containing 5 data points each by bootstrap generating 30,000 new data points (6 sets, 5,000 new data points) to simulate a normal distribution for a more accurate approximation of any hidden trend.  Main project at the Salk Institute for Biological studies.

- Bootstraps each data set 1,000 times to simulate a normal/Gaussian distribution containing 5,000 new data points total per set for a total of 30,000 new data points
- Every single bootstrap iteration (1,000 iterations) fits a sinusoidal model: y = a * cos(2π * b * x + c) * (1 - d * x).  All 1,000 approximated models per set are averaged into a final model

Produces a graph which contains:
(1) a boxplot showing the distribution of the 30,000 bootstrapped data points (1,000 per data point, 5,000 per set), including quartile ranges and outliers for each individual data point (alpha 0.05)
(2) 30 averaged data points calculated from bootstrapped data points, connected by a linear piecewise function (red line)
(3) 6 average sinusoidal models calculated from 6,000 model estimations of bootstrapped data points (1,000 iterations per set, blue line)
(4) individual approximated frequencies of each of the 6 average sinusoidal models 

Known flaws/bugs:
- Runtime of the program is unbelievably obsolete.  Would be implemented more effectively in MATLAB or Python
- Ignores divergent sinusoidal approximations and treats them as outliers
- Hard-to-read formatting

## Differences between two .R files
bootstrap-project-public.R contains a runnable version of the data sets which I worked with on my local computer.  Should be able to run from any device since all data points are contained within the file.

bootstrap-project-clean.R contains the version which I ran from my computer using personal folder/file paths to reduce the size of the program.  File paths do not work on any other computer; only included to show how compact the code can be.  

Runtime between both files are identical.
