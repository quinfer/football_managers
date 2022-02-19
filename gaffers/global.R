library(shiny)
library(tychobratools)
library(highcharter)
library(DT)
library(shinythemes)
library(lubridate)
library(ggfortify)
library(tidyverse)
library(vistime)

# load data
mgrs<-readRDS("data/managers.rds")
# teams<-unique(mgrs$TEAM) %>% sort() %>% as.list()
teams<-unique(mgrs$TEAM) %>% sort() 
names(teams)<-teams
# managers<-unique(mgrs$Manager) %>% sort() %>% as.list()
managers<-unique(mgrs$Manager) %>% sort()
names(managers)<-managers
first<-first(sort(unique(mgrs$from)))
last<-last(sort(unique(mgrs$from)))
mgrs %>% mutate(
  from=ymd(from),
  to=ymd(to),
  to=if_else(TO=="Present",ymd("2020-07-01"),to))->mgrs           
             
