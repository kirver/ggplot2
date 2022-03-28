library("tidyverse")
library("ggplot2")
library("gridExtra")


setwd("C:/Users/kvers/Box Sync/darwindox (kiv@berkeley.edu)/GOTTA CATCH EM ALL GGPLOT2/")

p <- read.csv("pokemon.csv")

p <- subset(p, Generation =="1")
p
"""What is Pokemon? 

GGPLOT2 starts with ggplot().
You then supply a datset and aesthetic mapping with
aes().
You can then add on different layers (like
geom_point(), geom_histogram(),
scales such as 
scale_colour_brewer(), and
coordinates systems. 

It was made following the Grammar of Graphics,
a textbook by Leland Wilkinson. 
A grammar of graphics is a framework which follows a layered approach
to describe & construct visualizations or graphics in a structured manner. 


https://towardsdatascience.com/a-comprehensive-guide-to-the-grammar-of-graphics-for-effective-visualization-of-multi-dimensional-1f92b4ed4149

Hadley Wickham, the creator of ggplot2, 
also wrote a paper about this:
https://towardsdatascience.com/a-comprehensive-guide-to-the-grammar-of-graphics-for-effective-visualization-of-multi-dimensional-1f92b4ed4149 


#The plot itself is the data.

#Examples of aesthetics are: x position, y position,
#and shape of points. 

#Geometric objects: bars, lines and points. 

#To create a complete plot we need to combine
#graphical objects from three sources:
#1. the data, represented by point geom;
#2 - scales and coordinate system, generates axes and legends so we can read values from the graph;
#3 plot annotations, such as background and plot title


#Together, the data, mappings, statistical transformations,
#and geometric object form a layer.

"""


p$Type.1
ggplot(p)

#ggplot(dataset, aes(x,y))

ggplot(p, 
       aes(Attack, Defense))



#ggplot establishes a plot needs to be made.
#it "initializes" a ggplot option.
#it can also be used to declare the input data frame
#for a graphic and specify the set of plot aesthetics. 


#aes() means aesthetic mapping.
#It describes how variables in the data are mapped
#to visual properties of geoms. 
#It is  a quoting function. 


ggplot(p) + aes(Attack, Defense) 

#GGPLOT2 uses + to create a plot by adding
#pieces of the definition together
#ggplot function creates a base object, to which
#everything else is added.


#The usage is aes(x, y, ....)


#As you can see, aes() establishes the variables,
#but does not tell you any data... yet. For this you need 
#geom_point().


#We will start with two continuous variables.


ggplot(p) + aes(Attack, Defense) +
  geom_point()

#geom_point brings in individual data points.
#But what if we want to manipulate the geom_point
#based on some other aspect (third dimension) 
# of each data point?


ggplot(p) + aes(Attack, Defense,
                color=Type.1) +
  geom_point()

"""
#You can also add themes. The default one is theme_grey(),
#signature ggplot2 theme with light grey background and white gridlines.

#Other options include:
#theme_linedraw(), theme_light(), theme_dark(), theme_minimal(),
theme_classic(), theme_void()
"""

ggplot(p) + aes(Attack, Defense, color=Type.1) +
  geom_point() + theme_bw()

ggplot(p) + aes(Attack, Defense, color=Type.1) +
  geom_point() + theme_light()

ggplot(p) + aes(Attack, Defense, color=Type.1) +
  geom_point() + theme_dark()

ggplot(p) + aes(Attack, Defense, color=Type.1) +
  geom_point() + theme_minimal()

ggplot(p) + aes(Attack, Defense, color=Type.1) +
  geom_point() + theme_void()

ggplot(p) + aes(Attack, Defense, color=Type.1) +
  geom_point() + theme_classic()


"""
#Note that these color schemes will often be totally inaccessible to colorblind peoples.
#So it is important to utilize colorblind friendly palettes.
There is a lot on the internet about this. 




To add colors, you can do two things - scale_fill_gradient()
and scale_colour_gradient(). 

In ggplot2, color and fill are mapped separately. Color
refers to point and line color, while fill referes to bar fill,
density fill, etc;. 

"""



ggplot(p) + aes(Attack, Defense,
                color=Type.1) +  theme_bw() +
  geom_point()  


"""Let's say we want to add a different variable, map LOTS of more variables here.
#We can add another dimension by, let's say, changing the SHAPE of each individual point.



"""

ggplot(p) + aes(Attack, Defense,
                color=Type.1,
                shape=Type.2) +  theme_bw() +
  geom_point()  +
  scale_shape_manual(values = c(0:19))


"Let's say we want to go crazy and add another dimension.
maybe what we can do is then add a BUBBLEPLOT, which is,
change the size of the object based on some value.
Let's say, hmmm, HP.

"

ggplot(p) + aes(Attack, Defense,
                color=Type.1,
                shape=Type.2,
                size=HP) +  theme_bw() +
  geom_point()  +
  scale_shape_manual(values = c(0:19))

"Truly insanity but not particularly useful. 
First of all, let's start by subsetting this data and maybe only focusing on one 
dataset. For example, maybe let us work with a subset of the data that only deals with,
let's say, choose ur favorite type of pokemon."

p <- read.csv("pokemon.csv")

fighting <- subset(p, Type.1 =="Fighting")
fairies <- subset(p, Type.1 =="Fairy")


p1 <- ggplot(fighting) + aes(Attack, Defense,
                color=Type.1,
                shape=Type.2,
                size=HP) +  theme_bw() +
  geom_point()  +
  scale_shape_manual(values = c(0:19))
p1

p2 <- ggplot(fairies) + aes(Attack, Defense,
                             color=Type.1,
                             shape=Type.2,
                             size=HP) +  theme_bw() +
  geom_point()  +
  scale_shape_manual(values = c(0:19))


p2


grid.arrange(p1, p2, nrow=1)


"Damn, truly crazy! And not super informative.
But still cool. Let's see if we can plot a regression line through
these images.

What if we want to fit a linear regression to one of these plots?
Create a multiple linear model"



#Save predictions of the model in a new data frame tgether with variable
#We want to plot against. 

p <- read.csv("pokemon.csv")
p
lgd1 <- subset(p, Legendary ==TRUE)
lgd2 <- subset(lgd1, Generation == 1)
lgd2


ggplot(lgd2) + aes(Attack, Defense) +
  geom_point(color="darkgreen")

model <- lm(Attack ~ Defense, data =lgd2)
summary(model)

ggplot(lgd2 + aes(Attack, Defense)) +
  geom_point(color="darkgreen") +
  geom_smooth(methods='lm')

#To remove standard error lines, run se=FALSE



p <- read.csv("pokemon.csv")
p
lgd1 <- subset(p, Legendary ==TRUE)
lgd1

lgd2 <- ggplot(lgd1) + aes(Attack, Defense,
                           color=Type.1) 

lgd2 +   geom_text(label = lgd1$Name)

lgd2 +   geom_text(label = lgd1$Name,
                   check_overlap=TRUE,
                   size=2)

lgd2 +   geom_label(label = lgd1$Name)



######Okay so let's stop with the continuous vs. continuous variable stuff.

#Questions:
#Of all the Pokemon in generation 2, which is the fastest?
#Of all the legendary Pokemon in generations EXCLUDING 1, which has the highest HP?



####Let's now fuck a little with histograms or something. 

p <- read.csv("pokemon.csv")
p
lgd1 <- subset(p, Legendary ==TRUE)
p <- lgd1

ggplot(p,
       aes(x=HP)) + geom_histogram(binwidth=5,
                                   fill="blue",
                                   color="black")

his <-ggplot(p,
       aes(x=HP, color=Type.1,
           fill=Type.1)) + geom_histogram(binwidth=5)

his <-ggplot(p,
             aes(x=HP, color=as.factor(Generation),
                 fill=Type.1)) + geom_histogram(binwidth=5)
his



#More discrete x, continuous y.

ggplot(p,
       aes(x=as.factor(Generation),
           y=Speed)) + geom_boxplot()


#Discrete and discrete.

ggplot(p, aes(x=Type.1, y=as.factor(Generation))) + geom_count()





###Scales map data values to the visual values of an aesthetic.
#To change the mapping, add a new scale. 
#https://stackoverflow.com/questions/65013406/how-to-generate-30-distinct-colors-that-are-color-blind-friendly

library(RColorBrewer)
n <- 15
colrs <- brewer.pal.info[brewer.pal.info$colorblind == TRUE, ]
col_vec = unlist(mapply(brewer.pal, colrs$maxcolors, rownames(colrs)))
col <- sample(col_vec, n)
area <- rep(1,n)
pie(area, col = col)


#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
library(viridis)
vir_color <- scale_colour_viridis(
  alpha=1, begin=0, end=1, direction=1,
  discrete=TRUE, option="E")

vir_color

ggplot(p) + aes(Attack, Defense,
                color=Type.1) +
  geom_point() + vir_color


#Can Also Do this Manually. 
colors_type <- scale_colour_manual(values=c(
  "Dark" = "#000000",
  "Dragon" = "#E5F5F9",
  "Electric" = "#1D91C0",
  "Fairy" = "#67001F",
  "Fire" = "#F7FCFD",
  "Flying" = "#CB181D",
  "Ghost" = "#78C679",
  "Grass" = "#F46D43",
  "Ground" = "#A6CEE3",
  "Ice" = "#FD8D3C",
  "Normal" = "#D4B9DA",
  "Psychic" = "#6A51A3",
  "Rock" = "#7F0000",
  "Steel" = "#D9D9D9",
  "Water" = "blue"),
  name="Type.1")



ggplot(p) + aes(Attack, Defense,
                color=Type.1) +
  geom_point() + colors_type + theme_linedraw()



#scale_*_continuous = map cont values to visual ones
#https://ggplot2-book.org/scale-colour.html
ggplot(p) + aes(Attack, Defense,
                color=Speed) + geom_point() +
  scale_colour_continuous()




ggplot(p) + aes(Attack, Defense,
                color=Speed) + geom_point() +
  scale_colour_continuous(type="viridis")



ggplot(p) + aes(Attack, Defense,
                color=Speed) + geom_point() +
  scale_colour_viridis(option="magma")


ggplot(p) + aes(Attack, Defense,
                color=Speed) + geom_point() +
  scale_colour_gradient(
    low="blue",
    high="orange"#Gators Chomp Chomp
  )

ggplot(p) + aes(Attack, Defense,
                color=Speed,
                size=HP) + geom_point() +
  scale_colour_gradient(
    low="blue",
    high="orange"#Gators Chomp Chomp
  )


####Now let's do Pokemon colors! Wheee! 

p <- read.csv("pokemon2.csv")
p

p$Color
unique(p$Color)


colors_type <- scale_colour_manual(values=c(
  "Green" = "green",
  "Orange" = "orange",
  "Blue" = "blue",
  "Purple" = "purple",
  "Yellow" = "yellow",
  "Brown" = "brown",
  "Pink" = "pink",
  "Red" = "red",
  "White" = "white",
  "Gray" = "gray"),
  name="Color")
colors_type

#https://stackoverflow.com/questions/38788357/change-bar-plot-colour-in-geom-bar-with-ggplot2-in-r

uq <- sort(unique(p$Color))
uq
count <- table(p$Color)
count
count.df <- data.frame(uq, count)
count.df


col <- scale_colour_manual(values=c(
  "Green" = "green",
  "Orange" = "orange",
  "Blue" = "blue",
  "Purple" = "purple",
  "Yellow" = "yellow",
  "Brown" = "brown",
  "Pink" = "pink",
  "Red" = "red",
  "White" = "white",
  "Gray" = "gray"),
  name="Color")

his <-ggplot(count.df,
             aes(x=uq, y=Freq)) +  geom_bar(stat="identity",
                                        width=0.5,
                                        fill=uq,
                                        color="black") + col


  
his

#Make sure to run through a CB filter
#https://www.color-blindness.com/coblis-color-blindness-simulator/



ggplot(p) + aes(Attack, Defense,
                color=Type.1) +
  geom_point() + colors_type + theme_linedraw()

his  

unique(p$Color == "Yellow")



"""
#The layer component is particularly important
#as it determines the physical representation of the data,
#with combo of stat & geom defining many familiar named graphics:
#scatterplot, histogram, contourplot, etc; .



#Let's use the following page to see the different types of variables
#we can work with:

#https://www.maths.usyd.edu.au/u/UG/SM/STAT3022/r/current/Misc/data-visualization-2.1.pdf

#Adding different dimensions?"""
