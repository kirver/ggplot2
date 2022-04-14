# GGPLOT2 Workshop
Repo to accompany the R ggplot2 workshop from Jasper Ridge data management &amp; publishing series, organized by Dr. Bryan Juarez. This module is led by (future Dr.) Kirsten Verster.


---

We will be walking through the R code here!

```
#Set the working directory to wherever your file is located, 
and load in the following packages (which should already be pre-installed):

setwd(C:/Path/to/file)
library("tidyverse")
library("ggplot2")
library("gridExtra")
```

Now, we will load in the Pokemon dataset. 

(Pikachu.png)

```
p <- read.csv("pokemon.csv")
#This puts the .csv into a list titled 'p'
```

To make the dataset more manageable, we will use the ```subset()``` function to only extract one generation (the first one, which is the best, obviously!). The syntax is ```subset(list, Column == "Desired_String")```.

```p<-subset(p, Generation =="1")```

Note: let's say you wanted to use all generations _except_ generation 5. Then, what you would use instead would be ```subset(p, Generation != "5")```. 
