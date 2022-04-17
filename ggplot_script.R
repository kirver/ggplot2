library("tidyverse")
library("ggplot2")
library("gridExtra")
library("RColorBrewer")
library("viridis")

setwd("C:/Users/kvers/Box Sync/darwindox (kiv@berkeley.edu)/GOTTA CATCH EM ALL GGPLOT2/")

p <- read.csv("pokemon.csv")
#This puts the .csv into a list titled 'p'
p<-subset(p, Generation =="1")
#Selects only Gen 1 pokemon


ggplot(p)
ggplot(p, aes(Attack, Defense))
ggplot(p) + aes(Attack, Defense) + geom_point()
ggplot(p) + aes(Attack, Defense) +
  geom_point(shape=23)

ggplot(p) + aes(Attack, Defense) +
  geom_point(shape=23,
             fill="forestgreen",
             size=3,
             color="yellow",
             alpha=0.5)


ggplot(p) + aes(Attack, Defense, color=HP) + geom_point()
ggplot(p) + aes(Attack, Defense, color=Type.1) + geom_point()
ggplot(p) + aes(Attack, Defense, color=HP, size=Speed) + geom_point()
ggplot(p) + aes(Attack, Defense, color=HP, size=Speed, shape=Legendary) + geom_point()


p1 <- ggplot(p) + aes(Attack, Defense, color=HP,
                      size=Speed,
                      shape=Legendary) + geom_point()
p1

p1 + theme_bw()
p1 + theme_light()
p1 + theme_dark()
p1 + theme_minimal()
p1 + theme_void()
p1 + theme_classic()


p <- read.csv("pokemon.csv")
p <- subset(p, Generation == 1)
ggplot(p) + aes(Attack, Defense) + geom_point(color="darkgreen")
model <- lm(Attack ~ Defense, data = p)
summary(model)
ggplot(p) + aes(Attack, Defense) + geom_point(color="darkgreen") + geom_smooth(methods='lm')



p <- read.csv("pokemon.csv")
lgd1 <- subset(p, Legendary ==TRUE)
lgd2 <- ggplot(lgd1) + aes(Attack, Defense, color=Type.1)
lgd2 + geom_text(label = lgd1$Name)
lgd2 + geom_text(label = lgd1$Name, check_overlap=TRUE, size=2)




p <- read.csv("pokemon.csv")
ggplot(p, aes(x=HP)) + geom_histogram()



ggplot(p, aes(x=Legendary, y=HP)) + geom_boxplot()
ggplot(p, aes(x=as.factor(Generation), y=Speed)) + geom_boxplot()
ggplot(p, aes(x=as.factor(Generation), y=Defense, color=as.factor(Generation), fill="orange")) + geom_boxplot()



ggplot(p, aes(x=Legendary, y=as.factor(Generation))) + geom_count()


ggplot(p, aes(x=Legendary, y=as.factor(Generation))) + geom_count() + theme_bw() + 
  ggtitle("Counts of Legendaries per Generation") + 
  xlab("Legendary?") +
  ylab("Generation")


Legend <- c("Non-Legendary", "Legendary")
ggplot(p, aes(x=Legendary, y=as.factor(Generation))) + geom_count() + theme_bw() + 
  ggtitle("Counts of Legendaries per Generation") + 
  xlab("Legendary?") +
  ylab("Generation") + scale_y_discrete(limits=rev) +
  scale_x_discrete(labels=Legend)


p3 <- ggplot(p) + aes(Attack, Defense,
                      color=Type.1,
                      shape=Type.2) +  theme_bw() +
  geom_point() 
p3




p3 <- ggplot(p) + aes(Attack, Defense,
                      color=Type.1,
                      shape=Type.2) +  theme_bw() +
  geom_point() +
  scale_x_continuous(limits=c(0,500)) + 
  scale_y_continuous(limits=c(0,300))
p3




display.brewer.all()
display.brewer.all(colorblindFriendly = T)
ggplot(p) + aes(Attack, Defense,
                color=Type.1) + geom_point() +
  scale_color_brewer(palette="Set2")





vir_color <- scale_colour_viridis(
  alpha=1, 
  begin=0, 
  end=1, 
  direction=1,
  discrete=TRUE, 
  option="E")
ggplot(p) + aes(Attack, Defense, color=Type.1) + geom_point() + vir_color




ggplot(p) + aes(Attack, Defense,
                color=as.factor(Generation)) + geom_point() +
  scale_color_brewer(palette="Set2")


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





p <- read.csv("pokemon_colors.csv")
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



p <- read.csv("pokemon_colors.csv")
uq <- sort(unique(p$Color))
uq
count <- table(p$Color)
count #makes a table with the counts for each with table() function
#details here: https://www.datasciencemadesimple.com/table-function-in-r/
count.df <- data.frame(uq, count)
count.df #arranges them into a data frame

his <-ggplot(count.df,
             aes(x=uq, y=Freq)) + 
  geom_bar(stat="identity",
           width=0.5,
           fill=uq,
           color="black") + colors_type

his


p <- read.csv("pokemon.csv")
Legend <- c("Non-Legendary", "Legendary")
p1 <- ggplot(p, aes(x=Legendary, y=as.factor(Generation))) + geom_count() + theme_bw() + 
  xlab("Legendary?") +
  ylab("Generation") + scale_y_discrete(limits=rev) +
  scale_x_discrete(labels=Legend)
p1

p2 <- ggplot(p,
             aes(x=Speed,
                 color=Legendary)) + geom_histogram(binwidth=5,
                                                    fill="black")
p2

p3 <- ggplot(p) + aes(Attack, Defense,
                      color=Type.1,
                      shape=Type.2,
                      size=HP) +  theme_bw() +
  geom_point(show.legend=FALSE) 

p3

p <- read.csv("pokemon.csv")
ggplot(p) + aes(Attack, Defense) +
  geom_point(color="darkgreen")
model <- lm(Attack ~ Defense, data = p)
summary(model)
p4 <- ggplot(p) + aes(Attack, Defense) +
  geom_point(color="darkgreen") + geom_smooth(methods='lm')
p4

p5 <- ggplot(p,
             aes(x=as.factor(Generation),
                 y=Defense,
                 color=as.factor(Generation),
                 fill=Legendary)) + geom_boxplot(show.legend=FALSE)
p5


grid.arrange(p1, p2, p3, p4, p5, nrow=2, ncol=3)
