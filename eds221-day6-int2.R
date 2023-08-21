#-----#Section 1: Filter#-------#
#I want to keep or exclude rows based on whether they satisfy or don't satisfy specific conditions
library(tidyverse)
library(palmerpenguins)
library(lterdatasampler)

#--Highlights:--#
#Exact match : ==
#And: & or ,
#Or: |
#In: %in%
#Not equal: !=


# To look for an exact match: ==. This returns a subset of the penguins data only where island = Biscoe
penguinsbiscoe <- penguins %>%
  filter(island == "Biscoe")

penguins_2007 <- penguins %>% filter(year == 2007)
unique(penguins_2007)

# To look for multiple matches: & or ,. Find obs. where species is Adelie AND  torgerson

adelie_torgerson <- penguins %>% filter(species == "Adelie" & island == "Torgersen")
#you can also write this as: penguins %>% filter(species == "Adelie", island == "Torgersen")

gentoos_2008 <- penguins %>% filter(species == "Gentoo", year == 2008)

#To create statements with OR sign: |. Example: create a subset of data with gentoos or adelies:
gentoos_adelies <- penguins %>% filter(species = "Gentoo" | species == "Adelie")

#Create a subset where the island is Dream or the year is 2009
dream_2009 <- penguins %>% filter(island == "Dream" | year == 2009)

#Create a ggplot chart with water temp on x and charapis size on y axis
ggplot(data = pie_crab, aes(x = water_temp, y = size)) + geom_point()

#Let's keep observations for sites NIB, ZI, DB, JC. We can use the in operator to ask: does the value in our column match any of the values IN this vector?

pie_sites <- pie_crab %>% filter(site %in% c("NIB", "ZI", "DB", "JC"))

sites <- c("CC", "BB", "PIE")
pie_sites2 <-pie_crab %>% filter(site %in% sites)

#Create a subset using the %in% operator that includes sites PIE, ZI, NIB, BB, and CC

sites2 <- c("PIE", "ZI", "NIB", "BB", "CC")
pie_crab |> filter(site %in% sites2)

#Excluding statements. How do we write to exclude things from datasets?
exclude_zi <- pie_crab %>% filter(site != "ZI")

#What if I want to exclude sites "BB", "CC", and "PIE"?
exclude_bb_cc_pie <- pie_crab %>% filter(!site %in% c("BB", "CC", "PIE"))
view(exclude_bb_cc_pie)

#Create a subset from pie_crab that only contains observations from NIB, CC, and ZI for crabs with carapace size exceeding 13
large_crabs <- pie_crab %>% filter(size > 13, site %in% c("NIB", "CC", "ZI"))


#------#Selecting Columns#-----------#
#I want to keep or exclude columns based on whether or not they satisfy my conditions

