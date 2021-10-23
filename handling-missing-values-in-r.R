###########################################################
###########################################################

### Handling Missing Values in R

###########################################################
###########################################################

## Preambles
## Install the tidyverse package (if not previously installed)
install.packages("tidyverse")

## Load the tidyverse package
library(tidyverse)

## Load the ggplot2 package into the R workspace
library(ggplot2)

## Load the msleep data
data("msleep")

## Check the first 6 rows of the data
head(msleep)

## Check the dimension of the data
dim(msleep)

## Check the column names
names(msleep)

## Check the number of missing values for each column
sapply(msleep, function(x) sum(is.na(x)))

## Using the map function
msleep %>% 
  map(is.na) %>% 
  map(sum)

## Calculate the proportion of missingness
## for each variable
msleep %>%
  map(is.na) %>%
  map(sum)%>%
  map(~ . / nrow(msleep))%>%
  bind_cols()

## Select the vore, sleep_rem, sleep_cycle, and brainwt
## Drop rows with NA values in the vore column
msleep_data <- msleep %>%
  select(vore, sleep_rem, sleep_cycle, brainwt)

## Print the new msleep data
msleep_data

## Check the dimension of the new data
dim(msleep_data)

## Drop rows with NA values in the vore column
msleep_data <- msleep_data %>%
  drop_na(vore)

## Check the dimension of the new data
dim(msleep_data)

## Replace the NA values in the sleep_rem 
## column with integer zero values (0L).
msleep_data %>% 
  replace_na(list(sleep_rem = 0L))

## Fill the brainwt column upwards
msleep_data %>%
  fill(brainwt, .direction = "up") 

## Replace the NA values in the sleep_rem 
## column with integer zero values (0L).
## Fill the brainwt column upwards
msleep_data %>%
  replace_na(list(sleep_rem = 0L)) %>% 
  fill(brainwt, .direction = "up") 

## Replace the NA values in the sleep_rem 
## column with integer zero values (0L).
## Fill the brainwt column downwards
msleep_data %>%
  replace_na(list(sleep_rem = 0L)) %>% 
  fill(brainwt, .direction = "down") 

## Note: You can fill "downup" and "updown" also. 
## You can check that out


## Fill the missing values in the sleep_cycle column
## using the median of the values
msleep_data %>% 
  mutate(sleep_cycle = 
           replace_na(sleep_cycle, median(sleep_cycle, na.rm = T)))

## Chain all the steps together and
## save the result as msleep_data
msleep_data <- msleep_data %>% 
                replace_na(list(sleep_rem = 0L)) %>%
                fill(brainwt, .direction = "up") %>%
                mutate(sleep_cycle = 
                         replace_na(sleep_cycle, 
                                    median(sleep_cycle, na.rm = T)))
  
## Print the cleaned data
msleep_data



