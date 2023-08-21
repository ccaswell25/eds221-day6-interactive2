#-----#Section 1: Filter#-------#
#I want to keep or exclude rows based on whether they satisfy or don't satisfy specific conditions
library(tidyverse)
library(palmerpenguins)
library(lterdatasampler)

#--Highlights:--#
#Rows#
#Exact match : ==
#And: & or ,
#Or: |
#In: %in%
#Not equal: !=

#Columns#
#Specific columns: select()
#Write if/else statements: case_when()


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


#------#Selecting Columns#------#
#I want to keep or exclude columns based on whether or not they satisfy my conditions
#dplyr::select()

#Select individual columns by name, separate them by a comma
crabs_subset <- pie_crab %>% select(latitude, size, water_temp)

#Select a range of columns using :
crabs_subset2 <- pie_crab %>% select(site:air_temp)

#Select a range and an individual column
crabs_subset3 <- pie_crab %>% select(date:water_temp, name)
names(crabs_subset3)

#----------#Mutate#-----------#
#We can use dplyr::mutate() to add or update a column, while keeping all existing columns
crabs_cm <-pie_crab %>%
  mutate(size_cm = size / 10)

#What happens if I use mutate to add a new column containing the mean of the size column?

crabs_mean <-pie_crab %>%
  mutate(mean_size = mean(size), na.rm = TRUE)

crabs_awesome <- pie_crab %>% mutate(name = "kona is awesome")

# Reminder: group_by + summarize. We can group by a variable and then summarize those groups within a column.
mean_size_by_site <- pie_crab %>%
  group_by(site) %>%
  summarize(mean_size = mean(size, na.rm = TRUE),
            sd_size = sd(size, na.rm = TRUE))

# What about a group_by then mutate?
group_mutate <- pie_crab %>%
  group_by(site) %>%
  mutate(mean_size = mean(size, na.rm = TRUE))

#Use dplyr::case_when() to write if else statements more easily

# I want to create a new column in pie_crab that contains "giant" if size is greater than 35 or "not giant" if the size is less than or equal to 20?

crabs_bin <- pie_crab %>%
  mutate(size_binned = case_when(
    size > 20 ~ "giant",
    size <= 20 ~ "not giant"))

#Indicators of a new column region that is based on specific sites.

sites_binned <- pie_crab %>%
  mutate(region = case_when(
    site %in% c("ZI", "CC", "PIE") ~ "Low",
    site %in% c("BB", "NIB") ~ "Middle",
    TRUE ~ "High"
  ))

#True says "if anything else is true...."
