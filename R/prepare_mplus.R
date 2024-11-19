library("tidyverse")

prepare_model <- function(
    title,
    path = NULL,
    data = NULL,
    analysis = NULL,
    variable = NULL,
    model = NULL,
    output = NULL
) {
  mp_analysis <- 
    analysis %>% 
    purrr::imap(function(x, n) stringr::str_glue("{n} = {x}")) %>% 
    purrr::reduce(stringr::str_c, sep = "\n")
  
  MplusAutomation::mplusObject(TITLE = title, 
                               DATA = path,
                               ANALYSIS = mp_analysis,
                               rdata = data,
                               VARIABLE = variable,
                               MODEL = model,
                               OUTPUT = output)
}

# pathmodel <- mplusObject(
#   TITLE = "MplusAutomation Example - Path Model;", 
#   ANALYSIS = "TYPE = TWOLEVEL",
#   VARIABLE = "CLUSTER = cyl; WITHIN = mpg hp disp wt",
#   MODEL = "
#     %WITHIN%
#      mpg ON hp disp;
#      wt ON disp;
#   
#     %BETWEEN%",
#   OUTPUT = "CINTERVAL STANDARDIZED;",
#   rdata = mtcars)