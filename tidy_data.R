library(readxl)
library(dplyr)
library(tidyr)

combine_timms_data <- function(question) {
  q <- read_xlsx(path = "T15_G8_MAT_ItemPercentCorrect.xlsx",
                 sheet = question,
                 range = "C6:D45",
                 col_types = c("text", "numeric"),
                 col_names = c("country", paste("question", question, sep = "_")))
}

timms_data <- combine_timms_data(1)

for(i in 2:215) {
  timms_data <- timms_data %>%
    left_join(combine_timms_data(i), by = "country")
}

timms_data <- gather(data = timms_data, key = "question", value = "percent_correct", -country)

# write_csv(timms_data, "2015_timss_data.csv")
