# Cascading Style Sheets (CSS)
Earlier I stated that `<div></div>` tags did much to improve the look and feel of websites. That was only half the story. The other half includes cascading style sheets, or CSS. I remember when CSS was officially released and supported by Internet Explorer. I thought, "Who needs another method of formatting HTML? I already can do this natively inside each HTML tag." I ignored it for some time. CSS then iterated through multiple versions, seeing vast improvements over this period.

When I picked it up again I realized how powerful it was. One of the first things I loved is being able to create global formatting for specific *categories* of tags, not just a family of tags. For example, I could create multiple formats for the `<a></a>` tag instead of one format that applied to all of them. Such customization!

With the advent of CSS came the "dynamic" Web or Web 2.0. Websites were no longer static, lifeless things. You coud interact with them dynamically, even see changes without having to reload the webpage. This was truly incredible. Personally, I feel this was a major contributor to the Web moving from us being "content consumers" to "content creators".

If at any time you need to look up more information on a topic here, you can use this reference section: [CSS Reference](https://www.w3schools.com/cssref/default.asp).

You will not cover every topic for CSS. If you compare the items below to what [w3schools.com](https://www.w3schools.com) offers, you will barely cover the topic. What you need to learn from this section is the syntax and structure of CSS. Like HTML, this will play a large role in scraping data from a website. CSS, in conjunction with HTML, creates a structure in the code itself. That structure is what you will navigate.

## Basics of CSS
Here you will learn about what CSS is, the syntax, and how to format it. This is a little different from HTML, but still a scripting language. After this section, review the other sections below.
* [CSS Introduction](https://www.w3schools.com/css/css_intro.asp)
* [CSS Syntax](https://www.w3schools.com/css/css_syntax.asp)
* [CSS How To](https://www.w3schools.com/css/css_howto.asp)
* [CSS Comments](https://www.w3schools.com/css/css_comments.asp)
* [CSS Colors](https://www.w3schools.com/css/css_colors.asp)
* [HTML CSS](https://www.w3schools.com/html/html_css.asp)

## Navigation and Structure
This is the most important section for CSS. As I mentioned earlier, CSS, paired with HTML, creates a structure for a webpage. In this section you will see how CSS and HTML are intimately connected. The first item covers menu and navigation bars. All modern websites and many mobile apps rely on these types of menus for navigation. In fact, many mobile apps are just mobile websites wrapped into a tiny package (hence, why those types of mobile apps are referred to as a web-wrapper).
* [Navbar](https://www.w3schools.com/css/css_navbar.asp)
* [Vertical Navbar](https://www.w3schools.com/css/css_navbar_vertical.asp)
* [Horizontal Navbar](https://www.w3schools.com/css/css_navbar_horizontal.asp)

The second topic you will cover in this subsection is website layout. Websites have different structural components. At the top you will usually find the menu (though it could be placed on the left-hand side of the webpage); at the bottom is a footer which contains contact information, links to related websites, webpages for the website, and a webpage referred to as "About" for a company; and the main body between the header and footer which displays the content of the webpage. 

Understanding the layout of a webpage is crucial to your ability to pull data from it. You may need to review these concepts multiple times in order to understand structure.
* [CSS Float](https://www.w3schools.com/css/css_float.asp)
* [CSS Clear](https://www.w3schools.com/css/css_float_clear.asp)
* [CSS Float Examples](https://www.w3schools.com/css/css_float_examples.asp)
* [CSS Website Layout](https://www.w3schools.com/css/css_website_layout.asp)

## CSS Selectors and Web Scraping
This is the last major topic to cover in this tutorial and the most related to web scraping. Many various methods exist to connect CSS styles to specific HTML tags. Each of these are covered below.
* [CSS Selectors](https://www.w3schools.com/css/css_selectors.asp)
* [CSS Combinators](https://www.w3schools.com/css/css_combinators.asp)
* [CSS Attribute Selector](https://www.w3schools.com/CSS/css_attribute_selectors.asp)
* [CSS Pseudo-class](https://www.w3schools.com/css/css_pseudo_classes.asp)
* [CSS Pseudo-element](https://www.w3schools.com/css/css_pseudo_elements.asp)

As you just learned, many methods exist for assigning CSS to HTML tags.
* Inline Styles: Embedded in the HTML tag itself using the `style=""` attribute. 
* ID: A unique identifier assigned to a HTML tag, marking it as distinct.
* Classes, attributes, pseudo-classes, and elements

### Inline Styles
This is the most simple method for assigning a CSS style to HTML. The below example changes the color of an anchor tag to orange.

```HTML
<a href="https://www.okstate.edu" style="color:orange;">OSU</a>
```

You will not be relying on this type of specificity in web scraping. Unfortunately, this type of style assignment does not help to create the structure of a website. Ensure you are aware of this, because many a student will attempt to use this to reference a HTML tag when web scraping and receive an error.

### ID Assignment
This specificity is perhaps the most useful of all for web scraping. Essentially, this acts like a primary key for a database. Assuming the developer of the webpage used it correctly, only a single HTML tag will use one ID.

```HTML
<a id="osu_link" href="https://www.okstate.edu" style="color:orange;">OSU</a>
<a id="byu_link" href="https://www.byu.edu" style="color:blue;">BYU</a>
<a href="https://github.com/" class="navigation">Git Hub</a>
```

In the example above, three anchor tags provide links to three different websites. The first two links have assigned IDs; the third does not. Searching for the first two anchor tags in a webpage full of HTML tags is so much easier compared to searching for the third anchor tag.

Here is an example of what I am referring to. Look for those three anchor tags within this code:

```HTML
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
{
  box-sizing: border-box;
}
body {
  font-family: Arial;
  padding: 10px;
  background: #f1f1f1;
}
/* Header/Blog Title */
.header {
  padding: 30px;
  text-align: center;
  background: white;
}
.header h1 {
  font-size: 50px;
}
/* Style the top navigation bar */
.topnav {
  overflow: hidden;
  background-color: #333;
}
/* Style the topnav links */
.topnav a {
  float: left;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

/* Change color on hover */
.topnav a:hover {
  background-color: #ddd;
  color: black;
}
/* Left column */
.leftcolumn {   
  float: left;
  width: 75%;
}
/* Right column */
.rightcolumn {
  float: left;
  width: 25%;
  background-color: #f1f1f1;
  padding-left: 20px;
}
.card {
  background-color: white;
  padding: 20px;
  margin-top: 20px;
}
.row:after {
  content: "";
  display: table;
  clear: both;
}
/* Navigation */
.navigation {
  color: purple;
  size: 3em;
}
/* Footer */
.footer {
  padding: 20px;
  text-align: center;
  background: #ddd;
  margin-top: 20px;
}
@media screen and (max-width: 800px) {
  .leftcolumn, .rightcolumn {   
    width: 100%;
    padding: 0;
  }
}
@media screen and (max-width: 400px) {
  .topnav a {
    float: none;
    width: 100%;
  }
}
</style>
<meta charset="utf-8" />
<title></title>
</head>
<body>
<div class="header">
  <h1>My Website</h1>
  <p>Welcome to a website. About nothing. Nothing at all.</p>
</div>

<div class="topnav">
  <a href="#">Link to nowhere</a>
  <a href="#">Link to not there</a>
  <a href="#">Link to not here</a>
  <a href="#" style="float:right">Link</a>
</div>

<div class="row">
<div class="leftcolumn">
<div class="card">
      <h2>TITLE HEADING</h2>
      <h5>Title description, Dec 7, 2017</h5>
      <div class="fakeimg" style="height:200px;">Image</div>
      <p>These are not the anchor tags you are looking for.</p>
      <a id="ubuntu_link" href="https://ubuntu.com" class="navigation">Ubuntu</a>
      <a href="https://hadoop.apache.org" style="color:blue;">Hadoop</a>
      <a id="githubclass" href="https://classroom.github.com/" class="navigation">Git Hub Classroom</a>
    </div>
    <div class="card">
<h2>Some Title Here</h2>
    <p>Some text..</p>
    <a id="osu_link" href="https://www.okstate.edu" style="color:orange;">OSU</a>
    <a id="byu_link" href="https://www.byu.edu" style="color:blue;">BYU</a>
    <a href="https://github.com/" class="navigation">Git Hub</a>
</div>
</div>
</div>
<div class="footer">
<h2>Footer</h2>
</div>
</body>
</html>
```

How long did it take you to find those anchor tags? Compared to most websites, this was very simple. You can use the browser command `Ctrl+F` to search quickly for the ID *osu_link*. This is similar to what R and Python can do if a HTML tag has an assigned ID.

The link to `https://github.com` is more difficult. It has no ID. It's just an anchor tag like so many others. How would you find that amidst a sea of HTML code? Especially if you are dealing with a webpage that has hundreds and hundreds of lines of code.

### Classes, Attributes, Elements, and Pseudo-Classes
The reality is that very few HTML tags will have assigned IDs, making web scraping tough for you. What they will typically have is a CSS class assigned. In the previous example above notice the links for Ubuntu, GitHub Classroom, and GitHub all have the `class="navigation"` attribute in the anchor tag. 

```HTML
<a id="ubuntu_link" href="https://ubuntu.com" class="navigation">Ubuntu</a>
<a id="githubclass" href="https://classroom.github.com/" class="navigation">Git Hub Classroom</a>
<a href="https://github.com/" class="navigation">Git Hub</a>
```

While not as unique, this does provide you with a way to narrow down your search for specific HTML tags. When you "search" for a tag with `class="navigation"` you will receive multiple results, instead of just one result using the ID. While not perfect, this is better than nothing.

Ultimately, you will use whatever is conveniently available to you. Using CSS Selectors to scrape data from a webpage is handy because modern websites rely heavily on CSS. An alternative does exist, called XML Path Language or XPath for short. We will cover that in a later tutorial, so do not worry about learning it now.
