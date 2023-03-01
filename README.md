# Data Analysis of Substantially-Small Data Sets (2020-2021)
_David Sanchez, davids1lite@gmail.com, high school-level project; Salk Institute for Biological Studies_

R program that analyzes sinusoidal trends in 6 substantially small data sets by [bootstrapping](https://machinelearningmastery.com/a-gentle-introduction-to-the-bootstrap-method/#:~:text=The%20bootstrap%20method%20is%20a%20statistical%20technique%20for%20estimating%20quantities,after%20they%20have%20been%20chosen.) 216 data points to generate 36,000 new data points to artifically create a Gaussian/normal distribution for a more accurate approximation of any hidden trend.

- Each set contains 6 data point "ranges", with each range containing 6 possible data points.  Random selection (bootstrap generation) is performed upon each of these ranges to generate 6 points for analysis.
- Bootstraps each data set 1,000 times to simulate a normal/Gaussian distribution containing 6,000 new data points total per set for a total of 36,000 new data points
- Every single bootstrap iteration (1,000 iterations) fits a sinusoidal model: y = a * cos(2π * b * x + c) * (1 - d * x).  All 1,000 approximated models per set are averaged into a final model

Produces a graph which contains:
1. a boxplot showing the distribution of the 36,000 bootstrapped data points (1,000 per data point, 5,000 per set), including quartile ranges and outliers for each individual data point (alpha 0.05)
2. 36 averaged data points calculated from bootstrapped data points, connected by a linear piecewise function (red line)
3. 6 average sinusoidal models calculated from 6,000 model estimations of bootstrapped data points (1,000 iterations per set, blue line)
4. individual approximated frequencies of each of the 6 average sinusoidal models 

Known flaws/bugs:
- Runtime of the program is unbelievably obsolete (≥O(n^2)).  Would be implemented more effectively in MATLAB or Python
- Ignores divergent sinusoidal approximations and treats them as outliers
- Hard-to-read formatting

<br>

## Bootstrap explanation, details of 6 data sets



## Differences between the two .R files

### bootstrap-project-public.R 
- Contains a runnable version of the data sets which I worked with on my local computer.  Should be able to run from any device since all data points are contained within the file.  Does not truly represent the length of the code
- Produces data file that contains all of the numbers calculated from the sinusoidal average fits per data set
- 6 individual sets containing 6 data ranges each with 36 unique data points collected from Salk Institute data for analysis (216 total raw data points)

![Image](sample-graph-image.jpg)
![Image](sample-data-image.jpg)

<br>

### bootstrap-project-unusable.R 
- Contains the version which I ran from my computer using personal folder/file paths to reduce the size of the program.  File paths do not work on any other computer; only included to show how compact the code can be
- Accurately reflects the actual length of code
- removes the red linear piecewise function and averaged point per graph from bootstrap-project-public.R.  Only contains the fitted average sinusoidal model

![Image](unusable-example.png)

_Runtime between both files are identical._
