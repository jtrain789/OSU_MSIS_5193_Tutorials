# Regular Expression Patterns in R
Ready to run a real-world example? Run the following code in R:

```R
reg_string4 = c('To', 'catch', 'a', 'cat', 'requires', 'skill', 'not', 'caterpillar', 'like', 'slowness', 'or', 'cataract', 'like', 'myopia', 'asdcat')

grep("cat", reg_string4, perl = TRUE, value = FALSE)
grep("cat", reg_string4, perl = TRUE, value = TRUE)
```

The function `grep` is used to perform pattern matching and comes installed as part of the base R package. In the above example, two versions of the function are used. The argument value is set to `FALSE` in the first example and `TRUE` in the second. Did you observe the difference in the output?

Notice that the output results in 4 values: `catch, cat, caterpillar, and cataract`. Using a quantifier, how would you change the pattern in order to obtain just `cat` and not `catch`, `caterpillar`, and `cataract`?

The answer is simple enough:

```R
grep("cat$", reg_string4, perl = TRUE, value = TRUE)
```

Try some more examples:

```R
reg_string5 = c('catch', 'cat', 'caterpillar', 'cataract', 'asdcat', 'xycatzz', 'abc cat xyz')

grep("^cat", reg_string5, perl = TRUE, value = TRUE)
grep("cat$", reg_string5, perl = TRUE, value = TRUE)
grep("^cat$", reg_string5, perl = TRUE, value = TRUE)
grep("\\bcat\\b", reg_string5, perl = TRUE, value = TRUE)
```

What is the difference between the last two lines of code? Remember, the difference is related to pattern matching a string versus pattern matching a word.

The following video reviews the use of `grep()` in R:
* [:tv: Regular Expressions Using `grep`](https://youtu.be/fXPsGaAVqcM)

So far you have used the function `grep()`. The main purpose of this function is to pattern match, yet it has limitations. A more powerful and complete package is `stringr` which is found in `tidyverse`. To only install `stringr`, use the following code (or skip below to install `tidyverse`):

```R
install.packages('stringr')
```

Or, go ahead and install all of the `tidyverse` library which includes `stringr`. This is a rather large library compared to most R libraries, so if you are on a slow connection be prepared to sit back and wait a minute or so.

```R
install.packages('tidyverse')
```

R has some powerful string functions in the base package. Yet, a third-party has provided a library, `stringr`, with simpler and more straight-forward functions to help with processing text. The eight functions contained in `stringr` you should be familiar with are the following:
* `str_detect(input, pattern)` detects if a match exists for the given pattern by displaying `TRUE/FALSE` for each string within the vector
* `str_count(input, pattern)` counts the number of patterns identified in each string
* `str_subset(input, pattern)` similar to `str_detect()`, except displays the actual values from the string
* `str_locate(input, pattern)` identifies the position within the string of the matched pattern
* `str_extract(input, pattern)` extracts the actual matched text contained in the string
* `str_match(input, pattern)` extracts the matched text contained within a string based on the pieces of the pattern, not just the whole pattern
* `str_replace(input, pattern, replacement)` replaces the matched text with the given replacement text; normally, the base R functions `sub()` and `gsub()` are used
* `str_split(input, pattern)` splits the input vector into more strings based on the pattern

If you are using RStudio, you can install the addin `RegExplain` which provides a user-friendly interface for creating, testing, and using regular expressions. It provides on-the-fly, interactive creation of regex. Within RStudio, use the following code to install it. If you have already installed `devtools`, just ignore the first line of code.

```R
install.packages("devtools")
devtools::install_github("gadenbuie/regexplain")
```

The first function behaves similarly to `grep()` in identifying the existence of a matched pattern:

```R
reg_string6 = c('To', 'catch', 'a', 'cat', 'requires', 'skill', 'not', 'caterpillar', 'like', 'slowness', 'or', 'cataract', 'like', 'myopia')
str_detect(reg_string6, "cat")
sum(str_detect(reg_string6, "cat"))
```

The function `str_detect()` returns `TRUE/FALSE` values for each string. By placing the function within a `sum()` function, we can obtain a count of the number of matches contained within the vector. Alternatively, use `str_subset()` to display the actual values:

```R
str_subset(reg_string6, "cat")
```

Up until now we have been preoccupied with finding the word "cat." What if we want to find all the strings that do not contain the word "cat"?

```R
no_cat = !str_detect(reg_string6,"cat")
no_cat
```

To obtain the actual count of words, not strings, in the vector, use `str_count()` instead of `str_detect()` or `str_subset()`.

```R
reg_string7 = c('catch', 'cat', 'caterpillar', 'catcatcat', 'catcat', 'xycatzz', 'abc cat xyz')
str_count(reg_string7, "cat")
```

While very useful, `str_subset()` may not provide the values desired. It extracts the entire string containing the desired pattern. Execute the following code within R and look at the resulting 3 values.

```R
reg_string8 = c('To catch a cat requires', 'skill', 'not caterpillar-like slowness or', 'cataract', 'like myopia')
str_subset(reg_string8, "cat")
```

You should notice the result contains the entirety of the string. In order to obtain just the pattern you want, you must use `str_extract()` to pull the pattern-matching content from each string. 

```R
matched_strings1 = str_subset(reg_string8, "cat")
(matches1 = str_extract(matched_strings1, "cat"))
```

Another example can help illustrate the usefulness of this function. The library `stringr` has three built-in data files (fruit, sentences, and words) for practicing with its functions. We will use the data file fruit.

```R
length(fruit)
head(fruit)
```

We are interested in finding every single fruit that contains the words "fruit" or "berry." To do that, we need to build a pattern. Most fruit names that contain "berry" or "fruit" in their name have "berry" and "fruit" at the end. Yet, we may not know every single fruit name, so we will leave the option open in case a fruit name possesses one or both at the beginning or even middle of the name.

```R
fruit_types = c('berry', 'fruit')
fruit_regex = str_c(fruit_types, collapse = "|")
fruit_regex
```

The previous code may seem excessive, yet it may prove useful in the future. Sometimes as a data scientist you may have to automate the entire process of creating and using regex patterns. For example, perhaps you would like to search through online news websites for companies who experienced data breaches within the last year. The program you write automatically extracts the ticker symbol for 15 companies. You could manually type each ticker symbol into a new R script or you could have your existing R script take those ticker symbols and, using the `str_c()` function, create a new regex pattern automatically. This becomes highly flexible. You could potentially leave the program to run on its own over time, allowing it to dynamically grab more ticker symbols as different companies experience data breaches.

```R
(matched_strings2 = str_subset(fruit, fruit_regex))
(matches2 = str_extract(matched_strings2, fruit_regex))
```

One of the properties of `str_extract()` is that it only extracts the first value. This means if a string contains more than one possible pattern match, only the first will be selected and extracted, not the second, third, etc. Recall the following code:

```R
reg_string8 = c('To catch a cat requires', 'skill', 'not caterpillar-like slowness or', 'cataract', 'like myopia')
str_subset(reg_string8, "cat")
matched_strings1 = str_subset(reg_string8, "cat")
(matches1 = str_extract(matched_strings1, "cat"))
```

The first string "To catch a cat requires" contains two possible results, yet only "catch" is selected for extraction. In order to extract all matching values, use the function `str_extract_all()`.

```R
matches_more = str_extract_all(matched_strings1, "cat")
matches_more
```

If you are following along, you will notice the output looks different than previous solutions. Notice the three numbers contained in the double brackets `[[#]]` indicating the index value of each string. The first string "To catch a cat requires" returns two values under `[[1]]`, the first for *catch* and the second for *cat*.

To clean this output up and streamline the results, you can use the argument `simplify=TRUE`, like so:

```R
matches_more = str_extract_all(matched_strings1, "cat", simplify=TRUE)
matches_more
```

The next function you will learn about in this tutorial is `str_match()`. This function extracts the matched parts of a pattern as defined within the function. What if we would like to find all the vowels couched within other characters?

```R
reg_string6 = c('To', 'catch', 'a', 'cat', 'requires', 'skill', 'not', 'caterpillar', 'like', 'slowness', 'or', 'cataract', 'like', 'myopia')
str_match(reg_string6, "(.)[aeiou](.)")
```

The results show that all the strings except the first, third, and eleventh match the given pattern: *To*, *a*, and *or*. Another good example comes from Garrett Grolemund and Hadley Wickham using the data file `sentence`, contained within `stringr`. Feel free to explore the data file a little.

The objective of their example is to extract nouns from the sentences. Nouns typically follow "a" and "the" within a sentence. 

```R
noun = "(a|the) ([^ ]+)"
matched_strings3 = str_subset(sentences, noun)
matches3 = str_extract(matched_strings3, noun)
head(matches3)
matches4 = str_match(matched_strings3, noun)
head(matches4)
```

Compare the results of `matches3` and `matches4`. The result of using `str_match()` breaks down the component parts in addition to giving the entire matched string.

The following video covers various functions using `stringr`:
* [:tv: Regular Expressions Using `stringr`](https://youtu.be/swkDI9uOlkI)
