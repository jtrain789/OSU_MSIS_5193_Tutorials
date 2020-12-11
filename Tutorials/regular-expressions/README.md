# Regular Expressions
Processing data requires manipulating the data itself, especially when the data is text. In this module, you will learn how to filter text data to obtain the specific text you would like.

# Module Tasks
Please complete the following tasks:
* :notebook:Read the tutorial documentation below
* :school:Complete the ICE in class
* :computer:Complete the THA on your own

# All About Regular Expressions
A regular expression (regex) is an explicit set of characters constrained by linguistic and syntactic rules. Many programming languages support a regular expression processor to evaluate a regular expression statement. Many operating systems and programs utilize various forms of a regular expression processor to search for files, directories, or replace text. For example, when finding and replacing a word in a Microsoft Word document, the program uses a regular expression processor to find all the words that match the given criteria and replace them with a new word or phrase. Another example includes search engines such as Bing, Google, or Yahoo.

The syntax is quite similar across programming languages, whether its Java, C#, C++, or Python. The two major flavors of syntax are POSIX and Perl’s syntax. Perl Compatible Regular Expressions (PCRE) is a regular expression processor based on Perl’s system designed for use in other systems. Many programming languages have either adopted syntax similar to PCRE or use a version of PCRE itself. R, PHP, Python, Java, JavaScript, and .Net Framework all fall into this category. Some programming languages do have attempts by developers to create a POSIX-like library to compete with the PCRE library.

## How is it Used?
One of the main functions of regular expressions in programming languages is to parse text. For example, finding the word “cat” in the sentence “To catch a cat requires skill, not caterpillar-like slowness or cataract-like myopia.” Not too surprisingly, this technology has found a home in data science within text mining. The internet is filled with text from blogs, websites (financial, sports, automotive forums, etc.), social media platforms (Facebook, Twitter, Instagram, LinkedIn), ecommerce, online banking, and messenger apps. Previously, data science techniques and statistics were restricted to quantitative, numerical data types. With modern techniques—such as sentiment analysis—analyses with text are possible.

Prior to performing an example with R or Python, you first need to understand the underlying concepts of how regular expression processing actually operates. The reason is because you as a programmer must create the logic and rules for the regular expression processor to apply to a pattern. The following is an example to illustrate the kind of logic performed.

Let’s take the example sentence "To catch a cat requires skill, not caterpillar-like slowness or cataract-like myopia." The regex processor will break it down like so:

![img01](/assets/img01.png)

The width of the page does not allow for the full sentence to be displayed, but this will do just fine for me to illustrate the concept. Each character, including spaces and line breaks, are considered characters. Characters that run together, like words, are grouped together into blocks. 

Let's assume we would like to find any text with the characters "cat" in the sentence. We use a simple regex pattern of `cat`. The processor will start comparing the regex pattern to the entire sentence by incrementing each character like so:

![img02](/assets/img02.png)

The first 3 characters of the sentence do not contain a match, so the program continues. It will continue until it finds a match:

![img03](/assets/img03.png)

Continue searching...

![img04](/assets/img04.png)

Incrementing like so...

![img05](/assets/img05.png)

The index of the match is noted in memory and the system continues to search until it finds another match:

![img06](/assets/img06.png)

Then continue until it finds another match:

![img07](/assets/img07.png)

When the search is complete, the following words will be identified as matching: catch, cat, caterpillar, and cataract. Note, the results include four words instead of just *cat*. This is because we are not looking for just cat. In our example, the word "cat" is contained between two spaces. I would need to explicitly state within the regular expression processor that I am looking for ` cat `, with a blank space in front of it and another at the end. This will result in just " cat ", not the other three words.

This may seem surprising; after all, the word we wanted was cat. Yet, like any programming language, a programmer must explicitly set the parameters with exactness.

Regular expression processors are capable of more complex evaluations. Let’s use a simple example. You recently attended a student orientation and met another new student who could really help you pass all of your classes, but you are not sure what the spelling of her name is. You remember her name started with a "K" or "C," but had an "i" and "y" somewhere. Her name could be spelled one of four ways: Caitlyn, Caitlynn, Kaitlynn, or Kaitlyn. That leaves out Katelyn, Kaitlin, Katelynn, Katelin, and Kaitlin.

Before touching regex code, you have to first identify the logic of the names (similar to what you should be doing in programming R or Python). The first thing I would do is compare the names I want against those I do not want:

| Wanted Names | Unwanted Names |
|:---:|:---:|
| Caitlyn<br/>Caitlynn<br/>Kaitlynn<br/>Kaitlyn | Katelyn<br/>Kaitlin<br/>Katelynn<br/>Katelin<br/>Kaitlin |

At this point, I ask myself some questions:
* "What are the similarities of the names on the left-hand side?"
* "What are the similarities of those on the right?"
* "How are the left and right groups different?"

> Example: Take an opportunity and write/type answers to the questions above. Avoid looking at the diagram below if you can.

The answer to the questions above can be diagramed using a flow chart as shown below.

![img08](/assets/img08.png)

This helps ensure that the logic you create captures only the words you want and not others. Look at the flow chart above. The first step in logic is a choice between "C" and "K." The second step is straight forward, a selection of "aitly" for both branches. The last step is a choice between "n" and "nn." Notice that the first and third step requires "either-or" logic, similar to an if-else statement.

Time for a little regex code. Using square brackets in regex, you can specify a character class to create the "either-or" logic. For example, `[CK]` means either a "C" or a "K". This will not work for differentiating between "n" and "nn." If you used `[nnn]` it represents "n," or "n," or "n." Not what we want, especially because that doesn't make any sense.

Another metacharacter is the `|` *alternation* operator, colloquially called "or." This should look familiar to you. This is the same symbol used in R to represent the "OR" logical operator. The symbol `|` matches patterns on either side of the `|`. Thus, `n|nn` would provide the logic necessary. This can also be used for "C" and "K" like so: `C|K`. I prefer this notation, honestly. This is cleaner and easier to identify by reading through a page of code.

The final regex can be written as follows:
* `[CK]aitly(n|nn)`
* `(C|K)aitly(n|nn)`

While the above code represents the same thing, I prefer the second option mainly because it utilizes the *alternation* operator `|`. Like many things in programming, it is simply a preference. It's just that some preferences are better than others.

Note, in the examples above I used the parentheses `()` to section off characters. The square brackets `[]` are not used to "group" text together. Grouping text together, like the double n "nn" is performed using parentheses. The `[]` are used for alternation operations with singular characters.

Here is an example. Say I have a list of sports: baseball, softball, basketball, and football. Each of these words has the base word "ball." I can write a regular expression to capture any of these words lik so:

```
(base|soft|basket|foot)ball
```

I want to capture a multi-character block of text (e.g. base, soft, basket, foot), so I must use `()`. I cannot use the bracket `[]` because it will assume I want to search for b, a, s, e, s, o, f, t, b, a, s, k, etc. That is, it assumes I am looking for each individual letter. Thus, if you want to search for a group of text, block it off using `()`.

## Metacharacters For Regular Expressions
Regular expression syntax provides many meta-characters to designate options. You already learned about `|` and `[]`. The different types you will learn in this course include quantifiers, anchors, and character classes.

The first type, quantifiers, are used to determine the number of repetitions for a given pattern. These are placed after the character or a group of text contained within parentheses. For example, the asterisk matches at least zero times; meaning, the number of matches is arbitrary. `[CK]*` would match zero-, one-, five-, or six hundred-times.

The plus operator requires at least one match within a pattern. If you were trying to find a pattern in which a single digit is followed by a blank space, you would use the following: `[0123456789]+ ` or `[1|2|3|4|5|6|7|8|9]+ `. Here, I am trying to match any number between "0" and "9" with a space following it. 

If I wanted to find "1", "6", or "10" followed by a blank space, then I would use the following: `[1|6|10]+ `.

Symbol | Quantifier Description |
|:---:|:---|
| * | Matches at least 0 times (0 or more) |
| + | Matches at least 1 time (1 or more) |
| ? | Matches at most 1 time (0 or 1) |
| {n} | Matches exactly n times |
| {n,} | Matches at least n times (n or more) |
| {n,m} | Matches between n and m times, inclusive |

A good example of the use of the `?` metacharacter is to pattern match American or British spelling for some words.
* `colou?r` matches "color" or "colour"
* `labou?r` matches "labor" or "labour"

Another usage for the square brackets helps distinguish more American and British words:
* `defen[sc]e` matches "defense" or "defence"
* `analy[zs]e` matches "analyze" or "analyse"
* `organi[zs]e` matches "organize" or "organise"

> Example: Here is a simple one. You are given the following names: Chris, Christoff, Christopher, and Kris. Write a regular expression that captures all of the names. 

> Example: Similar to the previous one, but a little different. You are given the following names: Chris, Christoff, Christopher, and Kris. Write a regular expression that captures only "Chris," "Christopher," and "Christoff."

The following illustrates some of the usage of the quantifiers contained in the table above. Assume we have the following text:

> x xy xyz xyyz xyyyz xyyyyz

The following is a regular expression pattern I will apply to the text.

```
xy*z
```

Which words will be selected from the text based on that pattern? Take a moment and think without looking below. 

The answer is given below.

```
xyz, xyyz, xyyyz, xyyyyz
```

The `*` represents a match at least 0 times, but more is allowed. In this case, because it follows the `y`, the regular expression pattern indicates to find a string that matches 1 `x`, 0 or more `y`, and 1 `z`. Only the first two lines above, `x` and `xy`, would not be select.

> Example: Try out the following regex patterns below using the text "x xy xyz xyyz xyyyz xyyyyz". What results come from each of these patterns?

```
xy+z
yy+
xy?z
yy?
yy{1}
xy{2}z
xy{2,}z
xy{2,3}z
y{2,3}
```

One of the most common mistakes made by novices to regex is that the pattern you supply can be found at any point within a string. The last two regex patterns, `xy{2,3}z` and `y{2,3}`, illustrate this well. At first glance, both lines should return the same values: `xyyz` and `xyyyz`; yet, `y{2,3}` also returns `xyyyyz`. Remember, the logic provided by `y{2,3}` only indicates finding the patterns `yy` or `yyy` within a string. The string `xyyyyz` contains both of those patterns. If I only wanted a string with 3 ys at most, then `y{2,3}z` would be more restrictive.

| Symbol | Anchor Description |
|:---:|:---|
| ^ | Matches the start of the string |
| $ | Matches the end of the string |
| \b | Matches the empty string at both edges of a word |
| \B | Matches exactly n times |

The `^` and `$` are very handy because they designate specific places within text. Recall the example from earlier searching for the word *cat* within "To catch a cat requires skill, not caterpillar-like slowness or cataract-like myopia." This returned four results. If we wanted the exact word "cat" and not catch, caterpillar, or cataract, we can use the regular expression `^cat$`. If you used `^cat`, this still returns all four of the words catch, cat, caterpillar, and cataract because they all begin with "cat". By using the `$` at the end of our regular expression, we are looking for words that begin with "cat" with nothing following.

Ready for another example? Here is another text to try out some patterns. Each of these lines is a separate text.

```
abcd
cdab
cabd
c abd
```

Apply the following regular expression patterns.

```
ab
^ab
bd$
\\bab
```

Notice the last line of code uses a double backslash instead of a single backslash as shown in the table with `anchors`. This is because Perl requires the usage of an escape character. That is, the backslash is a reserved character, with other uses in the code. The double-backslash indicates the code should treat it as a single backslash. Translated, the code states, “Take the pattern `ab` and match a word, not a string, at the beginning and the end.”

Take a moment and determine the results of the patterns with the text.

Are you ready for the answers?

```
abcd, cdab, cabd, c abd
abcd
cabd, c abd
abcd, c abd
```

Here is an example for you to try on your own. This is similar to an earlier example, but it relies on you using an anchor to complete it.

> Example: You are given the following names: Chris, Christoff, Christopher, and Kris. Write a regular expression that captures "Chris" and "Christopher," but not "Christoff" and "Kris."

Other characters that require escaping include the following:
* \\': single quote
* \\": double quote
* \n: newline; this is equivalent to hitting the “return” or “enter” key on the keyboard, typically found in Unix systems and other derivatives (e.g. Linux) 
* \r: carriage return; like \n, but used in certain systems (pre-OSX Mac systems); the use of \n is more common in modern computing systems 
* \t: tab character

It should be noted that Windows uses `\r\n`, different from Unix and pre-OSX Mac systems. During the early creation of the internet, Windows was very prevalent, and this influenced text formats online. Thus, many various texts (including old webpages) use `\r\n` to terminate the end of a line. Think of a typewriter. The `\r` commands the carriage to return all the way to the left-hand side, stop, and then `\n` orders the roller to roll up one increment (i.e. roll up one line).  This is important to remember, especially when scraping webpages and other old text files.

While this may seem like an odd process, this was one of the only ways to create bold text with typewriters. After the initial line was typed, the carriage was slid back to the left and the same text typed out a second time, overlapping the first text.

Note, a "word" is not equivalent to a string. In the text above, the fourth string `c abd` contains two **words**: the letter `c` and `abd`. Thus, the anchor `\b` will look through each of those separately.

The last set of metacharacters to become familiar with include character classes. These are explicit sets of patterns you specify. Remember an earlier example in which you were trying to find a pattern in which a single digit is followed by a blank space: `[0123456789]+ `. A simpler way of producing this is `[0-9]+ `. If you want to look for any number ranging from 4 to 8, you would use `[4-8]`. Other character classes include the following:
* `[a-z]` all lowercase letters
* `[A-Z]` all uppercase letters
* `[A-z]` all uppercase and lowercase letters
* `[A-z0-9]` all uppercase, lowercase, and numerical values
* `[0-9A-Fa-f]` hexadecimal digits (base 16), 0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f
* `[^a-z]` all characters except lowercase letters
* `[^0-9]` all characters except numerals
* `[^A-z0-9]` all characters except alphanumeric ones
* `[^ABdy]` all characters except uppercase “A” and “B,” and lowercase “d” and “y”

The last metacharacter to become acquainted with is the period `.`. This is a wild card and will match any single character, including no character. The below example illustrates its usage.

```
catch
cater
ducat
scatter
locate
```

The following patterns are used for each line:

```
.cat
cat.
.cat.
```

The following results are given for each pattern.

```
ducat, scatter, locate
catch, cater, scatter, locate
scatter, locate
```

Are you ready to get your hands dirty with actual code? The below documentation will cover regular expression usage in R and Python more specifically. Notice how the syntax is nearly identical between the two. Again, this is because regular expressions exists outside of programming languages, almost like it is its own programming language.
* [Regex in R](assets/tutorial%20regex%20in%20r.md)
* [Regex in Python](assets/tutorial%20regex%20in%20python.md)

The accompanying example script files are found here:
1. [Example R file](assets/regex%20example.R)
2. [Example Python file](assets/regex%20example.py)

# Solution to Examples
> Example: Here is a simple one. You are given the following names: Chris, Christoff, Christopher, and Kris. Write a regular expression that captures all of the names.

```
(K|Ch)ris
```

> Example: Similar to the previous one, but a little different. You are given the following names: Chris, Christoff, Christopher, and Kris. Write a regular expression that captures only "Chris," "Christopher," and "Christoff."

```
Chris
```

> Example: Try out the following regex patterns below using the text "x xy xyz xyyz xyyyz xyyyyz". What results come from each of these patterns?

```
xy+z
yy+
xy?z
yy?
yy{1}
xy{2}z
xy{2,}z
xy{2,3}z
y{2,3}
```

Here is the answer:

```
xyz, xyyz, xyyyz, xyyyyz
xyyz, xyyyz, xyyyyz
xyz
xy, xyz, xyyz, xyyyz, xyyyyz
xyyz, xyyyz, xyyyyz
xyyz
xyyz, xyyyz, xyyyyz
xyyz, xyyyz
xyyz, xyyyz, xyyyyz
```

> Example: You are given the following names: Chris, Christoff, Christopher, and Kris. Write a regular expression that captures "Chris" and "Christopher," but not "Christoff" and "Kris."

```
Chris($|topher)
```
