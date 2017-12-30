# Week 3 Quiz

## Q1

*   Files to download:
    <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv>

*   Description:
    <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf>

*   Task:

    Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.

    which(agricultureLogical)

    What are the first 3 values that result?


*   Code

    ```r
    download.files("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "somedata.csv")
    dt <- fread("somedata.csv")
    agricultureLogical <- dt[ACR ==3 & AGS ==6]
    which(agricultureLogical)[1:3]
    ```

## Q2
*   Files to download
    <https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg>

*   Task:

    Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data?  

*   Code:
    ```r
    library(jpeg)
    download.files("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "somedata.jpg")
    img <- readJPEG("somedata.jpg", native = TRUE)
    quantile(img, probs = c(0.3, 0.8))
    ```

## Q3

*   Files to download:
    <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv>
    <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv>

*   Task:

    Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank. What is the 13th country in the resulting data frame?

*   Code:

    ```r
    download.files("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv","gdp.csv")
    download.files("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "edu.csv")
    gdp <- fread("gdp.csv", skip=4, nrows=215)
    edu <- fread("edu.csv")
    ##clean gdp table
    gdp <- gdp[,.(V1,V2,V4, V5)]
    setnames(dt1, c("V1", "V2", "V4", "V5"), c("CountryCode", "rankingGDP", "Long Name", "gdp"))
    mergedt <- merge(gdp, edu, by="CountryCode")
    sum(!is.na(unique(mergedt$rankingGDP)))
    ```

## Q4

*   Task:

    What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

*   Code:

    ```r
    mergedt[, mean(rankingGDP, na.rm=T), by="Income Group"]
    ```

## Q5

*   Task:

    Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

*   Code:

    ```r
    breaks <- quantile(mergedt$rankingGDP, probs= seq(0,1,0.2), na.rm=T)
    mergedt$quantileGDPRanks <- cut(merged$rankingGDP, breaks=breaks)
    mergedt[`Income Group`== "Lower middle income", .N, by=c("Income Group", quantileGDPRanks)]
    ```
