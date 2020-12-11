# Named-Entity-Recognition
You are familiar with retreiving nouns, adjectives, and verbs with POST from unstructured data. What about actual people or places? Named-entity recognition (NER), or entity extraction, locates and classifies named entities in unstructured text. In this module you will learn how to create your own entities and extract them from text.

# What's In a Name?
NER is similar in idea to part of speech tagging (POST) except the goal is to identify specific entities, as opposed to all grammatical elements. Specifically, those elements that are nouns. More importanlty, proper nouns are of great interest. Proper nouns are the names of things, such as Jerome, Sally O'Brien, or Shubham Gupta. These names can be gegraphical locations (eg Grand Canyon, Yellowstone National Park), cities (eg Stillwater, Oklahoma; Provo, Utah), countries, or even oceans.

The idea behind an `entity` is that it is rigid, contiguous in space and/or time. The referent object must be designated by the name without confusion as to what is referred. For example, American Airlines refers to the American airline company headquartered in Fort-Worth, Texas. While the phyiscal location of this object could be debated, conceptually the referent object is the company, its employees, and various assets. 

In addition to proper nouns, scientific labels for species or substances are considered named-entities. The element carbon, while not a proper noun, typically refers to the element on the periodic chart of the elements. The same can be said for animals, like wolves, deer, elk, or lobsters.

Other entities may be defined based on a specific context. For example, terms for dates and times may refer to rigid objects in one context, but not in another. If I was looking for airline tweets related to employee strikes during the month of June and July, I may instantiate June and July as specific entities I am searching for.

NER is not exact or always precise. Three methods are used to determine the accuracy and viability of a NER process.
* Precision: simply the number of entities determined over the number of desired entities, then averaged across all. For example, if `[Bryan][Hammer]` was found but `[Bryan Hammer]` was desired, the match would receive a score of 0
* Recall: the number of names in the desired set that appear at exactly the same location in the determined set.
* F1: harmonic mean of precision and recall

These entities are useful. One example is for transferring text-based messages from customers to the correct customer service representative. Many organizations have various departments that handle different issues. A bank may have one department for financial problems, another for technical issues with apps and mobile banking, mortgages, retirement accounts, and many others. A single tweet to a company will have specific text, with some entities that identify its content. By mining the entities and other text, a computer system and automatically send the tweet to the correct department for processing.

The process follows the basic steps of extracting named-entities. This includes two main phases in which 1) the named-entities are detected and 2) the constituent parts are classified into various types of objects. 

The process of detection includes
1. tokenizing of the text
2. and converting it into POST elements. 

The process of classification involves
1. segmenting the text into entity types
2. and filtering out types of entities.

The segmenting step is often referred to as chunking because it shares similarities with chunking. Chunking, or shallow parsing, is the analysis of text that identifies constituent parts (ie nouns, verbs, adjectives, etc) and links them to higher order meanings (eg named entities). The higher order meanings are based on natural language processing techniques, typically relying on contextual meaning.

# Module Tasks
Please complete the following tasks:
* :notebook:Read the tutorial documentation
* :school:Complete the ICE in class
* :computer:Complete the THA on your own

## Tutorials
The following tutorials are available to read:
* [NER in Python](assets/tutorial%20ner%20in%20python.md)
* [NER in R](assets/tutorial%20ner%20in%20r.md)

The accompanying example script files are found here:
1. [Example Python file](assets/ner%20example.py)
2. [Example R file](assets/ner%20example.R)
