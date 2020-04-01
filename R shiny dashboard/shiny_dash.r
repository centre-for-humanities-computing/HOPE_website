

  ## Dashboard for often-updated survey data
library(shiny)
library(tidyverse)
#library(jsonlite)
library(RColorBrewer)
library(shinydashboard)
library(plotly)
library(shinyBS)
library(bsplus)
library(readxl)
library(httr)

datapath <- "/home/au554730/Desktop/CHCAA/Dashboard/data2/data_rds_format"


files <- list.files(datapath, full.names = T)
most_recent <- files[length(files)]
#most_recent <- files[which.max(file.mtime(files))]


df <- read_rds(most_recent) %>%
  # Recoding country to be in English to fit the ECDPC data
  mutate(country = recode(country, Danmark = "Denmark", Sverige = "Sweden", Italien = "Italy", Frankrig = "France", Tyskland = "Germany", Ungarn = "Hungary"))


df$date <- as.Date(df$ActualSurveyStartTime)

# If you want to rename columns
#names(df)[names(df) %in% names(codebook)]) = unlist(codebook, use.names = F)
#names(codebook)[which (!names(codebook) %in% names(df))]



## Get ECDPC data


#create the URL
url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-",format(Sys.time(), "%Y-%m-%d"), ".xlsx", sep = "")
#download the dataset from the website to a local temporary file
GET(url, authenticate(":", ":", type="ntlm"), write_disk(tf <- tempfile(fileext = ".xlsx")))
#read the Dataset

countries_to_keep <- c(unique(df$country), "United_States_of_America", "United_Kingdom")

# Loading data and shaping for plots
data <- read_excel(tf) %>%
  filter(countriesAndTerritories %in% countries_to_keep) %>%
  select(dateRep, cases, deaths, countriesAndTerritories) %>%
  pivot_longer(cases:deaths) %>%
  # Recoding names to be consistent with the other data frame
  mutate(country = ifelse(countriesAndTerritories == "United_States_of_America", "USA", countriesAndTerritories),
         country = ifelse(countriesAndTerritories == "United_Kingdom", "United Kingdom", country),
         name = ifelse(name == "cases", "Cases", "Deaths")) %>%
  select(-countriesAndTerritories) %>%
  # Adding column with cumulative values
  group_by(name, country) %>%
  arrange(dateRep) %>%
  mutate(cs = cumsum(value),
         dateRep = as.Date(dateRep))



# get date ranges for epinion for all countries
date_ranges <- df %>% group_by(country) %>%
  summarise(xmin = min(date), xmax = max(date))

# set colors
plot_colors <- c("steelblue", "forestgreen", "#C93312", "#DC863B", "#E1AF00" , "slateblue4" )




## Plotting functions



case_death <- function(df, country_choice){
  df %>%
    filter(country == country_choice,
           dateRep >= date_ranges[date_ranges$country == country_choice,]$xmin
           & dateRep <= date_ranges[date_ranges$country == country_choice,]$xmax) %>%
    mutate(fit = fitted(loess(cs ~ as.numeric(dateRep)))) %>%

    # Interactive plot
    plot_ly(x = ~ dateRep) %>%
    add_markers(y = ~ cs, color = ~name, colors = plot_colors[1:2],
                hovertemplate = paste(
                  '<br>%{x}',
                  '<br>Number of %{fullData.name}: %{y}',
                  '<extra></extra>'))%>%
    add_lines(y = ~ fit, color = ~name, hoverinfo = "none",
              showlegend = F, colors = plot_colors[1:2]) %>%
    layout(yaxis = list(title = "Cumulative sum"),
           xaxis = list(title = "Date", tickangle = -45),
           legend = list(orientation = "h", xanchor = "center", x= 0.45, y = -0.2)) %>%
    plotly::config(displayModeBar = FALSE)

  #
  #   ggplot(aes(dateRep, cs, color = name)) +
  #       geom_point(alpha = 0.5) +
  #       geom_smooth(se = F, method = "loess") +
  #       theme_light() +
  #       scale_color_manual(values = plot_colors[1:2]) +
  #       theme(axis.text.x = element_text(size = 13),
  #           axis.text.y = element_text(size = 13),
  #           axis.title.x = element_text(size = 13),
  #           axis.title.y = element_text(size = 13),
  #           legend.title = element_blank(),
  #           legend.position = "bottom",
  #           legend.text = element_text(size = 13)) +
  #       labs(x = "Date", y = "Cumulative sum")
}



# Plot 2 - development in symptoms
dev_symp <- function(df, country_choice){
  df %>%
    select(q23_0_resp, q23_1_resp, q23_2_resp, q23_3_resp, q23_4_resp, q23_5_resp, date, country) %>%
    filter(country == country_choice) %>%
    rename(Headache = q23_0_resp,
           `Sore throat` = q23_1_resp,
           Fever = q23_2_resp,
           Cough = q23_3_resp,
           `Sore muscles` = q23_4_resp,
           Breathlessness = q23_5_resp) %>%
    gather("symptom", "value", -date, -country) %>%
    na.omit() %>%
    mutate(symptom = factor(symptom, c("Fever", "Sore throat", "Cough", "Sore muscles", "Breathlessness", "Headache"))) %>%
    group_by(symptom, date) %>%
    summarize(pct_yes = mean(value == "Ja")) %>%
    mutate(fit = fitted(loess(pct_yes ~ as.numeric(date), span = 1))) %>%

    # Interactive plot
    plot_ly(x = ~ date) %>%
    add_markers(y = ~ pct_yes, color = ~symptom, colors = plot_colors,
                hovertemplate = paste(
                  '<b>%{fullData.name}</b>',
                  '<br>%{x}',
                  '<br>Percentage: %{y}',
                  '<extra></extra>'))%>%
    add_lines(y = ~ fit, color = ~symptom, hoverinfo = "none",
              showlegend = F, colors = plot_colors) %>%
    layout(yaxis = list(title = "Share with signs of illness",
                        range = c(0,0.5), tickformat = "%"),
           xaxis = list(title = "Date", tickangle = -45),
           legend = list(orientation = "h", xanchor = "center", x= 0.45, y = -0.2)) %>%
    plotly::config(displayModeBar = FALSE)


  # # Plotting with ggplot
  # ggplot(aes(date, pct_yes, color = symptom)) +
  #   geom_point(alpha = 0.5) +
  #   geom_smooth(se = F) +
  #   scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0, 0.5)) +
  #   scale_color_manual(values = plot_colors) +
  #   theme_light() +
  #   theme(axis.text.x = element_text(size = 13),
  #     axis.text.y = element_text(size = 13),
  #     axis.title.x = element_text(size = 13),
  #     axis.title.y = element_text(size = 13),
  #     legend.title = element_blank(),
  #     legend.position = "bottom",
  #     legend.text = element_text(size = 13)) +
  #   labs(x = "Date", y = "Share with signs of illness")
}


# Plot 2 - development in habits
dev_hab <- function(df, country_choice){
  df %>%
    select(q20_1_resp, q20_2_resp, q20_3_resp, q20_4_resp, date, country) %>%
    filter(country == country_choice) %>%
    rename(Contact = q20_1_resp,
           `Eaten healthy` = q20_2_resp,
           Exercise = q20_3_resp,
           `Feeling alone` = q20_4_resp) %>%
    gather("symptom", "value", -date, -country) %>%
    na.omit() %>%
    mutate(symptom = factor(symptom, c("Contact", "Eaten healthy", "Exercise", "Feeling alone"))) %>%
    # Recoding i mindre grad/slet ikke to 0,
    # i nogen grad/i høj grad to 1
    mutate(value = replace(value, value == "I nogen grad" | value == "I høj grad", 1),
           value = replace(value, value == "Slet ikke" | value == "I mindre grad", 0),
           value = as.integer(value)) %>%
    group_by(symptom, date) %>%
    summarize(pct_yes = mean(value)) %>%
    mutate(fit = fitted(loess(pct_yes ~ as.numeric(date)))) %>%

    # Interactive plot
    plot_ly(x = ~ date) %>%
    add_markers(y = ~ pct_yes, color = ~symptom, colors = plot_colors[1:4],
                hovertemplate = paste(
                  '<b>%{fullData.name}</b>',
                  '<br>%{x}',
                  '<br>Percentage: %{y}',
                  '<extra></extra>'))%>%
    add_lines(y = ~ fit, color = ~symptom, hoverinfo = "none",
              showlegend = F, colors = plot_colors[1:4]) %>%
    layout(yaxis = list(title = "Share of the public",
                        range = c(0,1), tickformat = "%"),
           xaxis = list(title = "Date", tickangle = -45),
           legend = list(orientation = "h", xanchor = "center", x= 0.45, y = -0.2)) %>%
    plotly::config(displayModeBar = FALSE)

  #   # Plotting with ggplot
  # ggplot(aes(date, pct_yes, color = symptom)) +
  #     geom_point(alpha = 0.5) +
  #     geom_smooth(se = F) +
  #     scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0, 1)) +
  #     scale_color_manual(values = plot_colors[1:4]) +
  #     theme_light() +
  #     theme(axis.text.x = element_text(size = 13),
  #       axis.text.y = element_text(size = 13),
  #       axis.title.x = element_text(size = 13),
  #       axis.title.y = element_text(size = 13),
  #       legend.title = element_blank(),
  #       legend.position = "bottom",
  #       legend.text = element_text(size = 13)) +
  #     labs(x = "Date", y = "Share of the public")
}



dev_opt_anx <- function(df, country_choice){
  df %>%
    select(q3, q4, date, country) %>%
    filter(country == country_choice) %>%
    rename(Anxiety = q3,
           Optimism = q4) %>%
    gather("symptom", "value", -date, -country) %>%
    na.omit() %>%
    # Recoding i mindre grad/slet ikke to 0,
    # i nogen grad/i høj grad to 1
    mutate(value = ifelse(value == "I nogen grad" | value == "I høj grad", 1, 0),
           value = as.integer(value)) %>%
    group_by(symptom, date) %>%
    summarize(pct_yes = mean(value)) %>%
    mutate(fit = fitted(loess(pct_yes ~ as.numeric(date)))) %>%

    # Interactive plot
    plot_ly(x = ~ date) %>%
    add_markers(y = ~ pct_yes, color = ~symptom, colors = plot_colors[1:2],
                hovertemplate = paste(
                  '<b>%{fullData.name}</b>',
                  '<br>%{x}',
                  '<br>Percentage: %{y}',
                  '<extra></extra>'))%>%
    add_lines(y = ~ fit, color = ~symptom, hoverinfo = "none",
              showlegend = F, colors = plot_colors[1:2]) %>%
    layout(yaxis = list(title = "Share anxious/optimistic",
                        range = c(0.25,1), tickformat = "%"),
           xaxis = list(title = "Date", tickangle = -45),
           legend = list(orientation = "h", xanchor = "center", x= 0.45, y = -0.2)) %>%
    plotly::config(displayModeBar = FALSE)

  #   # Plotting
  # ggplot(aes(date, pct_yes, color = symptom)) +
  #     geom_point(alpha = 0.5) +
  #     geom_smooth(se = F) +
  #     scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0.5, 1)) +
  #     scale_color_manual(values = plot_colors[1:2]) +
  #     theme_light() +
  #     theme(axis.text.x = element_text(size = 13),
  #       axis.text.y = element_text(size = 13),
  #       axis.title.x = element_text(size = 13),
  #       axis.title.y = element_text(size = 13),
  #       legend.title = element_blank(),
  #       legend.position = "bottom",
  #       legend.text = element_text(size = 13)) +
  #     labs(x = "Date", y = "Share anxious/optimistic")
}



#dev_comp
dev_comp1 <- function(df, country_choice){
  df %>%
    select(q10_2:q13, date, country) %>%
    filter(country == country_choice) %>%
    # Changing so "Ja" means compliant
    mutate(q11 = ifelse(q11 == "Nej", "Ja", "Nej"),
           q12 = ifelse(q12 == "Nej", "Ja", "Nej"),
           q13 = ifelse(q13 == "Nej", "Ja", "Nej")) %>%
    rename(`Sneezing in sleeve` = q10_2,
           `Do not handshake` = q11,
           `Hug and kiss only familiy` = q12,
           `Do not stockpile` = q13) %>%
    gather("symptom", "value", -date, -country) %>%
    na.omit() %>%
    mutate(symptom = factor(symptom, c("Sneezing in sleeve", "Do not handshake", "Hug and kiss only familiy", "Do not stockpile"))) %>%
    group_by(symptom, date) %>%
    summarize(pct_yes = mean(value == "Ja")) %>%
    mutate(fit = fitted(loess(pct_yes ~ as.numeric(date)))) %>%

    # Interactive plot
    plot_ly(x = ~ date) %>%
    add_markers(y = ~ pct_yes, color = ~symptom, colors = plot_colors[1:4],
                hovertemplate = paste(
                  '<b>%{fullData.name}</b>',
                  '<br>%{x}',
                  '<br>Percentage: %{y}',
                  '<extra></extra>'))%>%
    add_lines(y = ~ fit, color = ~symptom, hoverinfo = "none",
              showlegend = F, colors = plot_colors[1:4]) %>%
    layout(yaxis = list(title = "Share with compliant behavior",
                        range = c(0.25,1), tickformat = "%"),
           xaxis = list(title = "Date", tickangle = -45),
           legend = list(orientation = "h", xanchor = "center", x= 0.45, y = -0.25)) %>%
    plotly::config(displayModeBar = FALSE)

  #   # Plotting
  # ggplot(aes(date, pct_yes, color = symptom)) +
  #     geom_point(alpha = 0.5) +
  #     geom_smooth(se = F) +
  #     scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0.5, 1)) +
  #     scale_color_manual(values = plot_colors[1:4]) +
  #     theme_light() +
  #     theme(axis.text.x = element_text(size = 13),
  #       axis.text.y = element_text(size = 13),
  #       axis.title.x = element_text(size = 13),
  #       axis.title.y = element_text(size = 13),
  #       legend.title = element_blank(),
  #       legend.position = "bottom",
  #       legend.text = element_text(size = 13)) +
  #     labs(x = "Date", y = "Share with compliant behavior")
}


dev_comp2 <- function(df, country_choice){
  df %>%
    select(q14:q17, date, country) %>%
    filter(country == country_choice) %>%
    # Changing so "Ja" means compliant
    mutate(q14 = ifelse(q14 == "Nej", "Ja", "Nej"),
           q15 = ifelse(q15 == "Nej", "Ja", "Nej"),
           q16 = ifelse(q16 == "I nogen grad" | q16 == "I høj grad", "Ja", "Nej")) %>%
    rename(`Do not use public transport` = q14,
           `Avoid 10+ crowds` = q15,
           `Keep distance to strangers` = q16,
           `Keep distance to weak and sick` = q17) %>%
    gather("symptom", "value", -date, -country) %>%
    na.omit() %>%
    mutate(symptom = factor(symptom, c("Do not use public transport", "Avoid 10+ crowds", "Keep distance to strangers", "Keep distance to weak and sick"))) %>%
    group_by(symptom, date) %>%
    summarize(pct_yes = mean(value == "Ja")) %>%
    mutate(fit = fitted(loess(pct_yes ~ as.numeric(date)))) %>%

    # Interactive plot
    plot_ly(x = ~ date) %>%
    add_markers(y = ~ pct_yes, color = ~symptom, colors = plot_colors[1:4],
                hovertemplate = paste(
                  '<b>%{fullData.name}</b>',
                  '<br>%{x}',
                  '<br>Percentage: %{y}',
                  '<extra></extra>'))%>%
    add_lines(y = ~ fit, color = ~symptom, hoverinfo = "none",
              showlegend = F, colors = plot_colors[1:4]) %>%
    layout(yaxis = list(title = "Share with compliant behavior",
                        range = c(0.25,1), tickformat = "%"),
           xaxis = list(title = "Date", tickangle = -45),
           legend = list(orientation = "h", xanchor = "center", x= 0.45, y = -0.25)) %>%
    plotly::config(displayModeBar = FALSE)

  #   # Plotting
  # ggplot(aes(date, pct_yes, color = symptom)) +
  #     geom_point(alpha = 0.5) +
  #     geom_smooth(se = F) +
  #     scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits = c(0.5, 1)) +
  #     scale_color_manual(values = plot_colors[1:4]) +
  #     theme_light() +
  #     theme(axis.text.x = element_text(size = 13),
  #       axis.text.y = element_text(size = 13),
  #       axis.title.x = element_text(size = 13),
  #       axis.title.y = element_text(size = 13),
  #       legend.title = element_blank(),
  #       legend.position = "bottom",
  #       legend.text = element_text(size = 13)) +
  #     labs(x = "Date", y = "Share with compliant behavior")
}



## UI text

welcome_text <- column(12,
                       p(h4("Welcome to the HOPE Dashboard"), "Here you can explore the development of symptoms, habits, compliance to safety regulations, and mental health in the population of 8 countries."),
                       p(
                         "The data comes from surveys regularly conducted by Epinion of approximately 500 people per country per survey."),
                       p(
                         "Hover the mouse over the graph titles for more information."
                       ),
                       p(
                         "Select which country to show data for in the box to the right. ")
)




help_cases <- bsPopover("case", title = "Development in Cases and Deaths", content = "This graphs shows the cumulative sum of cases and deaths in the chosen country ", placement = "top")

help_symptoms <- bsPopover("symp", title = "Development in Symptoms", content = "This graphs shows the proportion of respondents who answered yes to having experienced these symptons in the past week", placement = "top")

help_habits <-   bsPopover("habits", title = "Development in Symptoms",
                           content = paste("<p>This graphs shows the proportion of respondents who answered either \\' to a certain degree\\' or \\'to a high degree\\' to the questions:</p> ",
                                           em("To what degree..."), "<br>",
                                           "... have you been in contact with close friends and or family with whom you do not live, during the past week?<br>",
                                           "... do you feel you have eaten healthily during the past week?<br>",
                                           "... do you feel you have taken enough exercise during the past week?<br>",
                                           "... do you feel that you stand alone in the current Corona situation?"
                           ), placement = "top")

help_opt_anx <-  bsPopover("opt_anx", title = "Development in Optimism and Anxiety", content =paste("<p>This graphs shows the proportion of respondents who answered either \\' to a certain degree\\' or \\'to a high degree\\' to the questions:</p> ",
                                                                                                    em("To what degree do you fear the consequences of the current situation with the Corona virus?"), "<br>", "<br>",
                                                                                                    em("How optimistic are you that your country will be able to get the Corona virus under control in the near future?")
), placement = "top")



help_compliance1 <-  bsPopover("compliance1", title = "Development in Compliance", content = paste("<p>These graphs shows the proportion of respondents who answered \\'no\\' to the questions:</p> ",
                                                                                                   em("When you coughed and/or sneezed yesterday, did you do this in your sleeve each time?"), "<br><br>",
                                                                                                   em("Did you shake someone\\'s hand yesterday?"), "<br><br>",
                                                                                                   em("Did you hug or kiss someone outside your closest family yesterday?"), "<br><br>",
                                                                                                   em("Did you buy more than you usually do, yesterday?")
), placement = "top")



help_compliance2 <-  bsPopover("compliance2", title = "Development in Compliance", content = paste("<p>These graphs shows the proportion of respondents who answered \\'no\\' to the questions:</p> ",
                                                                                                   em("Did you use public transport yesterday?"), "<br><br>",
                                                                                                   em("Were you in a room with more than 10 people yesterday?"), "<br><br>",
                                                                                                   "<p>Yes to the question: </p>",
                                                                                                   em("Were you careful yesterday to keep your distance from elderly and chronically ill people?"), "<br><br>",
                                                                                                   "<p> And answered either \\' to a certain degree\\' or \\'to a high degree\\' to the question: </p>",
                                                                                                   em("To what degree were you careful yesterday to keep your distance from people outside your closest family?")
), placement = "top")






## Shiny dashboard

# Constructing named list of countries for the dropdown
country_list = setNames(as.list(unique(df$country)),  unique(df$country))




ui <- dashboardPage(

  dashboardHeader(title = "HOPE Dashboard"),
  dashboardSidebar(disable = TRUE),

  dashboardBody(
    # Activate Popovers
    use_bs_popover(),

    fluidRow(
      ## Welcome text
      box(width = 8, status = "primary",
          welcome_text
      ),
      # Country selecter
      box(width = 4, status = "primary",
          column(12,
                 selectInput("country",
                             label = h4("Select Country: "),
                             choices = country_list
                 )
          )
      )
    ),

    # Help tooltips
    help_cases,
    help_symptoms,
    help_habits,
    help_opt_anx,
    help_compliance1,
    help_compliance2,

    # Graphs
    fluidRow(
      box(title = textOutput("case"),
          column(12,
                 plotlyOutput("plot1")
          )
      ),
      box(title = textOutput("symp"),
          column(12,
                 plotlyOutput("plot2")
          )
      )
    ),
    fluidRow(
      box(title = textOutput("habits"),
          column(12,
                 plotlyOutput("plot3")
          )
      ),
      box(title = textOutput("opt_anx"),
          column(12,
                 plotlyOutput("plot4")
          )
      )
    ),
    fluidRow(
      box(title = textOutput("compliance1"),
          column(12,
                 plotlyOutput("plot5")
          )
      ),
      box(title = textOutput("compliance2"),
          column(12,
                 plotlyOutput("plot6")
          )
      )
    )
  )
)

server <- function(input, output) {

  values <- reactiveValues()
  values$country <- NULL

  # Update country
  observeEvent(input$country, {
    values$country <- input$country
  })

  # Update box titles based on country
  output$case <- renderText({
    paste("Cases and Deaths in", values$country)
  })

  output$symp <- renderText({
    paste("Symptoms in", values$country)
  })

  output$opt_anx <- renderText({
    paste("Optimism and Anxiousness in", values$country)
  })

  output$habits <- renderText({
    paste("Habits in", values$country)
  })
  output$compliance1 <- renderText({
    paste("Compliance in", values$country)
  })

  output$compliance2 <- renderText({
    paste("Compliance in", values$country, "continued")
  })


  # plots
  output$plot1 <- renderPlotly({
    case_death(data, values$country)
  })

  output$plot2 <- renderPlotly({
    dev_symp(df, values$country)
  })

  output$plot3 <- renderPlotly({
    dev_hab(df, values$country)
  })

  output$plot4 <- renderPlotly({
    dev_opt_anx(df, values$country)
  })
  output$plot5 <- renderPlotly({
    dev_comp1(df, values$country)
  })

  output$plot6 <- renderPlotly({
    dev_comp2(df, values$country)
  })



}


shinyApp(ui, server)


