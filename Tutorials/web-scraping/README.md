# Web Scraping
The majority of unstructured, free data exists on the internet. This module provides students with the knowledge and tools required to pull data from static as well as dynamic websites. This requires basic knowledge of HTML, CSS, and regular expressions.

# Module Tasks
Please complete the following tasks:
* :notebook:Read the tutorial documentation below
* :school:Complete the ICE in class
* :computer:Complete the THA on your own

# XML Path Language
The XML path language, or xpath for short, is a means to navigate the tree structure of XML. If you are unfamiliar with XML, or maybe just heard of the term before, it is a markup language like HTML designed to store and transport data. XML stands for extensible markup language. As a markup language, it is easily understood and used by humans, yet at the same time a computer is able to decipher it.

The following provides an example of an xml file. This is based on the menu from [Taylor's Dining](https://business.okstate.edu/experience_learning/taylors.html). I only copied the first 4 weeks of menu items.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<fall2020_menu>
	<menu>
		<week>Aug 24</week>
		<cuisine>Oklahoma</cuisine>
		<maindish>fried catfish with tartar sauce, chicken fried steak with cream gravy</maindish>
		<soup>cream of potato</soup>
		<salad>black-eyed pea coleslaw, fresh greens oil and vinegar</salad>
		<side>mashed potatoes, gravy green beans, fried okra</side>
		<dessert>cherry cobbler, apple crisp</dessert>
	</menu>
	<menu>
		<week>Aug 31</week>
		<cuisine>China</cuisine>
		<maindish>Honey Plum Chicken, Beef with Pepper, Classic Steam Rice Roasted Broccoli, Cantonese Fried Noodles Braised Baby Bok Choy</maindish>
		<soup>Egg drop</soup>
		<salad>Rainbow Sesame Slaw, Asian Pasta, Mandarin Almond, Fresh Bitter Greens</salad>
		<side></side>
		<dessert>Toffee Sesame Bananas Bread Pudding</dessert>
	</menu>
	<menu>
		<week>Sept 7</week>
		<cuisine>India</cuisine>
		<maindish>Chicken Tikka Masala, Basmati Rice with Caraway, Pork Vindaloo, Potato & Chickpea Curry</maindish>
		<soup>curried celery</soup>
		<salad>Dal & Lentil, fresh greens, fresh cucumber & tomato</salad>
		<side></side>
		<dessert>five spice coconut cake</dessert>
	</menu>
	<menu>
		<week>Sept 14</week>
		<cuisine>Morocoo</cuisine>
		<maindish>Moroccan Stewed White Beans, Basmati Rice & Dried Fruit with Almonds, Roasted Vegetables of Morocco, Grilled Tagine Chicken and String Noodles</maindish>
		<soup>chicken and curry</soup>
		<salad>Tomato & Feta Salad with Olives Salad, Couscous and Lentils Salad</salad>
		<side></side>
		<dessert>lemon olive oil pound cake with yogurt sauce</dessert>
	</menu>
</fall2020_menu>
```

The structure is entirely up to the individual creating it. Notice that each entry in the xml repeats itself. Think of these as the rows in a database or Excel file. Each one has variables (e.g. week, cuisine, maindish, soup, salad, side, dessert) or "columns" of data. 

Here is another example from [w3schools.com](https://www.w3schools.com/xml/default.asp):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<breakfast_menu>
<food>
    <name>Belgian Waffles</name>
    <price>$5.95</price>
    <description>
   Two of our famous Belgian Waffles with plenty of real maple syrup
   </description>
    <calories>650</calories>
</food>
<food>
    <name>Strawberry Belgian Waffles</name>
    <price>$7.95</price>
    <description>
    Light Belgian waffles covered with strawberries and whipped cream
    </description>
    <calories>900</calories>
</food>
<food>
    <name>Berry-Berry Belgian Waffles</name>
    <price>$8.95</price>
    <description>
    Belgian waffles covered with assorted fresh berries and whipped cream
    </description>
    <calories>900</calories>
</food>
<food>
    <name>French Toast</name>
    <price>$4.50</price>
    <description>
    Thick slices made from our homemade sourdough bread
    </description>
    <calories>600</calories>
</food>
<food>
    <name>Homestyle Breakfast</name>
    <price>$6.95</price>
    <description>
    Two eggs, bacon or sausage, toast, and our ever-popular hash browns
    </description>
    <calories>950</calories>
</food>
</breakfast_menu>
```

XPath provides a means to navigate the tree structure of the XML document. For example, if I want the last food item `Homestyle Breakfast`, then I would use the notation `/breakfast_menu/food[5]`.

XPath is an alternative method to CSS selectors. Personally, I use XPath more often in my own work than I do CSS selectors. Yet, this does not mean I do not use CSS selectors. Depending on the situation, whichever is easier to implement for a given HTML, is the one I use.

Please review the following on XPath on w3schools.com:
* [XPath Nodes](https://www.w3schools.com/xml/xpath_nodes.asp)
* [XPath Syntax](https://www.w3schools.com/xml/xpath_syntax.asp)
* [XPath Axes](https://www.w3schools.com/xml/xpath_axes.asp)
* [XPath Operators](https://www.w3schools.com/xml/xpath_operators.asp)
* [XPath Examples](https://www.w3schools.com/xml/xpath_examples.asp)

The concepts apply fairly well to HTML. In fact, when using XPath with HTML, you will still rely on the type of HTML tag and the CSS style of the HTML. The difference really comes down to syntax between CSS selector and XPath.

Here is a table I have extended from a previous tutorial. Instead of only CSS selector notation, I have also included XPath notation. I have removed the column `Type` and replaced it with `XPath`. I did not repeat all rows for the sake of brevity.

| XPath | CSS | Example Description |
|:---|:---|:---|
| `//div[@class=’intro’]` | `div.intro` | Selects all `<div>` with `class="intro"` |
| `//div[@id='firstname']` | `div#firstname` | Selects the element with `id="firstname"` |
| `//*` | `*` | Selects all elements |
| `//p` | `p` | Selects all `<p>` elements |
| `//div/p` | `div>p` | Selects all `<p>` elements where the parent is a `<div>` element |
| `//a[@href='https']` | `a[href='https']` | Selects every `<a>` element whose href attribute value begins contains "https" |
| `//p/*[1]` | `p:first-child` | Selects every `<p>` elements that is the first child of its parent |
| `//p[n]` | `p:nth-child(n)` | Selects every `<p>` element that is the nth child of its parent |

Notice how similar the two styles of selectors are to each other. Honestly, the choice of which to use comes down to preference. Either works just as well as the other, ultimately. Like with CSS selectors, it's fairly straight forward in its usage. The most difficult part is identifying the HTML you need to reference to locate the HTML you need.

The following video demonstrates using XPath selectors. This covers the same websites covered in a previous video using OSU and Wikipedia with CSS selectors.
* [:tv: XPath vs CSS Selectors](https://youtu.be/GtAEEoEC_K4) 

# Tutorials for R and Python
If you are comfortable with regular expressions, CSS selectors, and XPath, you are ready to dive into specific examples within R and Python using code. Within each of these tutorials you will dive specifically into libraries and packages designed to scrape data from the web. While R and Python do have different libraries, a universal library that is considered one of the most powerful is Selenium.
* [Web Scraping in R](assets/tutorial%20web%20scraping%20in%20r.md)
* [Web Scraping in Python](assets/tutorial%20web%20scraping%20in%20python.md)

The accompanying example script files are found here:
1. [Example R file](assets/web%20scraping%20example.R)
2. [Example Python file](assets/web%20scraping%20example.py)
