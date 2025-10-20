library(here)
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(janeaustenr)

shapes <- c("Square","Circle","triangle")
paste("my favorite shape is a", shapes)
str_length(shapes) #tells you how many characters are in each chr

seq_data<-c("ATCCCGTC")
str_sub(seq_data, start = 2, end = 4) # extract the 2nd to 4th AA

badtreatments<-c("High", " High", "High ", "Low", "Low")
badtreatments

str_trim(badtreatments) # this removes both white spaces before and end

str_trim(badtreatments, side = "left") #only remove white space on left side

str_pad(badtreatments, 5, side = "right") #this adds white space to the right side. 
#5 means that there is a total of 5 character

str_pad(badtreatments, 5, side = "right", pad = "1") #pad is what it will in with

x<- "I love R"
str_to_upper(x) #makes everything uppercase
str_to_title(x) #makes each word capital

data<- c("AAA", "TATA", "CTAG", "GCTT")
str_view(data, pattern = "A") #highlights all the A in the data
str_detect(data, pattern = "AT") #gives a true or false if it has the pattern.

vals<-c("a.b", "b.c","c.d")
str_replace(vals, "\\."," ") #\\ before a special character will remove their meaning in R.
str_replace_all(vals, "\\.", " ") #all will search for . in all of the function

val2<-c("test 123", "test 456", "test")
str_subset(val2, "\\d")   #takes only things with digets

strings<-c("550-153-7578",
           "banana",
           "435.114.7586",
           "home: 672-442-6739")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
#this is how you can select data from grouping like a party
str_detect(strings, phone)
#pulls out only the phone numbers, banana was removed
test<-str_subset(strings, phone)
test %>% 
  str_replace_all("\\.","-") %>% 
  str_replace_all("[a-z]","") %>% 
  str_replace_all("\\:","") %>% 
  str_trim()

head(austen_books()) 
tail(austen_books())

original_books <- austen_books() %>% 
  group_by(book) %>% 
  mutate(line = row_number(), #find every line
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", #count when you see chapter
                                                 ignore_case = TRUE)))) %>% 
  ungroup()
head(original_books)

tidy_books <- original_books %>% 
  unnest_tokens(output = word, input = text)
head(tidy_books)

clean_books <- tidy_books %>% 
  anti_join(get_stopwords()) # joining by words we don't want. It will keep the stuff not on the join list

head(clean_books)

clean_books %>% 
  count(word, sort = TRUE) #count how many words are in the book


