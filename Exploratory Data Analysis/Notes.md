# Notes

## Principles of Analytic Graphs

1.  Show a comparison ("compared to what?");
2.  Show causality or a mechanism of how your theory of the data works;
3.  Show multivariate data (more than 2 variables);
4.  Integrate evidence (make use of many modes of data presentation)；
5.  Describe and document the evidence with sources and appropriate labels and scales;
6.  Content is king!

## Exploratory plotting purposes
1.  Suggest modeling strategies for the "next step"
2.  Summarize the data (usually graphically) and highlight any broad features
3.  Explore basic questions and hypotheses (and perhaps rule them out)

## Box plot recap

*   The "whiskers" of the box (the vertical lines extending above and below the box) relate to the range parameter of boxplot, which we let default to the value 1.5 used by R.
*   The height of the box is the interquartile range, the difference between the 75th and 25th quantiles. In this case that difference is 2.8.
*   The whiskers are drawn to be a length of range*2.8 or 1.5*2.8. This shows us roughly how many, if any, data points are outliers, that is, beyond this range of values.

## Base package plotting
```r
#histogram & rug
hist(data,col="green",breaks=10)
rug(data)
#abline
abline(h=12,lwd = 2, lty = 2)
#barplot
barplot(data, col="wheat", main="Name of graph") #or title(main = "Name of graph")
#scatter plot
plot(data$x, data$y, main = "Name")
#multiple plots
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1)) #set canvass

```

## Plotting to file devices
```r
pdf(file="myplot.pdf")
with(faithful, plot(eruptions, waiting)
title(main = "Old Faithful Geyser data")
dev.off() #important to close device
```


## Types of file devices
1.  Vector: good for line drawings and plots with solid colors using a modest number of points
    1.  pdf: resizes well, usually portable, but not efficient if a plot has many objects/points.
    2.  svg: XML-based, scalable, potentially useful for web-based plots
    3.  win.metafile + ps
2.  Bitmap: good for plots with a large number of points, natural scenes or web-based plots
    1.  png: line drawings, images with solid colors, lossless compression, good for plots with many points but does not resize
    2.  jpeg: lossy compression, good for plots with many points, not great for line drawings, don't resize well
    3.  tiff + bmp


## Plotting systems

*   base package
    -   start with a plot function
    -   then use annotation functions to add to or modify plot, such as text, lines, points, and axis
    -   can't go back once a plot has started
*   Lattice
    -   plots are created with a single function call, such as `xyplot` or `bwplot`
    -   margins and spacing are set automatically
    -   ideal for creating conditioning plots where you examine the same kind of plot under many different conditions
    -   also good for putting many plots on a screen at once
    -   sometimes awkward, annotating a plot may not be especially intuitive
    -   cannot "add" to the plot once it is created
*   ggplot2
    -   automatically deals with spacing, text, titles
    -   also allows annotation by "adding" to a plot (as Base does)


## Base package
```r
#plot, hist, boxplot, barplot
boxplot(Ozone~Month, airquality, xlab="Month", ylab="Ozone (ppb)",col.axis="blue",col.lab="red")
title(main="Ozone and Wind in New York City")
#par() function is used to specify global graphics parameters,
#dev.off or plot.new reset to the defaults,
#these include las (the orientation of the axis labels on the plot),
#bg (background color), mar (margin size), oma (outer margin size), mfrow and mfcol (number of plots per row, column)
#Margins are specified as 4-long vectors of integers. Each number tells how many lines of text to leave at each side.
#The numbers are assigned clockwise starting at the bottom. The default for the inner margin is c(5.1, 4.1, 4.1, 2.1) so you can see we reduced each of these so we'll have room for some outer text.
par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
#text, abline, points, mtext, legend(explanation of data)
legend("topright", pch=c(17,8), col=c("blue","red"),legend=c("May","Other Months"))
```

## Lattice

*   No separate plotting and annotation, all done at once;
*   Graphics functions return an object of class trellis;
    -   names(`object`) -> 45 properties, `panel` corresponds to categories;
    -   `panel` function can be customized to modify plot panels:
    ```r
    p2 <- xyplot(y ~ x | f, panel = function(x, y, ...) {
        panel.xyplot(x, y, ...)  ## First call default panel function
        panel.lmline(x, y, col = 2)  ## Overlay a simple linear regression line
    })
    ```
*   Scatterplots: `xyplot`, box-and-whiskers plots: `bwplot`, histogram: `hisotgram`;
*   `xyplot(y ~ x | f * g, data)`, where `y` depend on `x`, `f * g` optional conditioning vars
    -   `xyplot(Ozone~Wind | as.factor(Month), data=airquality, layout=c(5,1))`, table

*   `table(diamonds$color,diamonds$cut)`

## Colors

*   `colorRamp`
    ```r
    pal<-colorRamp(c("red", "blue"))
    pal(0)
    pal(0.5)
    pal(1)
    pal(seq(0,1,len=6))
    ```
*   `colorRampPalette`
    ```r
    pal2 <- colorRampPalette(c("red", "blue"))
    pal2(6) #-> [1] "#FF0000" "#CC0033" "#990066" "#650099" "#3200CC" "#0000FF"
    pal3 <- colorRampPalette(c("red", "blue"),alpha=.5) #alpha = opacity level
    pal3(4) # -> [1] "#FF0000FF" "#CC0033FF" "#990066FF" "#650099FF" "#3200CCFF" "#0000FFFF"
    ```
*   RColorBrewer package, sequential, divergent, and qualitative palettes
*   `image()`

## GGPlot2

*   overview: allows for multipanel (conditioning) plots (as lattice does) but also post facto annotation (as base does);
    -   (as in base and in contrast to lattice) plots are built up in layers, maybe in several steps
    -   plot the data first, then overlay a summary (e.g. a regression line or smoother)
    -   then add any metadata and annotations
*   qplot

    ```r
    #scatter plot with legend and trend line, geom takes a string
    qplot(displ, hwy, data=mpg, color=drv, geom=c("point", "smooth"))  
    #boxplot
    qplot(drv,hwy,data=mpg,geom="boxplot", color=manufacturer)
    #3 histograms, . ~ drv -> 1 row 3 cols, since drv has 3 elements
    qplot(displ, hwy, data=mpg, facets=. ~ drv)
    #3 histograms, 3 rows 1 col
    qplot(hwy, data=mpg, facets= drv ~ ., binwidth=2)
    #density function
    qplot(price, data=diamonds, geom="density", color=cut)
    #adding layers
    qplot(carat,price,data=diamonds, shape=cut, color=cut, facets=.~cut) + geom_smooth(method="lm")
    ```
*   ggplot
    -   data frame: contains plot data
    -   aesthet mappings: determine how data are mapped to attributes such as size, shape, color
    -   geoms (geometric objects): what is in the plot, i.e. points, lines, shapes
    -   facets: panels used in conditional plots
    -   coordinate system

    ```r
    g <- ggplot(mpg, aes(displ, hwy)) #mapping: x = displ, y = hwy, run summary to see more
    #add a layer on to plot, with g storing all the plot data and attributes
    g + geom_point()
    #all arguments are constants
    g + geom_point(color="pink", size=4,alpha=.5) #+ geom_smooth(method="lm") + facet_grid(. ~ drv)
    #when argument such as color is a function, must use aes
    g + geom_point(size=4,alpha=1/2,aes(color=drv))
    # a more complex plot, linetype=3 dotted line, se = standard error
    g + geom_point(aes(color = drv),size=2,alpha=1/2) + geom_smooth(size=4,linetype=3,method="lm",se=FALSE) + theme_bw(base_family = "Times")
    # handling outliers
    plot(myx, myy, type="l", ylim=c(-3,3)) #base
    ggplot(testdat, aes(myx, myy)) + geom_line() + coord_cartesian(ylim=c(-3,3))
    #changing legend title
    labs(color="New Title") #or labs(fill="New Title")

    #another example
    g <- ggplot(diamonds, aes(depth, price))
    summary(g) #inspect plot data
    #see if relationship between depth and price is affected by other factors (such as cut or carat)

    #cutting non discrete var carat into three bins
    cutpoints <- quantile(diamonds$carat, seq(0,1,length=4), na.rm=TRUE)
    diamonds$car2 <- cut(diamonds$carat, cutpoints)
    #show relationship with additional variables in a panel
    g + geom_point(alpha=1/3) + facet_grid(cut~car2)

    #a box plot
    ggplot(diamonds, aes(carat, price)) + geom_boxplot() + facet_grid(. ~ cut)
    ```
