# Week 4 Quiz

## Q1

*   Files to download:

    <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv>

*   Description:

    <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf>

*   Task:

    Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

*   Code:
    ```r
    dtx <- fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
    strsplit(names(dtx), "wgtp")
    ```

## Q2

*   Files to download:

    <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv>

*   Task:

    Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

*   Code:

    ```r
    download.files("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv","gdp.csv")gdp <- fread("gdp.csv", skip=4, nrows=215)
    ##clean gdp table
    gdp <- gdp[,.(V1,V2,V4, V5)]
    setnames(dt1, c("V1", "V2", "V4", "V5"), c("CountryCode", "rankingGDP", "Long Name", "gdp"))
    mean(as.numeric(gsub(",", "", gdp$gdp)), na.rm = T)
    ```

## Q4

*   Files to download:
    <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv>
    <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv>

*   Task:

    Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

*   Code:
    ```r
    nrow(merged[`Special Notes` %like% "^Fiscal year end: June.*"])
    ```

## Q5

*   Task:

    You can use the quantmod (<http://www.quantmod.com/>) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.

*   Code:

    ```r
    library(quantmod)
    getSymbols("AMZN")
    nrow(AMZN['2012'])
    x <- seq(as.Date("2012-01-01"), as.Date("2012-12-31"), by = "day")
    nrow(AMZN[x[weekdays(x)=="Monday"]])
    ```
