
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dataPkgTest03

<!-- badges: start -->

<!-- badges: end -->

The goal of dataPkgTest03 is to show that a data package can be
constructed and maintained by yours truly. Containted herein are two
copied functions from Rpackages (book) and rough drafts of data to be
used in a future package for Harvard’s gov 1005/1006 courses.

## Installation

You can install the released version of dataPkgTest03 from
[CRAN](https://CRAN.R-project.org) with: LINK TO BE POSTED WHEN
AVAILABLE

``` r
install.packages("dataPkgTest03")
```

## Example

Install the package, then load the library. This is necessary as the
package hasn’t been released and will need to be done once the repo is
cloned to your local environment for the moment.

``` r
## Step #1

install()
```

``` r

## Proceed as normal

library(dataPkgTest03)
```

This package currently hosts a cleaned up version of the data from the
Enos (2016) paper that analyzes exclusionary behavior and its change
throughout an experiment conducted on the Boston T lines.

``` r

# Run this to view data descriptions, unit information, etc. 

?enos_train
```

``` r

glimpse(enos_train)
#> Rows: 115
#> Columns: 9
#> $ male       <int> 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0,...
#> $ liberal    <int> 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1,...
#> $ republican <int> 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0,...
#> $ age        <dbl> 31, 34, 63, 45, 55, 37, 53, 36, 54, 42, 33, 50, 24, 40, ...
#> $ income     <dbl> 135000, 105000, 135000, 300000, 135000, 87500, 87500, 13...
#> $ treatment  <fct> Treated, Treated, Treated, Treated, Control, Treated, Co...
#> $ att_start  <dbl> 11, 9, 3, 11, 8, 13, 13, 10, 12, 9, 10, 11, 13, 6, 8, 13...
#> $ att_end    <dbl> 11, 10, 5, 11, 5, 13, 13, 11, 12, 10, 9, 9, 13, 7, 8, 13...
#> $ att_chg    <dbl> 0, 1, 2, 0, -3, 0, 0, 1, 0, 1, -1, -2, 0, 1, 0, 0, 1, 0,...
```

The datasets included here are ready to use as one would normally employ
tibbles / other similar data frame objects in R\!

``` r

# 5-minute example to substantiate the above claim

data <- enos_train %>% 
  mutate(Linc = log(income))

fit <- glm(data = data, Linc ~ age)

enos_train %>% 
  ggplot(aes(x = age, y = log(income))) + 
  geom_jitter() +
  geom_abline(slope = coef(fit)[2], intercept = coef(fit)[1], color = "red") +
  labs(
    y = "Log Income",
    x = "Age",
    title = "Example: Exploring Enos' Data",
    caption = "Data from Enos (2016), cleaned data from Preceptor D. Kane"
  )
```

    #> Warning in dev(filename = filename, width = dim[1], height = dim[2], ...):
    #> 'width=7, height=4' are unlikely values in pixels

![Check it out](img1)

More datasets to come, as well as resources regarding the raw data sets
for those interested in the pre-cleaned frames.
