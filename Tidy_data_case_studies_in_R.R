###########################################################
###########################################################

### Tidy Data Case Studies in R

###########################################################
###########################################################

## Preambles
## Install the tidyverse package
install.packages("tidyverse")

## Load the tidyverse package into the R workspace
library(tidyverse)

## 1. Each variable is stored in a column

## pivot_longer

## Let's get an idea of the arguments the function contains
?pivot_longer

## Let's create a sample data
table1 <- tibble(
  country = c("A", "B", "C"),
  `1999` = c("0.7K", "37K", "212K"),
  `2000` = c("2K", "80K", "213K")
)

## Print the data
table1

## Use pivot_longer to reshape the data
table1 %>%
  pivot_longer(c(`1999`, `2000`))

## Pivot on all the other columns except the country column
table1 %>%
  pivot_longer(-country)

## Overwrite its name with year 
## The value column should be named amount
table1 %>%
  pivot_longer(-country, names_to = "year", values_to = "n_cases")

## Using the gather function
table1 %>% 
  gather(-country, key = 'year', value = 'n_cases')


## pivot_wider()

## Let's get an idea of the arguments the function contains
?pivot_wider

## Let's read in the planet data

## First load the readr library to read in the csv file
library(readr)

## Now import the data using the read_csv function
planet_df <- read_csv("planet-data.csv")

## Print the first six rows of the data using the head() function
head(planet_df)

## Change this long data to wide form
planet_df %>% 
  pivot_wider(planet, names_from = "metric", values_from = "value") 

## 3. Unstack

## Load the PlantGrowth data
data("PlantGrowth")

## Explore the data
head(PlantGrowth, 5)
tail(PlantGrowth, 5)

## Let's split this data into the different treatment groups
unstack(PlantGrowth)

## Load the diets data set
diet <- read_csv("DIETS.csv")

## Explore the data
head(diet)
tail(diet)

## Unstack the data and assign it to a new variable
diet.data <- unstack(diet, WTLOSS ~ DIET)

## Check the first 5 rows of the new data
head(diet.data, n = 5)

## 4. Each Observation is stored in a row

## separate_rows()

## Let's get an idea of the arguments the function contains
?separate_rows

## Now import the data using the read_csv function
net_data <- read_csv("netflix_data.csv")

## Print the first six rows of the data using the head() function
head(net_data)

## Separate the actors in the cast column over multiple rows
net_data %>% 
  separate_rows(cast, sep = ", ")

## Find which six actors have the most appearances.
net_data %>% 
  separate_rows(cast, sep = ", ") %>% 
  rename(actor = cast) %>% 
  count(actor, sort = TRUE) %>% 
  head()

## 5. Each cell contains a single value

## Let's get an idea of the arguments the function contains
?separate

## Now import the data using the read_csv function
movies_data <- read_csv("movies_duration.csv")

## Print the first six rows of the data using the head() function
head(movies_data)

## Split the duration column into value and unit columns
movies_data %>% 
  separate(duration, into = c('value', 'unit'), sep = ' ', convert = TRUE)

## Find the average duration for each type and unit
movies_data %>% 
  separate(duration, into = c('value', 'unit'), sep = ' ', convert = TRUE) %>%
  group_by(type, unit) %>%
  summarize(mean_duration = mean(value))

## Join the title and type columns using sep = ' - '
netflix_df %>% 
  unite(title_type, title, type, sep = ' - ' )


## 6. separate_rows() & separate()

## Load the drink data
library(readxl)
drink_df <- read_excel("drink.xlsx")
drink_df

## Separate the ingredients column so that for each drink 
## each ingredient gets a row.

## Separate the ingredients over rows
drink_df %>%
  separate_rows(ingredients, sep = "; ")

## One step further
## Inspect the output of the previous step to find the separator 
## that splits the ingredients column into 
## three columns: ingredient, quantity, and unit.
## Make sure to convert data types to numeric when possible.

drink_df %>% 
  separate_rows(ingredients, sep = "; ") %>% 
  separate(ingredients, 
           into = c("ingredient", "quantity", "unit"), 
           sep = " ", 
           convert = TRUE)

