library(shiny)
library(tychobratools)
library(highcharter)
library(DT)
library(shinythemes)
library(lubridate)
library(ggfortify)
library(tidyverse)
library(vistime)
getwd()
# load data
dat<-readRDS("data/match_stats.rds")
matches<-readRDS("data/matches.rds")
matches[["match_data"]] %>% 
  filter(Div=="E0")->prem
dat<- dat %>% select(!Club...19)
dat %>% 
  distinct(Manager,Club,`Finish date`,.keep_all = T) %>%
  filter(Div=="E0") -> prem_mgrs
dat %>% 
  distinct(Manager,Club,`Finish date`,.keep_all = T) -> mgrs
teams<-unique(prem_mgrs$Club) %>% sort() 
names(teams)<-teams
# managers<-unique(mgrs$Manager) %>% sort() %>% as.list()
managers<-unique(prem_mgrs$Manager) %>% sort()
names(managers)<-managers
first<-first(sort(unique(prem_mgrs$Start)))
last<-last(sort(unique(prem_mgrs$Finish)))
             
