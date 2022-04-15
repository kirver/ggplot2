# GGPLOT2 Workshop
Repo to accompany the R ggplot2 workshop from Jasper Ridge data management &amp; publishing series, organized by Dr. Bryan Juarez. This module is led by (future Dr.) Kirsten Isabel Verster.

The workshop assumes _some_ knowledge of R (e.g. setting working directories, loading libraries, etc;), but we can work on it together if not! 

Please see the accompanying powerpoint for more details!

We begin with a .csv file and create several manipulations in order to learn the basic functions of ggplot2 using a Pokemon-based dataset. 

---

## Let's start! 

```
#Set the working directory to wherever your file is located, 
and load in the following packages (which should already be pre-installed):

setwd(C:/Path/to/file)
library("tidyverse")
library("ggplot2")
library("gridExtra")
```

Now, we will load in the Pokemon dataset. This dataset was taken from [The Complete Pokemon Dataset](https://www.kaggle.com/datasets/rounakbanik/pokemon), which contains information on all 802 Pokemon from 7 Generations. _Neeeeerddd._ The datset is titled **Pokemon.csv** and can also be downloaded from the GitHub. 

For those who are young and/or had friends growing up, Pokemon is a Japanese media franchise based on "pocket monsters" that you can train, befriend, coexist with. There are a lot of them, and there is a *passionate* culture centered around them. 

![Pikachu](Pikachu.png)

```
p <- read.csv("pokemon.csv")
#This puts the .csv into a list titled 'p'
```

To make the dataset more manageable, we will use the ```subset()``` function to only extract one generation (the first one, which is the best, obviously!). The syntax is ```subset(list, Column == "Desired_String")```.

```p<-subset(p, Generation =="1")```

Note: let's say you wanted to use all generations _except_ generation 5. Then, what you would use instead would be ```subset(p, Generation != "5")```. 


ggplot2 was made following the Grammar of Graphics, a textbook by Leland Wilkinson. A grammar of graphics is a framework which follows a layered approach to describe & construct visualizations or graphics in a structured manner. Hadley Wickham et al wrote [a book](https://ggplot2-book.org/) describing their incorporation of the Grammar of Graphics into the ggplot2 package. 


Take a look at the `p` dataset by Ctrl+Enter on the given line. You should see columns such as **Name, Type.1, Total, HP, Attack**, etc;. Each row corresponds to a given Pokemon 'species'. 

If you want to look at specifics for a given column, you can add a `$` after the object. For example, typing in `p$Type.1` will show you all the Type 1 (all Pokemon have a 'type' that summarizes their physical properties) rows. If you want to see those which are unique, you could write in `unique(p$Type.1)`. 

Now, it is time to start making an actual ggplot! 

---

## Starting with Scatterplots

Let's start by loading in a ggplot item.

`ggplot(p)`

You might see, well, nothing!

![pp](https://github.com/kirver/ggplot2/blob/main/img/pp1.png)

The `ggplot()` function establishes that a plot needs to be made. It 'initializes' a ggplot option, and declares the input data frame. But, so far there are no aesthetics mapped on to it. The data is 'there' but is not seen. 

What you need to do is load in the _aesthetics_, which is called by `aes()`. And _then_ the layers, scales, coords and facets are added with `+`. Let's see this!

## All Aes() on Me

The way `aes()` works is by describing how data variables are mapped to the visual properties, or aesthetics, of the geoms (the geoms, remember, are the 0, 1 or 2 dimensional graphic representations of the data point!). It is used in the following way: `aes(x, y, ...)`. 

There are _lots_ of ways to call aes(). Several can be read about [here](https://bookdown.org/yih_huynh/Guide-to-R-Book/basic-aesthetics.html). We are going to run through a few of the most common iterations via using a scatterplot example. 

In our case, let's think of two items we want to map onto a scatter plot. Let's say, mmm, Attack and Defense. The we run the following:

`ggplot(p, aes(Attack, Defense))`

What do you see now?

![pp](https://github.com/kirver/ggplot2/blob/main/img/pp2.png)

Probably nothing that interesting... yet. But there's a key difference between this image and the other one. The first image shows an empty plot. But this one indicates an _axis_, which shows the X axis Attack, and the Y is Defense. The scales have been automatically set to be within the bounds of the data - these can be manipulated later on downstream. The specific data set to be mapped has been loaded in. However, we do not yet see any data points! This is because the _geom_ has not been indicated yet. 

How do we represent the data? Since we are interested in making a scatterplot, we will use `geom_point()` (more info on usage [here](https://ggplot2.tidyverse.org/reference/geom_point.html). Each dataset is represented by a _ point_. Keep in mind there are other types of geoms, as we described. There is `geom_boxplot()`, `geom_histogram()`, etc;. A point is merely one type of geom. And this is the one we are starting with!

So, we will _add_ the geom point aesthetic to these points by running the following code:

`ggplot(p) + aes(Attack, Defense) + geom_point()`

![pp](https://github.com/kirver/ggplot2/blob/main/img/pp3.png)

So far we have representations of two variables: Attack, and Defense. What if we wanted to add in a third variable? We can choose to represent a third variable by changing the _color_ of each point. We do this by manipulating the `aes()` function further and specifying the 'color' variable, as so:

`ggplot(p) + aes(Attack, Defense, color=HP) + geom_point()`

![pp](https://github.com/kirver/ggplot2/blob/main/img/pp4.png)

Keep in mind that this is assigning a quantitative variable color to each point, so you will see a quantitative color scale. However, you can also do the same with discrete variables, such as Type.1:

`ggplot(p) + aes(Attack, Defense, color=Type.1) + geom_point()`

![pp](https://github.com/kirver/ggplot2/blob/main/img/pp6.png)

So far we have three different variables represented: Attack, Defense, and Type.1. Dope! What if we want to go DEEPER and add another one? A fourth variable?

Another way we can manipulate the graph is by changing the _size_ of each point. Again, we will manipulate the aes() function and assign a variable to this size. Let's play around and change the size depending on the Pokemon's speed!

`ggplot(p) + aes(Attack, Defense, color=HP,
                size=Speed) + geom_point()`
                
![pp](https://github.com/kirver/ggplot2/blob/main/img/pp7.png)

Are you ready for one more variable?! A fifth one!?!? Let's change the shape of each data point. Keep in mind that shape is a discrete trait, so it can only function with discrete variables. 

`ggplot(p) + aes(Attack, Defense, color=HP,
                size=Speed,
                shape=Legendary) + geom_point()`

![pp](https://github.com/kirver/ggplot2/blob/main/img/pp8.png)

This is getting _hella_ noisy. Let's take a breath and focus on one thing we can do to change the 'broad' overall aesthetic of a graph: changing the theme! 

## Cambiando el Tema

[Themes](https://ggplot2.tidyverse.org/reference/ggtheme.html) area fun way of changing all the non-data display. Just, like, the vibe, tu sabes. 

One thing we will do to make looking at this a little easier is to put our whole ggplot so far into an object titled `p1`, as so:

``p1 <- ggplot(p) + aes(Attack, Defense, color=HP,
                size=Speed,
                shape=Legendary) + geom_point()`
                
Now, running `p1` should give you the previous graph. But it is also easier to make quick manipulations now that we have the 'core'. Let's run through a few of the themes to see how they can make sudden and aesthetically pleasing changes to the graph style. You can add a theme (overriding the defaults) by adding the theme function with a '+' at the end of the script, e.g.

`p1 + theme_bw()`

![pp](https://github.com/kirver/ggplot2/blob/main/img/pp9.png)

Notice a change? 

Now, try out a few of these themes and see what is prettiest for you:

`p1 + theme_light()`

`p1 + theme_dark()`

`p1 + theme_minimal()`

`p1 + theme_void()`

`p1 + theme_classic()`

## Fitting a Linear Regression

Disclaimer: I know very little about linear regressions. But other people, such as Dr. Juarez, and [the guy who wrote this](https://sejohnston.com/2012/08/09/a-quick-and-easy-function-to-plot-lm-results-in-r/), totally do! But I will run through a basic function:

Let's say I want to run a linear model for how Attack corresponds to Defense. Firstly, in order to do this, we need to work with the original .csv data frame. The `lm()` function that does this is (I believe) part of the base R package and doesn't deal with this ggplot nonsense. 

So, first let's reload in the Pokemon dataset, subsetting the first generation:

`p <- read.csv("pokemon.csv")`

`p <- subset(p, Generation == 1)`

Take a look at the graph. Do you expect a line to fit through these data?

`ggplot(p) + aes(Attack, Defense) +
  geom_point(color="darkgreen")`
  
![pp](https://github.com/kirver/ggplot2/blob/main/img/pp10.png)
  
  We then run the `lm()` function, which [fits linear models](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/lm) to the data points specified, e.g. `lm(X ~ Y, data = data)`. You can then view summary statistics for the model.
  
  So...
  
  `model <- lm(Attack ~ Defense, data = p)`
`summary(model)`

NOW! If you want to add that model, that _layer_, to the graph, you add on another geom. The linear model is part of the geom called [geom_smooth()](https://ggplot2.tidyverse.org/reference/geom_smooth.html). Its usage is like so:

`ggplot(p) + aes(Attack, Defense) +
  geom_point(color="darkgreen") + geom_smooth(methods='lm')`
  
  More information about the `geom_smooth()` function can be found [here](https://ggplot2.tidyverse.org/reference/geom_smooth.html). 
  
## Adding Text to Scatterplots

This may not be that useful, but I'll share it anyways. Personally, I'm really into Pokemon (ndur), and I love messing around with these graphs to see what they tell me about them. One thing that could be useful is by adding _text_ to these scatterplots. Turns out there is a function for this! They are `geom_text()` and `geom_label()`. 

[Text geoms](https://ggplot2.tidyverse.org/reference/geom_text.html) are useful for labeling plots. They can be used by themselves as scatterplots or in combination with other geoms, for example, for labeling points or for annotating the height of bars. geom_text() adds only text to the plot. geom_label() draws a rectangle behind the text, making it easier to read.

Let's look at a few examples of the usage, subsetting only Legendary pokemon to make the graphs more manageable to work with:

`p <- read.csv("pokemon.csv")`

`lgd1 <- subset(p, Legendary ==TRUE)`

`lgd2 <- ggplot(lgd1) + aes(Attack, Defense,
                           color=Type.1)`

Now, the ggplot object `lgd2` contains legendary Pokemon with Attack, Defense, and colored by Type.1. Now we will add `geom-text()`, with the modifier `label=lgd1$Name` which tells us that the actual _label_ we want to display is the _name_ of the Pokemon:

`lgd2 +  geom_text(label = lgd1$Name)`
                           
This graph is kind of unwieldy af because the text is all over the place. However, we can make a few modifications to make it more manageable: 1) we use the check_overlap function, which will keep text from overlapping. Then, we can change the size of the text:

`lgd2 +   geom_text(label = lgd1$Name,
                   check_overlap=TRUE,
                   size=2)`

 
 Now try the same with geom_label(). What is the major difference between these? 
 
 [[pp12]
 
 ### To Test Your Knowledge
 
1. Of all the Pokemon in generation 2, which is the fastest?
2. of all the legendary Pokemon in generations EXCLUDING the first, which has the highest HP? 
3. Is there a statistically significant association between HP and speed for all Pokemon in generation 4? 
4. What are a few types of geoms? What are the ways of using them to show information? 

## Histograms

Okay, enough time with the scatterplots and continuous variables! Boo! Now we are going to play around with a histogram geom. One guide for these geoms can be found [here](http://www.sthda.com/english/wiki/ggplot2-histogram-plot-quick-start-guide-r-software-and-data-visualization). 

A histogram is a _counter_. It counts how many of something can be found given a dataset. For example, let's say we want to see the distribution of _means_ for Hit Points in a pokemon. As before, we load in the dataset. The aesthetic set up is a little bit different: instead of assigning an X and Y, we only establish an X, since we are only looking at one variable and then counting it (hence, the Y will inherently by the count). Let's plug this in as a default:

`p <- read.csv("pokemon.csv")`
`ggplot(p, aes(x=HP)) + geom_histogram() `
       
      [pp13]
      
### To Test Your Knowledge

Run the following code:

`ggplot(p, aes(x=HP)) + geom_histogram(binwidth=2,
                                   fill="blue",
                                   color="green")`

1. What do you think changing the binwidth does?
2. What do you think changing fill does?
3. What does changing the color do? 
4. What is (approximately) the most common Pokemon speed? 
