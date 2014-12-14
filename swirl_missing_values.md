# Missing Values

Missing values play an important role in statistics and data analysis. Often, missing values must not be ignored, but rather they should be carefully studied to see if there's an underlying pattern or cause for their missingness.

In R, NA is used to represent any value that is 'not available' or 'missing' (in the statistical sense). In this lesson, we'll explore missing values further.

Any operation involving NA generally yields NA as the result. To illustrate, let's create a vector c(44, NA, 5, NA) and assign it to a variable x.

Now, let's multiply x by 3.

```R
> x <- c(44, NA, 5, NA)
> x * 3
[1] 132  NA  15  NA
```

Notice that the elements of the resulting vector that correspond with the NA values in x are also NA.

To make things a little more interesting, lets create a vector containing 1000 draws from a standard normal distribution with `y <- rnorm(1000)`.

Next, let's create a vector containing 1000 NAs with `z <- rep(NA, 1000)`.

Finally, let's select 100 elements at random from these 2000 values (combining y and z) such that we don't know how many NAs we'll wind up with or what positions they'll occupy in our final vector -- `my_data <- sample(c(y, z), 100)`.

Let's first ask the question of where our NAs are located in our data. The `is.na()` function tells us whether each element of a vector is NA. Call `is.na()` on `my_data` and assign the result to `my_na`.

```R
> my_na <- is.na(my_data)
> my_na
  [1] FALSE  TRUE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE
 [11] FALSE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE  TRUE  TRUE
 [21] FALSE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE  TRUE  TRUE
 [31]  TRUE  TRUE FALSE FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE
 [41] FALSE  TRUE  TRUE FALSE FALSE  TRUE  TRUE FALSE  TRUE  TRUE
 [51] FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE
 [61]  TRUE  TRUE FALSE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE
 [71] FALSE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE
 [81]  TRUE  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
 [91]  TRUE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE
```

Everywhere you see a TRUE, you know the corresponding element of `my_data` is NA. Likewise, everywhere you see a FALSE, you know the corresponding element of `my_data` is one of our random draws from the standard normal distribution.

In our previous discussion of logical operators, we introduced the `==` operator as a method of testing for equality between two objects. So, you might think the expression `my_data == NA` yields the same results as `is.na()`. Give it a try. Try `my_data == NA` to see what happens.

Don't worry if that's a little confusing. The key takeaway is to be cautious when using logical expressions anytime NAs might creep in, since a single NA value can derail the entire thing.

So, back to the task at hand. Now that we have a vector, my_na, that has a TRUE for every NA and FALSE for every numeric value, we can compute the total number of NAs in our data.

The trick is to recognize that underneath the surface, R represents TRUE as the number 1 and FALSE as the number 0. Therefore, if we take the sum of a bunch of TRUEs and FALSEs, we get the total number of TRUEs.

Let's give that a try here. Call the `sum()` function on `my_na` to count the total number of TRUEs in `my_na`, and thus the total number of NAs in `my_data`. Don't assign the result to a new variable.

Now that we've got NAs down pat, let's look at a second type of missing value -- NaN, which stands for 'not a number'. To generate NaN, try dividing (using a forward slash) 0 by 0 now.
