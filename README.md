
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vCardR

<!-- badges: start -->
<!-- badges: end -->

The goal of vCardR is to generate `*.vcf`-format contact book in batch.

## Installation

You can install the development version of vCardR from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("gaospecial/vCardR")
```

## Example

Suppose we have a data sheet with several entries.

``` r
file = system.file("extdata", "contact.csv", package = "vCardR")
contact_book = read.csv(file)
contact_book
#>   name        cell    org
#> 1  Tom 13033339999 Google
#> 2 Jack 13800000000  Baidu
```

Build VCARD for every person.

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(vCardR)
vcf = contact_book %>% 
  rowwise() %>% 
  mutate(vcard = vcard(name = name, cell = cell, org = org)) %>% 
  pull(vcard)
```

And write the contact list to a `vcf` file using `xfun::write_utf8()`.

``` r
xfun::write_utf8(vcf, "contact.vcf")
```

Now, the `vcf` file can be easily imported into smartphone contact list.
