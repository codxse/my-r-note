# Subsetting Vectors

In this lesson, we'll see how to extract elements from a vector based on some conditions that we specify.

For example, we may only be interested in the first 20 elements of a vector, or only the elements that are not NA, or only those that are positive or correspond to a specific variable of interest. By the end of this lesson, you'll know how to handle each of these scenarios.

I've created for you a vector called x that contains a random ordering of 20 numbers (from a standard normal distribution) and 20 NAs. Type x now to see what it looks like.

```R
> x
 [1] -0.47718135  0.33116609 -0.25268807  0.19613682
 [5] -0.39199251 -0.73018616 -1.51894441          NA
 [9]          NA          NA -1.03360511          NA
[13]          NA          NA  0.52214131          NA
[17]  0.75907817          NA  0.15619301          NA
[21]  0.03343244          NA  0.26523200 -0.09351152
[25]          NA          NA -0.36355033          NA
[29]  0.22676559  1.04133703          NA  0.65503337
[33]          NA  0.07432777          NA          NA
[37]          NA          NA          NA -1.06779196
```

The way you tell R that you want to select some particular elements (i.e. a 'subset') from a vector is by placing an 'index vector' in square brackets immediately following the name of the vector.

For a simple example, try `x[1:10]` to view the first ten elements of x.

```R
> x[1:10]
 [1] -0.4771814  0.3311661 -0.2526881  0.1961368 -0.3919925
 [6] -0.7301862 -1.5189444         NA         NA         NA
```

Index vectors come in four different flavors -- logical vectors, vectors of positive integers, vectors of negative integers, and vectors of character strings -- each of which we'll cover in this lesson.

Let's start by indexing with logical vectors. One common scenario when working with real-world data is that we want to extract all elements of a vector that are not NA (i.e. missing data). Recall that `is.na(x)` yields a vector of logical values the same length as x, with TRUEs corresponding to NA values in x and FALSEs corresponding to non-NA values in x.

Remember that is.na(x) tells us where the NAs are in a vector. So if we subset x based on that, what do you expect to happen?

```R
> x[is.na(x)]
 [1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
```

Recall that `!` gives us the negation of a logical expression, so `!is.na(x)` can be read as 'is not NA'. Therefore, if we want to create a vector called y that contains all of the non-NA values from x, we can use `y <- x[!is.na(x)]`. Give it a try.

```R
> y <- x[!is.na(x)]
> y
 [1] -0.47718135  0.33116609 -0.25268807  0.19613682 -0.39199251
 [6] -0.73018616 -1.51894441 -1.03360511  0.52214131  0.75907817
[11]  0.15619301  0.03343244  0.26523200 -0.09351152 -0.36355033
[16]  0.22676559  1.04133703  0.65503337  0.07432777 -1.06779196
```

Now that we've isolated the non-missing values of x and put them in y, we can subset y as we please.

Recall that the expression `y > 0` will give us a vector of logical values the same length as y, with TRUEs corresponding to values of y that are greater than zero and FALSEs corresponding to values of y that are less than or equal to zero. What do you think `y[y > 0]` will give you?

```R
> y[y > 0]
 [1] 0.33116609 0.19613682 0.52214131 0.75907817 0.15619301 0.03343244
 [7] 0.26523200 0.22676559 1.04133703 0.65503337 0.07432777
 ```

You might wonder why we didn't just start with `x[x > 0]` to isolate the positive elements of x. Try that now to see why.

```R
> x[x > 0]
 [1] 0.33116609 0.19613682         NA         NA         NA         NA
 [7]         NA         NA 0.52214131         NA 0.75907817         NA
[13] 0.15619301         NA 0.03343244         NA 0.26523200         NA
[19]         NA         NA 0.22676559 1.04133703         NA 0.65503337
[25]         NA 0.07432777         NA         NA         NA         NA
[31]         NA
```

Since NA is not a value, but rather a placeholder for an unknown quantity, the expression NA > 0 evaluates to NA. Hence we get a bunch of NAs mixed in with our positive numbers when we do this.

Combining our knowledge of logical operators with our new knowledge of subsetting, we could do this -- `x[!is.na(x) & x > 0]`. Try it out.

```R
> x[!is.na(x) & x > 0]
 [1] 0.33116609 0.19613682 0.52214131 0.75907817 0.15619301 0.03343244
 [7] 0.26523200 0.22676559 1.04133703 0.65503337 0.07432777
```

In this case, we request only values of x that are both non-missing AND greater than zero.

I've already shown you how to subset just the first ten values of x using `x[1:10]`. In this case, we're providing a vector of positive integers inside of the square brackets, which tells R to return only the elements of x numbered 1 through 10.

Many programming languages use what's called 'zero-based indexing', which means that the first element of a vector is considered element 0. R uses 'one-based indexing', which (you guessed it!) means the first element of a vector is considered element 1.

Can you figure out how we'd subset the 3rd, 5th, and 7th elements of x? Hint -- Use the c() function to specify the element numbers as a numeric vector.

```R
> x[c(3, 5, 7)]
[1] -0.2526881 -0.3919925 -1.5189444
```

It's important that when using integer vectors to subset our vector x, we stick with the set of indexes {1, 2, ..., 40} since x only has 40 elements. What happens if we ask for the zeroth element of x (i.e. `x[0]`)? Give it a try.

```R
> x[0]
numeric(0)
```

As you might expect, we get nothing useful. Unfortunately, R doesn't prevent us from doing this. What if we ask for the 3000th element of x? Try it out.

```R
> x[3000]
[1] NA
```

Again, nothing useful, but R doesn't prevent us from asking for it. This should be a cautionary tale. You should always make sure that what you are asking for is within the bounds of the vector you're working with.

What if we're interested in all elements of x EXCEPT the 2nd and 10th? It would be pretty tedious to construct a vector containing all numbers 1 through 40 EXCEPT 2 and 10.

Luckily, R accepts negative integer indexes. Whereas `x[c(2, 10)]` gives us ONLY the 2nd and 10th elements of x, `x[c(-2, -10)]` gives us all elements of x EXCEPT for the 2nd and 10 elements.  Try `x[c(-2, -10)]` now to see this.

```R
> x[c(-2, -10)]
 [1] -0.47718135 -0.25268807  0.19613682 -0.39199251 -0.73018616
 [6] -1.51894441          NA          NA -1.03360511          NA
[11]          NA          NA  0.52214131          NA  0.75907817
[16]          NA  0.15619301          NA  0.03343244          NA
[21]  0.26523200 -0.09351152          NA          NA -0.36355033
[26]          NA  0.22676559  1.04133703          NA  0.65503337
[31]          NA  0.07432777          NA          NA          NA
[36]          NA          NA -1.06779196
```

A shorthand way of specifying multiple negative numbers is to put the negative sign out in front of the vector of positive numbers. Type `x[-c(2, 10)]` to get the exact same result.

```R
> x[c(-2, -10)]
 [1] -0.47718135 -0.25268807  0.19613682 -0.39199251 -0.73018616
 [6] -1.51894441          NA          NA -1.03360511          NA
[11]          NA          NA  0.52214131          NA  0.75907817
[16]          NA  0.15619301          NA  0.03343244          NA
[21]  0.26523200 -0.09351152          NA          NA -0.36355033
[26]          NA  0.22676559  1.04133703          NA  0.65503337
[31]          NA  0.07432777          NA          NA          NA
[36]          NA          NA -1.06779196
```

So far, we've covered three types of index vectors -- logical, positive integer, and negative integer. The only remaining type requires us to introduce the concept of 'named' elements.

Create a numeric vector with three named elements using `vect <- c(foo = 11, bar = 2, norf = NA)`.

```R
> vect <- c(foo = 11, bar = 2, norf = NA)
> vect
> vect
 foo  bar norf
  11    2   NA
```

We can also get the names of vect by passing vect as an argument to the `names()` function. Give that a try.

```R
> names(vect)
[1] "foo"  "bar"  "norf"
```

Alternatively, we can create an unnamed vector `vect2` with `c(11, 2, NA)`. `vect2 <- c(11, 2, NA)`.

Then, we can add the `names` attribute to vect2 after the fact with `names(vect2) <- c("foo", "bar", "norf")`.

Now, let's check that vect and vect2 are the same by passing them as arguments to the `identical()` function.

```R
> identical(vect, vect2)
[1] TRUE
```

Now, back to the matter of subsetting a vector by named elements. Which of the following commands do you think would give us the second element of vect?

Now, back to the matter of subsetting a vector by named elements. Which of the following commands do you think would give us the second element of vect?

1. `vect["bar"]`
2. `vect["2"]`
3. `vect[bar]`

```R
> vect["bar"]
bar
  2
```

Likewise, we can specify a vector of names with `vect[c("foo", "bar")]`. Try it out.

```R
> vect[c("foo", "bar")]
foo bar
 11   2
```

Now you know all four methods of subsetting data from vectors. Different approaches are best in different scenarios and when in  doubt, try it out!
