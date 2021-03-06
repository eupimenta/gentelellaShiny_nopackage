library(shiny)
library(googleAnalyticsR)
library(dygraphs)
library(flexdashboard)
source("top_tiles.R")
source("box_layouts.R")
source("profile.R")
source("progress_bars.R")
source('template.R')
source('gentelellaUI.R')

options(shiny.port = 1221)
options(googleAuthR.scopes.selected = c("https://www.googleapis.com/auth/userinfo.email",
                                        "https://www.googleapis.com/auth/userinfo.profile",
                                        "https://www.googleapis.com/auth/analytics.readonly"))
options(googleAuthR.securitycode = "gentelellafkjfs24j234123")
options(googleAuthR.webapp.client_id = "201908948134-cjjs89cffh3k429vi7943ftpk3jg36ed.apps.googleusercontent.com")
options(googleAuthR.webapp.client_secret = "mE7rHl0-iNtzyI1MQia-mg1o")


boxRow <- tagList(
  dashboard_box(uiOutput("progress_bar2"), box_title = "Targets"),
  dashboard_box(gaugeOutput("gauge1"), box_title = "Flexdashboard Gauge", menuItems = NULL),
  dashboard_box(p("More interesting stuff"))
)

menuItems <- list(
  sideBarElement(" Home ",
                 icon = icon("home"),
                 list(a(href="index.html", "Dashboard"),
                      a(href="index2.html", "Dashboard2"),
                      a(href="index3.html", "Dashboard3"))                        
  ),
  sideBarElement(" Contact ",
                 icon = icon("envelope"),
                 list(a(href="http://twitter.com/HoloMarkeD", 
                        HTML(paste(icon("twitter"), "@HoloMarkeD"))),
                      a(href="http://code.markedmondson.me", 
                        HTML(paste(icon("rss"), " Blog"))),
                      a(href="https://github.com/MarkEdmondson1234/gentelellaShiny", 
                        HTML(paste(icon("github"), " Github"))))                        
  ),
  sideBarElement(column(width = 12, googleAuthR::googleAuthUI("auth"),
                        icon = NULL)
  ))

gentelellaPage(
  column(width = 12, googleAnalyticsR::authDropdownUI("auth_dropdown")),
  tileCountRow(tileCountUI("e1"), tileCountUI("e2"), tileCountUI("e3"),
                          tileCountUI("e4"), tileCountUI("e5"), tileCountUI("e6")),
  graph_box(dygraphOutput("trend_plot"),
                         datepicker = dateRangeInput("datepicker_id", NULL, start = Sys.Date() - 300)),
  boxRow,
  menuItems = menuItems,
  title_tag = "Shiny HTML Template",
  site_title = a(class="site_title", icon("eye"), span("Shiny HTML"))
)