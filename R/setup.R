library(knitr)
library(rmdformats)
library(data.table)
library(stringr)
library(DT)
library(kableExtra)
## Global options
options(max.print="85")
opts_chunk$set(eval=TRUE,
               echo=FALSE,
               cache=TRUE,
               prompt=FALSE,
               tidy=TRUE,
               comment=NA,
               message=FALSE,
               warning=FALSE)
opts_knit$set(width=85)

.getN <- function(DT){
  N <- DT |> unique() |> nrow |> prettyNum(big.mark=" ")
  return(N)
}