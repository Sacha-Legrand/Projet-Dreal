# ---------------------------------------------------------------------- #
# ------------------------------------------------------------ # 
# -------------------------------------------------- #

# ---------------------------------------- #


# ------------------------------ #
# -------------------- #
# ---------- #


# ---------------------------------------------------------------------- #
# ------------------------------ TITRE --------------------------------- #
# ---------------------------------------------------------------------- #







dashboardPage(
  # Début du Dashboard
  
  
  
  
  
  
  
  ##########################################################################
  # ----------------------------- EN TÊTE -------------------------------- #
  ##########################################################################
  # En tête du dashboard
  dashboardHeader(title = "Hydrologie des cours d'eau Normand",
                  titleWidth = 350),
  # Fin en tête du dashboard
  # ---------------------------------------------------------------------- #
  
  
  
  
  
  
  
  ##########################################################################
  # --------------- BARRE LATÉRALE / MENU DE NAVIGATION ------------------ #
  ##########################################################################
  # Barre Latérale / Menu de navigation
  dashboardSidebar(
    # Barre latéral du dashboard
    
    width=350,
    sidebarMenu(id="menu_principal",
                # Menu de navigation
                
                # ------------------------------------------------------------ #
                menuItem("Introduction", tabName = "menu_intro", icon=icon("home"),
                         # premier menu : Introduction
                         
                         # les sub-menus
                         menuSubItem("Contexte de l'étude", tabName="sub_menu_contexte"),
                         menuSubItem("Données de l'étude", tabName="sub_menu_data"),
                         menuSubItem("Lexique", tabName="sub_menu_lexique"),
                         menuSubItem("Bibliographie", tabName = "sub_menu_biblio")
                         
                         
                ), # End premier menu Introduction
                # ------------------------------------------------------------ #
                
                
                
                # ------------------------------------------------------------ #
                menuItem("Cartographie", tabName = "menu_cartes", icon = icon("map")
                         # deuxième menu : cartographie
                         
                ), # End deuxième menu cartographie
                # ------------------------------------------------------------ #
                
                
                # ------------------------------------------------------------ #
                menuItem("Cours d'eau",tabName = "menu_stats",
                         icon = icon("tint", lib = "glyphicon"),
                         # troisième menu : Cours d'eau
                         
                         
                         # les sub-menus
                         menuSubItem("Touques", tabName="sub_menu_touques"),
                         menuSubItem("Orne", tabName="sub_menu_orne"),
                         menuSubItem("Odon", tabName="sub_menu_odon"),
                         menuSubItem("Sélune", tabName="sub_menu_selune")
                         
                         
                ), # End troisième menu stats
                # ------------------------------------------------------------ #
                
                # ------------------------------------------------------------ #
                menuItem("Les sondes",tabName = "menu_stats",
                         icon = icon("map-marker", lib = "glyphicon"),
                         # Quatrième  menu : Les sondes
                         
                         
                         # les sub-menus
                         menuSubItem("Descriptif", tabName = "sub_menu_sondes_synthese"),
                         menuSubItem("Comparaisons", tabName = "sub_menu_comparaison")
                         
                         
                ), # End  Quatrième  menu : Les sondes
                # ------------------------------------------------------------ #
                
                # ------------------------------------------------------------ #
                menuItem("Analyse de données",tabName = "menu_stats_avancees",
                         icon = icon("stats", lib = "glyphicon"),
                         # Cinquième  menu : Analyse de données
                         
                         # les sub-menus
                         menuSubItem("O'Driscoll", tabName = "ODriscoll"),
                         menuSubItem("ACI et ACP", tabName = "aci_acp")
                         
                ), # End  Cinquième  menu : Analyse de données
                # ------------------------------------------------------------ #
                
                # ------------------------------------------------------------ #
                menuItem("Références",tabName = "Reference",
                         icon = icon("pencil", lib = "glyphicon")
                         # Cinquième  menu : Référence
                         
                ) # End Cinquième  menu : Référence
                # ------------------------------------------------------------ #
                
    ) # End sidebarMenu
  ), # End dashboardSidebar
  
  
  # Fin barre Latérale / Menu de navigation
  # ---------------------------------------------------------------------- #
  
  
  
  
  
  
  
  
  
  ##########################################################################
  # ------------------------------ CORPS --------------------------------- #
  ##########################################################################
  dashboardBody(
    #corps du dashboard
    
    
    #########################################################
    # Styles
    #########################################################
    shinyDashboardThemes(
      theme = "poor_mans_flatly"
    ),
    
    
    # ------------------------------------------------------------ #
    # HTML / CSS / javascript
    useShinyjs(),
    
    tags$body(
      tags$style(
        HTML(
          '#map_sondes {width:100%;height:calc(85vh - 80px) !important;}',
          '#map_eau {width:100%;height:calc(85vh - 80px) !important;}',
          #'#panel_info_sondes {width:25%;height:calc(125vh - 125px) !important;}',
          '#myPannel2 {width:25%;height:calc(125vh - 125px) !important;}',
          '#ID{color: black;font-size: 20px;font-weight: bold;}',
          '#ID2{color: black;font-size: 20px;font-weight: bold;}',
          '#DATE2{color: black;font-size: 10px;}',
          '#link_to_details_sonde{color: #30a8cf;font-size: 14px;}',
          '#link_to_details_sonde{color: #30a8cf;font-size: 14px;}',
          '#id_lab_txt{font-size: 24px; font-weight: bold;}'
        )
      )
    ),
    # ------------------------------------------------------------ #
    
    #########################################################
    # TabsItems
    #########################################################
    
    # ------------------------------------------------------------ #
    tabItems(
      ####################################################
      # Premier Menu : Introduction
      ####################################################
      
      ####################################
      # Sous-menu : Contexte
      ####################################
      # -------------------------------------------------- #
      tabItem(tabName = "sub_menu_contexte",
              # Premier onglet du Menu 1 Introduction : Contexte de l'étude
              
              h2("Contexte de l'étude des températures des cours d'eau"),
              
              
              fluidRow(
                
              ) # End fluidRow
              
      ), # End tabItem 1 (onglet 1 du menu 1)
      # -------------------------------------------------- #
      
      
      
      
      ####################################
      # Sous-menu : Données de l'étude
      ####################################
      # -------------------------------------------------- #
      tabItem(tabName = "sub_menu_data",
              # Onglet 2 du Menu 1 Introduction : Données de l'étude
              
              
              h2("Données de l'étude"),
              
              fluidRow(
                tableOutput("Variables") 
                
              )
              
              
              
              
      ), # End tabItem 2 (onglet 2 du menu 1)
      # -------------------------------------------------- #
      
      
      ####################################
      # Sous-menu : Lexique
      ####################################
      
      # -------------------------------------------------- #
      tabItem(tabName = "sub_menu_lexique",
              # Onglet 3 du Menu 1 Introduction : Lexique
              
              
              h2("Lexique"),
              
              
              fluidRow(
                
              ) # End fluidRow
              
      ), # End tabItem 3 (onglet 3 du menu 1)
      # -------------------------------------------------- #
      
      ####################################
      # Sous-menu : Bibliographie
      ####################################
      # -------------------------------------------------- #
      tabItem(tabName = "sub_menu_biblio",
              # Onglet 4 du Menu 1 Introduction : Bibliographie
              
              
              h2("Bibliographie"),
              
              
              fluidRow(
                
              ) # End fluidRow
              
      ), # End tabItem 4 (onglet 4 du menu 1)
      # -------------------------------------------------- #
      
      
      # ################################################## #    
      # Fin Menu 1 : Introduction
      # ################################################## #$
      
      
      
      
      
      
      
      
      ####################################################
      # Deuxième Menu : Cartographie
      ####################################################
      
      
      
      
      
      # -------------------------------------------------- #
      tabItem(tabName = "menu_cartes",
              # Carte des sondes
              
              
              h2("Emplacement des sondes thermiques"),
              
              
              
              
              # ---------------------------------------- #
              fluidRow(
                
                column(
                  width = 8,
                  box(
                    # column(width = 2, checkboxInput(inputId = "DREAL", label = "Sondes DREAL", value=TRUE)),
                    # column(width = 2, checkboxInput(inputId = "OFB", label = "Sondes OFB")),
                    # column(width = 2, checkboxInput(inputId = "BV1", label = "Grand BV", value=F)),
                    # column(width = 2, checkboxInput(inputId = "ceau", label = "Cours d'eau", value=F)),
                    
                    
                    width = 12, height = "100%",
                    leafletOutput("map_sondes")
                  )
                  
                ),
                
                
                
                column(
                  width = 4,
                  # box(
                  #   width = 12,
                  #   checkboxInput(inputId = "DREAL", label = "Sondes DREAL", value=TRUE),
                  #   checkboxInput(inputId = "OFB", label = "Sondes OFB"),
                  #   checkboxInput(inputId = "BV1", label = "Grand BV", value=F),
                  #   checkboxInput(inputId = "ceau", label = "Cours d'eau", value=F)
                  # ),
                  
                  
                  hidden(
                    
                    wellPanel(
                      id="panel_info_sondes",
                      style = "overflow-y:scroll; max-height: 600px; background-color: #FFFFFF;",
                      
                      actionButton(inputId = "closeIP", label = "X"),
                      
                      #br(),
                      
                      textOutput("ID"),
                      
                      #br(),
                      
                      h4("Image de l'emplacement de la sonde"),
                      
                      imageOutput("img_sonde", height = "100%"),
                      
                      br(),
                      #br(),
                      
                      
                      h4("Représentation de la série"),
                      
                      dygraphOutput("temp_sonde"),
                      
                      #h4("Résumé statistique"),
                      #tableOutput("table_sonde"),
                      actionLink(inputId = "link_to_details_sonde", label = "Détails")
                      
                    )
                    
                  )
                  
                ),
                
                
                
                
              ) # End fluidRow
              # ---------------------------------------- #
              
              
              
              
              
              
      ), # End tabItem 1 (onglet 1 du menu 2)
      
      
      
      
      # ################################################## #
      # Fin du Menu 2 : Cartographie
      # ################################################## #                        
      
      
      ####################################################
      # Troisième Menu : Cours d'eau
      ####################################################
      
      ###########################
      # sous-Onglet Touques
      ###########################
      
      # -------------------------------------------------- #
      tabItem(tabName = "sub_menu_touques",
              # touques
              
              h2("Analyse des températures de la Touques"),
              
              tabsetPanel(
                tabPanel(strong("Description"),
                         fluidRow(
                           
                           column(width = 2,
                                  
                                  
                                  img(src="Touques.png")),
                           
                           column( width = 6,
                                   
                                   h3(strong("La Touques")),
                                   br(),
                                   status = "primary",solidHeader = TRUE,
                                   
                                   p("Taille du fleuve : 107km") ,    
                                   p("Surface du bassin versant associcé : 1305 km²"), 
                                   p("Prend source à : Gacé"),   
                                   p("Se jette en : Mer de la Manche (Deauville,Trouville-sur-Mer)"), 
                                   p("Nature principale des couches sédimentaires : crayeuse"),
                                   
                           ),# EndColumn
                           
                           
                           
                           column( width = 4, height=200,
                                   h4(strong("Localisation")),
                                   leafletOutput("map_Touques",height = 200) 
                           ),
                           column( width = 10,
                                   h4("Statistiques Descriptives"),
                                   br(),
                                   DT::dataTableOutput("StatsDescTouques")
                           )
                           
                           
                           
                         )
                         
                ), # End tabPanel Description
                
                tabPanel(strong("Températures"),
                         tabsetPanel(    
                           tabPanel("Températures moyennes et lissées sur 7 jours",
                                    fluidRow(
                                      box(strong("Données aggrégées à la journée"),
                                          width = 4,
                                          checkboxInput(inputId = "Teau_min", label = "Températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_moy", label = "Températures moyennes", value=T),
                                          checkboxInput(inputId = "Teau_max", label = "Températures maximales", value=F)
                                      ),
                                      box(strong("Données lissées sur 7 jours"),
                                          width = 4,
                                          checkboxInput(inputId = "Teau_minMM7", label = "Températures minimales ", value=F),
                                          checkboxInput(inputId = "Teau_moyMM7", label = "Températures moyennes  ", value=F),
                                          checkboxInput(inputId = "Teau_maxMM7", label = "Températures maximales ", value=F)
                                      ),
                                      box
                                      (width = 4,
                                        strong("Seuils de températures limites"),
                                        radioButtons("preferendum_th", "",
                                                     c("Truite" = "truite",
                                                       "Brochet" = "brochet",
                                                       "Pas de seuil" = "rien"), 
                                                     selected = "rien")),
                                      # box( width = 3,
                                      #      checkboxInput(inputId = "LimiteTruite", label = "Preferendum thermiques", value=F)
                                      # ),
                                      
                                      
                                      box(width=6,
                                          h3(strong("Touques T1")),
                                          dygraphOutput("Sonde825MM7")
                                      ),       
                                      
                                      box(
                                        width=6,
                                        h3(strong("Touques T3")),
                                        dygraphOutput("Sonde827MM7")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Touques T4")),
                                        dygraphOutput("Sonde828MM7")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Touques T6")),
                                        dygraphOutput("Sonde830MM7")
                                      )
                                      
                                      
                                    )# End fluidRow
                           ), # End tabPanel 
                           
                           
                           
                           
                           tabPanel("Températures lissées sur 30 jours",
                                    
                                    fluidRow(
                                      
                                      box(strong("Données lissées sur 30 jours"),
                                          width = 6,
                                          checkboxInput(inputId = "Teau_minMM30", label = "Températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_moyMM30", label = "Températures moyennes", value=T),
                                          checkboxInput(inputId = "Teau_maxMM30", label = "Températures maximales", value=F)
                                          
                                      ), 
                                      
                                      box(strong("Tendances"),
                                          width = 6,height = 170,
                                          checkboxInput(inputId = "Teau_minreg30", label = "Tendance des températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_maxreg30", label = "Tendance des températures maximales", value=F)
                                          
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Touques T1")),
                                        dygraphOutput("Sonde825MM30")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Touques T3")),
                                        dygraphOutput("Sonde827MM30")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Touques T4")),
                                        dygraphOutput("Sonde828MM30")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Touques T6")),
                                        dygraphOutput("Sonde830MM30")
                                      ),
                                      br(),br(),
                                      h4("Moyennes annuelles des moyennes mensuelles des MM30"),
                                      DT::dataTableOutput("db_Touques_stats_MM30_An"),
                                      br(),br(),
                                      h4("Moyennes mensuelles des MM30"),
                                      DT::dataTableOutput("db_Touques_stats_MM30_mois")
                                      
                                    )# end fluid
                           ),# end tabPanel
                           tabPanel("Températures lissées sur 365 jours",
                                    
                                    fluidRow(
                                      
                                      box(strong("Données lissées sur 365 jours"),
                                          width = 6,
                                          checkboxInput(inputId = "Teau_minMM365", label = "Températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_moyMM365", label = "Températures moyennes", value=T),
                                          checkboxInput(inputId = "Teau_maxMM365", label = "Températures maximales", value=F)
                                          
                                      ), 
                                      box(strong("Tendances"),
                                          width = 6,height = 170,
                                          checkboxInput(inputId = "Teau_minreg365", label = "Tendance des températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_maxreg365", label = "Tendance des températures maximales", value=F)
                                          
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Touques T1")),
                                        dygraphOutput("Sonde825MM365")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Touques T3")),
                                        dygraphOutput("Sonde827MM365")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Touques T4")),
                                        dygraphOutput("Sonde828MM365")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Touques T6")),
                                        dygraphOutput("Sonde830MM365")
                                      )
                                    ) # End fluidRow
                           ) # End tabPanel
                           
                           
                           
                         )), # End tabPanelset 
                
                
                tabPanel(strong("Fréquences"),
                         fluidRow(
                           
                           h3("Graphique des fréquences et seuils thermiques"),
                           box(
                             width = 7,
                             selectInput(inputId = 'EspeceT', label = 'Choisir une espèce',
                                         choices = c(
                                           "Aucune"="limiteR",
                                           "Truite" = "limiteTruite",
                                           "Brochet" = "limiteBrochet"
                                         )
                             )
                             ,
                             sliderInput("AnHistT",  min=min(db2$An), max = max(db2$An),label="Choisir une période",
                                         value= c(min(db2$An),max(db2$An)))
                             
                           ),
                           box(width=6,
                               h3(strong("Touques T1")),
                               plotlyOutput("hist825")),
                           box(width=6,
                               h3(strong("Touques T3")),
                               plotlyOutput("hist827")),
                           box(width=6,
                               h3(strong("Touques T4")),
                               plotlyOutput("hist828")),
                           box(width=6,
                               h3(strong("Touques T6")),
                               plotlyOutput("hist830"))
                           
                         ),
                         h3("Tableau récapitulatif des seuils thermiques"),
                         DT::dataTableOutput("TableTouquesFreq")
                ),
                tabPanel(strong("Corrélations"),
                         fluidRow(
                           box(width=6,
                               h3(strong("Touques T1")),
                               
                               plotlyOutput("Reg825"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("825")],3)," + ", 
                                        round(dataRegCoeff[2,c("825")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("825")],3)))
                               
                           ),
                           
                           box(width=6,
                               h3(strong("Touques T3")),
                               
                               plotlyOutput("Reg827"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("827")],3)," + ", 
                                        round(dataRegCoeff[2,c("827")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("827")],3)))
                               
                           ),
                           
                           box(width=6,
                               h3(strong("Touques T4")),
                               
                               plotlyOutput("Reg828"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("828")],3)," + ", 
                                        round(dataRegCoeff[2,c("828")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("828")],3)))
                               
                           ),
                           box(width=6,
                               h3(strong("Touques T6")),
                               
                               plotlyOutput("Reg830"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("830")],3)," + ", 
                                        round(dataRegCoeff[2,c("830")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("830")],3)))
                               
                           )
                         )
                )
              )  # End tabsetPanel
              
              
      ), # End tabItem 1
      # -------------------------------------------------- #
      
      
      ###########################
      # sous-Onglet Orne
      ###########################
      
      # -------------------------------------------------- #
      tabItem(tabName = "sub_menu_orne",
              # orne
              
              h2("Analyse des températures de l'Orne"),
              
              tabsetPanel(
                tabPanel(strong("Description"),
                         fluidRow(
                           
                           column(width = 2,
                                  
                                  
                                  img(src="Orne.png")),
                           
                           column( width = 6,
                                   
                                   h3(strong("L'Orne")),
                                   br(),
                                   status = "primary",solidHeader = TRUE,
                                   
                                   p("Taille du fleuve : 169 km") ,    
                                   p("Surface du bassin versant associcé : 1001 km² (partie amont)"), 
                                   p("Prend source à : Aunou-sur-Orne"),   
                                   p("Se jette en : Mer de la Manche (Ouistream)")
                                   # p("Nature principale des couches sédimentaires : crayeuse"),
                                   
                           ),# EndColumn
                           
                           
                           
                           column( width = 4, height=200,
                                   h4(strong("Localisation")),
                                   leafletOutput("map_Orne",height = 200) 
                           ),
                           column( width = 10,
                                   h4("Statistiques Descriptives"),
                                   br(),
                                   DT::dataTableOutput("StatsDescOrne")
                           )
                           
                           
                           
                         )
                         
                ), # End tabPanel Description
                
                tabPanel(strong("Températures"),
                         tabsetPanel(    
                           tabPanel("Températures moyennes et lissées sur 7 jours",
                                    fluidRow(
                                      box(strong("Données aggrégées à la journée"),
                                          width = 4,
                                          checkboxInput(inputId = "Teau_minOrne", label = "Températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_moyOrne", label = "Températures moyennes", value=T),
                                          checkboxInput(inputId = "Teau_maxOrne", label = "Températures maximales", value=F)
                                      ),
                                      box(strong("Données lissées sur 7 jours"),
                                          width = 4,
                                          checkboxInput(inputId = "Teau_minMM7Orne", label = "Températures minimales ", value=F),
                                          checkboxInput(inputId = "Teau_moyMM7Orne", label = "Températures moyennes  ", value=F),
                                          checkboxInput(inputId = "Teau_maxMM7Orne", label = "Températures maximales ", value=F)
                                      ),
                                      box
                                      (width = 4,
                                        strong("Seuils de températures limites"),
                                        radioButtons("preferendum_thOrne", "",
                                                     c("Truite" = "truite",
                                                       "Brochet" = "brochet",
                                                       "Pas de seuil" = "rien"), 
                                                     selected = "rien")),
                                      
                                      box(width=6,
                                          h3(strong("Orne T1")),
                                          dygraphOutput("Sonde817MM7")
                                      ),       
                                      
                                      box(
                                        width=6,
                                        h3(strong("Orne T2")),
                                        dygraphOutput("Sonde819MM7")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Orne T3")),
                                        dygraphOutput("Sonde818MM7")
                                      )
                                      
                                      
                                    )# End fluidRow
                           ),
                           #) , # End tabsetPanel
                           tabPanel("Températures lissées sur 30 jours",
                                    
                                    fluidRow(
                                      
                                      box(strong("Données lissées sur 30 jours"),
                                          width = 6,
                                          checkboxInput(inputId = "Teau_minMM30Orne", label = "Températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_moyMM30Orne", label = "Températures moyennes", value=T),
                                          checkboxInput(inputId = "Teau_maxMM30Orne", label = "Températures maximales", value=F)
                                          
                                      ), 
                                      
                                      box(strong("Tendances"),
                                          width = 6,height = 170,
                                          checkboxInput(inputId = "Teau_minreg30Orne", label = "Tendance des températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_maxreg30Orne", label = "Tendance des températures maximales", value=F)
                                          
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Orne T1")),
                                        dygraphOutput("Sonde817MM30")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Orne T2")),
                                        dygraphOutput("Sonde819MM30")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Orne T3")),
                                        dygraphOutput("Sonde818MM30")
                                      ),
                                      
                                      
                                      br(),br()
                                    ),
                                    fluidRow(
                                      
                                      h4("Moyennes annuelles des moyennes mensuelles des MM30"),
                                      DT::dataTableOutput("db_Orne_stats_MM30_An"),
                                      br(),br(),
                                      h4("Moyennes mensuelles des MM30"),
                                      DT::dataTableOutput("db_Orne_stats_MM30_mois")
                                      
                                    )# end fluid
                           ),# end tabPanel
                           tabPanel("Températures lissées sur 365 jours",
                                    
                                    fluidRow(
                                      
                                      box(strong("Données lissées sur 365 jours"),
                                          width = 6,
                                          checkboxInput(inputId = "Teau_minMM365Orne", label = "Températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_moyMM365Orne", label = "Températures moyennes", value=T),
                                          checkboxInput(inputId = "Teau_maxMM365Orne", label = "Températures maximales", value=F)
                                          
                                      ), 
                                      box(strong("Tendances"),
                                          width = 6,height = 170,
                                          checkboxInput(inputId = "Teau_minreg365Orne", label = "Tendance des températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_maxreg365Orne", label = "Tendance des températures maximales", value=F)
                                          
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Orne T1")),
                                        dygraphOutput("Sonde817MM365")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Orne T2")),
                                        dygraphOutput("Sonde819MM365")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Orne T3")),
                                        dygraphOutput("Sonde818MM365")
                                      )
                                    ) # End fluidRow
                           ) # End tabPanel
                           
                         )),
                tabPanel(strong("Fréquences"),
                         fluidRow(
                           
                           h3("Graphique des fréquences et seuils thermiques"),
                           box(
                             width = 7,
                             selectInput(inputId = 'EspeceOr', label = 'Choisir une espèce',
                                         choices = c(
                                           "Aucune"="limiteR",
                                           "Truite" = "limiteTruite",
                                           "Brochet" = "limiteBrochet"
                                         )
                             )
                             ,
                             sliderInput("AnHistOr",  min=min(db2$An), max = max(db2$An),label="Choisir une période",
                                         value= c(min(db2$An),max(db2$An)))
                             
                           ),
                           box(width=6,
                               h3(strong("Orne T1")),
                               plotlyOutput("hist817")),
                           box(width=6,
                               h3(strong("Orne T2")),
                               plotlyOutput("hist819")),
                           box(width=6,
                               h3(strong("Orne T3")),
                               plotlyOutput("hist818"))
                           
                         ),
                         h3("Tableau récapitulatif des seuils thermiques"),
                         DT::dataTableOutput("TableOrneFreq")
                ),
                tabPanel(strong("Corrélations"),
                         fluidRow(
                           box(width=6,
                               h3(strong("Orne T1")),
                               
                               plotlyOutput("Reg817"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("817")],3)," + ", 
                                        round(dataRegCoeff[2,c("817")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("817")],3)))
                               
                           ),
                           
                           box(width=6,
                               h3(strong("Orne T2")),
                               
                               plotlyOutput("Reg819"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("819")],3)," + ", 
                                        round(dataRegCoeff[2,c("819")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("819")],3)))
                               
                           ),
                           
                           box(width=6,
                               h3(strong("Orne T3")),
                               
                               plotlyOutput("Reg818"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("818")],3)," + ", 
                                        round(dataRegCoeff[2,c("818")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("818")],3)))
                               
                           )
                         )
                )
                
                
                
                
              )), # End tabItem 2
      # -------------------------------------------------- #
      
      ###########################
      # sous-Onglet Odon
      ###########################
      tabItem(tabName = "sub_menu_odon",
              # Odon
              
              h2("Analyse des températures de la Odon"),
              
              tabsetPanel(
                tabPanel(strong("Description"),
                         fluidRow(
                           
                           # column(width = 2,
                           #        
                           #        
                           #        img(src="Odon.png")),
                           
                           column( width = 6,
                                   
                                   h3(strong("La Odon")),
                                   br(),
                                   status = "primary",solidHeader = TRUE,
                                   
                                   p("Taille de la rivière : 47km (Affluent du fleuve de l'Orne)") ,    
                                   p("Localisation de la confluence : Caen") , 
                                   p("Surface du bassin versant associcé : 216 km²"), 
                                   p("Prend source à : Ondefontaine"),   
                                   p("Nature principale des couches sédimentaires : granitique"),
                                   
                           ),# EndColumn
                           
                           
                           
                           column( width = 4, height=200,
                                   h4(strong("Localisation")),
                                   leafletOutput("map_Odon",height = 200) 
                           ),
                           column( width = 10,
                                   h4("Statistiques Descriptives"),
                                   br(),
                                   DT::dataTableOutput("StatsDescOdon")
                           )
                           
                           
                           
                         )
                         
                ), # End tabPanel Description
                
                tabPanel(strong("Températures"),
                         tabsetPanel(    
                           tabPanel("Températures moyennes et lissées sur 7 jours",
                                    fluidRow(
                                      box(strong("Données aggrégées à la journée"),
                                          width = 4,
                                          checkboxInput(inputId = "Teau_minOdon", label = "Températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_moyOdon", label = "Températures moyennes", value=T),
                                          checkboxInput(inputId = "Teau_maxOdon", label = "Températures maximales", value=F)
                                      ),
                                      box(strong("Données lissées sur 7 jours"),
                                          width = 4,
                                          checkboxInput(inputId = "Teau_minMM7Odon", label = "Températures minimales ", value=F),
                                          checkboxInput(inputId = "Teau_moyMM7Odon", label = "Températures moyennes  ", value=F),
                                          checkboxInput(inputId = "Teau_maxMM7Odon", label = "Températures maximales ", value=F)
                                      ),
                                      box
                                      (width = 4,
                                        strong("Seuils de températures limites"),
                                        radioButtons("preferendum_thOdon", "",
                                                     c("Truite" = "truite",
                                                       "Brochet" = "brochet",
                                                       "Pas de seuil" = "rien"), 
                                                     selected = "rien")),
                                      # box( width = 3,
                                      #      checkboxInput(inputId = "LimiteTruite", label = "Preferendum thermiques", value=F)
                                      # ),
                                      
                                      
                                      box(width=6,
                                          h3(strong("Odon T1")),
                                          dygraphOutput("Sonde812MM7")
                                      ),       
                                      
                                      box(
                                        width=6,
                                        h3(strong("Odon T2")),
                                        dygraphOutput("Sonde813MM7")
                                      ),
                                      # 
                                      # box(
                                      #     width=6,
                                      #     h3(strong("Odon T3")),
                                      #     dygraphOutput("Sonde814MM7")
                                      # ),
                                      # 
                                      box(
                                        width=6,
                                        h3(strong("Odon T4")),
                                        dygraphOutput("Sonde815MM7")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Odon T5")),
                                        dygraphOutput("Sonde816MM7")
                                      )
                                      
                                      
                                    )# End fluidRow
                           ), # End tabPanel 
                           
                           
                           
                           
                           tabPanel("Températures lissées sur 30 jours",
                                    
                                    fluidRow(
                                      
                                      box(strong("Données lissées sur 30 jours"),
                                          width = 6,
                                          checkboxInput(inputId = "Teau_minMM30Odon", label = "Températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_moyMM30Odon", label = "Températures moyennes", value=T),
                                          checkboxInput(inputId = "Teau_maxMM30Odon", label = "Températures maximales", value=F)
                                          
                                      ), 
                                      
                                      box(strong("Tendances"),
                                          width = 6,height = 170,
                                          checkboxInput(inputId = "Teau_minreg30Odon", label = "Tendance des températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_maxreg30Odon", label = "Tendance des températures maximales", value=F)
                                          
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Odon T1")),
                                        dygraphOutput("Sonde812MM30")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Odon T2")),
                                        dygraphOutput("Sonde813MM30")
                                      ),
                                      # 
                                      # box(
                                      #     width=6,
                                      #     h3(strong("Odon T3")),
                                      #     dygraphOutput("Sonde814MM30")
                                      # ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Odon T4")),
                                        dygraphOutput("Sonde815MM30")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Odon T5")),
                                        dygraphOutput("Sonde816MM30")
                                      ),
                                      br(),br()
                                    ),
                                    fluidRow(
                                      h4("Moyennes annuelles des moyennes mensuelles des MM30"),
                                      DT::dataTableOutput("db_Odon_stats_MM30_An"),
                                      br(),br(),
                                      h4("Moyennes mensuelles des MM30"),
                                      DT::dataTableOutput("db_Odon_stats_MM30_mois")
                                      
                                    )# end fluid
                           ),# end tabPanel
                           tabPanel("Températures lissées sur 365 jours",
                                    
                                    fluidRow(
                                      
                                      box(strong("Données lissées sur 365 jours"),
                                          width = 6,
                                          checkboxInput(inputId = "Teau_minMM365Odon", label = "Températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_moyMM365Odon", label = "Températures moyennes", value=T),
                                          checkboxInput(inputId = "Teau_maxMM365Odon", label = "Températures maximales", value=F)
                                          
                                      ), 
                                      box(strong("Tendances"),
                                          width = 6,height = 170,
                                          checkboxInput(inputId = "Teau_minreg365Odon", label = "Tendance des températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_maxreg365Odon", label = "Tendance des températures maximales", value=F)
                                          
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Odon T1")),
                                        dygraphOutput("Sonde812MM365")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Odon T2")),
                                        dygraphOutput("Sonde813MM365")
                                      ),
                                      # box(
                                      #     width=6,
                                      #     h3(strong("Odon T3")),
                                      #     dygraphOutput("Sonde814MM365")
                                      # ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Odon T4")),
                                        dygraphOutput("Sonde815MM365")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Odon T5")),
                                        dygraphOutput("Sonde816MM365")
                                      )
                                    ) # End fluidRow
                           ) # End tabPanel
                           
                           
                           
                         )), # End tabPanelset 
                
                
                tabPanel(strong("Fréquences"),
                         fluidRow(
                           
                           h3("Graphique des fréquences et seuils thermiques"),
                           box(
                             width = 7,
                             selectInput(inputId = 'EspeceOd', label = 'Choisir une espèce',
                                         choices = c(
                                           "Aucune"="limiteR",
                                           "Truite" = "limiteTruite",
                                           "Brochet" = "limiteBrochet"
                                         )
                             )
                             ,
                             sliderInput("AnHistOd",  min=min(db2$An), max = max(db2$An),label="Choisir une période",
                                         value= c(min(db2$An),max(db2$An)))
                             
                           ),
                           box(width=6,
                               h3(strong("Odon T1")),
                               plotlyOutput("hist812")),
                           box(width=6,
                               h3(strong("Odon T2")),
                               plotlyOutput("hist813")),
                           # box(width=6,
                           #     h3(strong("Odon T3")),
                           #     plotlyOutput("hist814")),
                           box(width=6,
                               h3(strong("Odon T4")),
                               plotlyOutput("hist815")),
                           box(width=6,
                               h3(strong("Odon T5")),
                               plotlyOutput("hist816"))
                           
                         ),
                         h3("Tableau récapitulatif des seuils thermiques"),
                         DT::dataTableOutput("TableOdonFreq")
                ),
                tabPanel(strong("Corrélations"),
                         fluidRow(
                           box(width=6,
                               h3(strong("Odon T1")),
                               
                               plotlyOutput("Reg812"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("812")],3)," + ",
                                        round(dataRegCoeff[2,c("812")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("812")],3)))
                               
                           ),
                           
                           box(width=6,
                               h3(strong("Odon T2")),
                               
                               plotlyOutput("Reg813"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("813")],3)," + ",
                                        round(dataRegCoeff[2,c("813")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("813")],3)))
                               
                           ),
                           
                           # box(width=6,
                           #     h3(strong("Odon T3")),
                           #     
                           #     plotlyOutput("Reg814")
                           #     
                           #     # h5(paste("f(x) = ",
                           #     #          round(dataRegCoeff[1,c("814")],3)," + ", 
                           #     #          round(dataRegCoeff[2,c("814")],3),"x"
                           #     # ), style = "color:red"),
                           #     # h5(paste("R²adj = ",
                           #     #          round(dataRegCoeff[3,c("814")],3)))
                           #     # 
                           # ),
                           box(width=6,
                               h3(strong("Odon T4")),
                               
                               plotlyOutput("Reg815"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("815")],3)," + ",
                                        round(dataRegCoeff[2,c("815")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("815")],3)))
                               
                           ),
                           box(width=6,
                               h3(strong("Odon T5")),
                               
                               plotlyOutput("Reg816"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("816")],3)," + ",
                                        round(dataRegCoeff[2,c("816")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("816")],3)))
                               
                           )
                         )
                )
              )  # End tabsetPanel
              
              
      ), # End tabItem 3
      # -------------------------------------------------- #
      
      ###########################
      # sous-Onglet Selune
      ###########################
      
      # -------------------------------------------------- #
      tabItem(tabName = "sub_menu_selune",
              # Selune
              
              h2("Analyse des températures de la Selune"),
              
              tabsetPanel(
                tabPanel(strong("Description"),
                         fluidRow(
                           
                           column(width = 2,
                                  
                                  img(src="Selune.png")),
                           
                           column( width = 6,
                                   
                                   h3(strong("La Selune")),
                                   br(),
                                   status = "primary",solidHeader = TRUE,
                                   
                                   p("Taille du fleuve : 84 km") ,    
                                   p("Surface du bassin versant associcé : 1038 km²"), 
                                   p("Prend source à : La Luardière"),   
                                   p("Se jette en : Baie du Mont-Saint-Michel")
                                   # p("Nature principale des couches sédimentaires : crayeuse"),
                           ),# EndColumn
                           
                           
                           
                           column( width = 4, height=200,
                                   h4(strong("Localisation")),
                                   leafletOutput("map_Selune",height = 200) 
                           ),
                           column( width = 10,
                                   h4("Statistiques Descriptives"),
                                   br(),
                                   DT::dataTableOutput("StatsDescSelune")
                           )
                           
                           
                           
                         )
                         
                ), # End tabPanel Description
                
                tabPanel(strong("Températures"),
                         tabsetPanel(    
                           tabPanel("Températures moyennes et lissées sur 7 jours",
                                    fluidRow(
                                      box(strong("Données aggrégées à la journée"),
                                          width = 4,
                                          checkboxInput(inputId = "Teau_minSelune", label = "Températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_moySelune", label = "Températures moyennes", value=T),
                                          checkboxInput(inputId = "Teau_maxSelune", label = "Températures maximales", value=F)
                                      ),
                                      box(strong("Données lissées sur 7 jours"),
                                          width = 4,
                                          checkboxInput(inputId = "Teau_minMM7Selune", label = "Températures minimales ", value=F),
                                          checkboxInput(inputId = "Teau_moyMM7Selune", label = "Températures moyennes  ", value=F),
                                          checkboxInput(inputId = "Teau_maxMM7Selune", label = "Températures maximales ", value=F)
                                      ),
                                      box
                                      (width = 4,
                                        strong("Seuils de températures limites"),
                                        radioButtons("preferendum_thSelune", "",
                                                     c("Truite" = "truite",
                                                       "Brochet" = "brochet",
                                                       "Pas de seuil" = "rien"), 
                                                     selected = "rien")),
                                      # box( width = 3,
                                      #      checkboxInput(inputId = "LimiteTruite", label = "Preferendum thermiques", value=F)
                                      # ),
                                      
                                      
                                      box(width=6,
                                          h3(strong("Selune T1")),
                                          dygraphOutput("Sonde824MM7")
                                      ),       
                                      
                                      box(
                                        width=6,
                                        h3(strong("Selune T2")),
                                        dygraphOutput("Sonde821MM7")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Selune T3")),
                                        dygraphOutput("Sonde822MM7")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Selune T4")),
                                        dygraphOutput("Sonde820MM7")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Selune T5")),
                                        dygraphOutput("Sonde823MM7")
                                      )
                                      
                                      
                                    )# End fluidRow
                           ), # End tabPanel 
                           
                           
                           
                           
                           tabPanel("Températures lissées sur 30 jours",
                                    
                                    fluidRow(
                                      
                                      box(strong("Données lissées sur 30 jours"),
                                          width = 6,
                                          checkboxInput(inputId = "Teau_minMM30Selune", label = "Températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_moyMM30Selune", label = "Températures moyennes", value=T),
                                          checkboxInput(inputId = "Teau_maxMM30Selune", label = "Températures maximales", value=F)
                                          
                                      ), 
                                      
                                      box(strong("Tendances"),
                                          width = 6,height = 170,
                                          checkboxInput(inputId = "Teau_minreg30Selune", label = "Tendance des températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_maxreg30Selune", label = "Tendance des températures maximales", value=F)
                                          
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Selune T1")),
                                        dygraphOutput("Sonde824MM30")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Selune T2")),
                                        dygraphOutput("Sonde821MM30")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Selune T3")),
                                        dygraphOutput("Sonde822MM30")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Selune T4")),
                                        dygraphOutput("Sonde820MM30")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Selune T5")),
                                        dygraphOutput("Sonde823MM30")
                                      ),
                                      br(),br()
                                    ),
                                    fluidRow(
                                      h4("Moyennes annuelles des moyennes mensuelles des MM30"),
                                      DT::dataTableOutput("db_Selune_stats_MM30_An"),
                                      br(),br(),
                                      h4("Moyennes mensuelles des MM30"),
                                      DT::dataTableOutput("db_Selune_stats_MM30_mois")
                                      
                                    )# end fluid
                           ),# end tabPanel
                           tabPanel("Températures lissées sur 365 jours",
                                    
                                    fluidRow(
                                      
                                      box(strong("Données lissées sur 365 jours"),
                                          width = 6,
                                          checkboxInput(inputId = "Teau_minMM365Selune", label = "Températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_moyMM365Selune", label = "Températures moyennes", value=T),
                                          checkboxInput(inputId = "Teau_maxMM365Selune", label = "Températures maximales", value=F)
                                          
                                      ), 
                                      box(strong("Tendances"),
                                          width = 6,height = 170,
                                          checkboxInput(inputId = "Teau_minreg365Selune", label = "Tendance des températures minimales", value=F),
                                          checkboxInput(inputId = "Teau_maxreg365Selune", label = "Tendance des températures maximales", value=F)
                                          
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Selune T1")),
                                        dygraphOutput("Sonde824MM365")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Selune T2")),
                                        dygraphOutput("Sonde821MM365")
                                      ),
                                      box(
                                        width=6,
                                        h3(strong("Selune T3")),
                                        dygraphOutput("Sonde822MM365")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Selune T4")),
                                        dygraphOutput("Sonde820MM365")
                                      ),
                                      
                                      box(
                                        width=6,
                                        h3(strong("Selune T5")),
                                        dygraphOutput("Sonde823MM365")
                                      )
                                    ) # End fluidRow
                           ) # End tabPanel
                           
                           
                           
                         )), # End tabPanelset 
                
                
                tabPanel(strong("Fréquences"),
                         fluidRow(
                           
                           h3("Graphique des fréquences et seuils thermiques"),
                           box(
                             width = 7,
                             selectInput(inputId = 'EspeceSel', label = 'Choisir une espèce',
                                         choices = c(
                                           "Aucune"="limiteR",
                                           "Truite" = "limiteTruite",
                                           "Brochet" = "limiteBrochet"
                                         )
                             )
                             ,
                             sliderInput("AnHistSel",  min=min(db2$An), max = max(db2$An),label="Choisir une période",
                                         value= c(min(db2$An),max(db2$An)))
                             
                           ),
                           box(width=6,
                               h3(strong("Selune T1")),
                               plotlyOutput("hist824")),
                           box(width=6,
                               h3(strong("Selune T2")),
                               plotlyOutput("hist821")),
                           box(width=6,
                               h3(strong("Selune T3")),
                               plotlyOutput("hist822")),
                           box(width=6,
                               h3(strong("Selune T4")),
                               plotlyOutput("hist820")),
                           box(width=6,
                               h3(strong("Selune T5")),
                               plotlyOutput("hist823"))
                           
                         ),
                         h3("Tableau récapitulatif des seuils thermiques"),
                         DT::dataTableOutput("TableSeluneFreq")
                ),
                tabPanel(strong("Corrélations"),
                         fluidRow(
                           box(width=6,
                               h3(strong("Selune T1")),
                               
                               plotlyOutput("Reg824"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("824")],3)," + ",
                                        round(dataRegCoeff[2,c("824")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("824")],3)))
                               
                           ),
                           
                           box(width=6,
                               h3(strong("Selune T2")),
                               
                               plotlyOutput("Reg821"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("821")],3)," + ",
                                        round(dataRegCoeff[2,c("821")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("821")],3)))
                               
                           ),
                           
                           box(width=6,
                               h3(strong("Selune T3")),
                               
                               plotlyOutput("Reg822"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("822")],3)," + ",
                                        round(dataRegCoeff[2,c("822")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("822")],3)))
                               
                           ),
                           box(width=6,
                               h3(strong("Selune T4")),
                               
                               plotlyOutput("Reg820"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("820")],3)," + ",
                                        round(dataRegCoeff[2,c("820")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("820")],3)))
                               
                           ),
                           box(width=6,
                               h3(strong("Selune T5")),
                               
                               plotlyOutput("Reg823"),
                               
                               h5(paste("f(x) = ",
                                        round(dataRegCoeff[1,c("823")],3)," + ",
                                        round(dataRegCoeff[2,c("823")],3),"x"
                               ), style = "color:red"),
                               h5(paste("R²adj = ",
                                        round(dataRegCoeff[3,c("823")],3)))
                               
                           )
                         )
                )
              )  # End tabsetPanel
              
              
      ), # End tabItem 4
      # -------------------------------------------------- #
      
      
      
      ####################################################
      # Quatrième Menu : Sondes
      ####################################################
      
      # -------------------------------------------------- #
      tabItem(tabName = "sub_menu_sondes_synthese",
              # fiche synthese par sonde
              
              
              # En-tête
              # ---------------------------------------- #
              #h2("Analyse des sondes"),
              
              # fluidRow(
              #   selectInput("choix_sondes",
              #               label="Choisir une sonde",choices=list("Monne (s104)"="104", "Vie (s105)"="105", "Taute (s108)"="108", "Barge (s109)"="109", "Grande Vallée (s300)"="300", 
              #                                                      "Souleuvre (s762)"="762", "See Rousse (s763)"="763", "Egrenne (s764)"="764", "Durance (s765)"="765", "See (s766)"="766",
              #                                                      "Berence (s768)"="768", "Glanon (s769)"="769", "Vingt Bec (s771)"="771", "Fontaine au Héron (s811)"="811", "Odon T1 (s812)"="812",
              #                                                      "Odon T2 (s813)"="813", "Odon T4 (s815)"="815", "Odon T5 (s816)"="816", "Orne T1 (s817)"="817", "Orne T3 (s818)"="818",
              #                                                      "Orne T2 (s819)"="819", "Selune T4 (s820)"="820", "Selune T2 (s821)"="821", "Selune T3 (s822)"="822", "Selune T5 (s823)"="823",
              #                                                      "Selune T1 (s824)"="824", "Touques T1 (s825)"="825", "Touques T3 (s827)"="827", "Touques T4 (s828)"="828", "Touques T6 (s830)"="830"),
              #               selected="817"),
              #   #h2("Sondes n°817 : Orne (T1)")
              #   textOutput("id_lab_txt")
              # ),
              selectInput("choix_sondes",
                          label="Choisir une sonde",choices=list("Monne (s104)"="104", "Vie (s105)"="105", "Taute (s108)"="108", "Barge (s109)"="109", "Grande Vallée (s300)"="300", 
                                                                 "Souleuvre (s762)"="762", "See Rousse (s763)"="763", "Egrenne (s764)"="764", "Durance (s765)"="765", "See (s766)"="766",
                                                                 "Berence (s768)"="768", "Glanon (s769)"="769", "Vingt Bec (s771)"="771", "Fontaine au Héron (s811)"="811", "Odon T1 (s812)"="812",
                                                                 "Odon T2 (s813)"="813", "Odon T4 (s815)"="815", "Odon T5 (s816)"="816", "Orne T1 (s817)"="817", "Orne T3 (s818)"="818",
                                                                 "Orne T2 (s819)"="819", "Selune T4 (s820)"="820", "Selune T2 (s821)"="821", "Selune T3 (s822)"="822", "Selune T5 (s823)"="823",
                                                                 "Selune T1 (s824)"="824", "Touques T1 (s825)"="825", "Touques T3 (s827)"="827", "Touques T4 (s828)"="828", "Touques T6 (s830)"="830"),
                          selected="817"),
              #h2("Sondes n°817 : Orne (T1)")
              textOutput("id_lab_txt"),
              # ---------------------------------------- #
              
              
              # deuxième fluidRow
              # ---------------------------------------- #
              fluidRow(
                column(
                  width = 5,
                  h3("Description"),
                  textOutput("debit_txt"),
                  textOutput("dist_source_txt"),
                  textOutput("long_lat_txt"),
                  textOutput("deb_txt"),
                  textOutput("fin_txt"),
                  textOutput("nb_obs_txt")
                  
                ),
                
                column(
                  width = 7,
                  h3("Quelques statistiques"),
                  tableOutput(outputId = "tableau_stats_sonde_synthese")
                )
              ),
              # ---------------------------------------- #
              
              
              # troisième fluidRow
              # ---------------------------------------- #
              fluidRow(
                column(
                  width = 5,
                  h3("Emplacement"),
                  leafletOutput("sonde_synthese_map", height = 285),
                  actionLink(inputId = "return_to_sub_menu_map_sonde", label = "Voir la carte des sondes")
                  
                ),
                
                column(
                  width = 7,
                  h3("Représentation de la série"),
                  dygraphOutput(outputId = "graphe_sonde_synthese", width = "95%", height = 300)
                )
              ),
              # ---------------------------------------- #
              
              
              
              # quatrième fluidRow
              # ---------------------------------------- #
              fluidRow(
                column(
                  width = 5,
                  h3("Fréquence des températures de la série bi-horaire"),
                  plotlyOutput("freq_sonde_synthese")
                  
                ),
                
                column(
                  width = 7,
                  h3("Périodogramme"),
                  plotOutput("perio_sonde_synthese", width = "95%")
                )
              )
              # ---------------------------------------- #
              
              
              
              
              
              
      ), # End tabItem 5
      # -------------------------------------------------- #
      
      
      
      
      # debut tabItem 6
      # -------------------------------------------------- #
      tabItem(tabName = "sub_menu_comparaison",
              # compraison entre les sondes
              
              
              # ---------------------------------------- #
              fluidRow(
                column(width = 6,
                       selectizeInput("choix_comparaison",
                                      label="Choisir des sondes (maximum de 5)",choices=list("Monne (s104)"="104", "Vie (s105)"="105", "Taute (s108)"="108", "Barge (s109)"="109", "Grande Vallée (s300)"="300", 
                                                                                             "Souleuvre (s762)"="762", "See Rousse (s763)"="763", "Egrenne (s764)"="764", "Durance (s765)"="765", "See (s766)"="766",
                                                                                             "Berence (s768)"="768", "Glanon (s769)"="769", "Vingt Bec (s771)"="771", "Fontaine au Héron (s811)"="811", "Odon T1 (s812)"="812",
                                                                                             "Odon T2 (s813)"="813", "Odon T4 (s815)"="815", "Odon T5 (s816)"="816", "Orne T1 (s817)"="817", "Orne T3 (s818)"="818",
                                                                                             "Orne T2 (s819)"="819", "Selune T4 (s820)"="820", "Selune T2 (s821)"="821", "Selune T3 (s822)"="822", "Selune T5 (s823)"="823",
                                                                                             "Selune T1 (s824)"="824", "Touques T1 (s825)"="825", "Touques T3 (s827)"="827", "Touques T4 (s828)"="828", "Touques T6 (s830)"="830"),
                                      multiple=T,
                                      selected=c("817", "818", "819"),
                                      options = list(maxItems=5)
                       )
                       
                       
                ),
                column(width = 6)
              ),
              # ---------------------------------------- #
              
              
              # ---------------------------------------- #
              fluidRow(
                column(width = 6,
                       h3("Comparaison des températures relevées"),
                       dygraphOutput("comp_bih")
                ),
                column(width = 6,
                       h3("Comparaison des températures moyennes journalières"),
                       dygraphOutput("comp_Teau")
                )
              ),
              # ---------------------------------------- #
              
              
              # ---------------------------------------- #
              fluidRow(
                column(width = 6,
                       h3("Comparaison des températures moyennes sur 30 jours"),
                       dygraphOutput("comp_MM30")
                ),
                column(width = 6,
                       h3("Comparaison des températures moyennes sur 365 jours"),
                       dygraphOutput("comp_MM365")
                )
              )
              # ---------------------------------------- #
              
              
              
              
              
      ),# End tabItem 6
      # -------------------------------------------------- #
      
      ####################################################
      # Cinquième  Menu : Analyses de données avancée
      ####################################################
      
      tabItem(tabName = "ODriscoll",
              fluidRow(
                
                h3(strong("")),
                
                plotlyOutput("Odris"),
                h5(paste("f(x) = ",
                         round(regOdris$coefficients[1],3),
                         
                         round(regOdris$coefficients[2],3),
                         "x"
                         
                )
                ),
                
                h5(paste("R²adj = ",
                         round(summary(regOdris)$adj.r.squared,3)))
                
                
                
              )
              
      ),
      
      
      ####################################################
      # Sixième  Menu : Références
      ####################################################
      tabItem(tabName = "Reference"#,
              #includeMarkdown(paste0(path,"/read.md"))
              
      ),
      
      ####################################################
      # Septième  Menu : ACI ACP
      ####################################################
      tabItem(tabName = "aci_acp",
              h1("ACI et ACP"),
              tabsetPanel(
                # ---------------------------------------- #
                tabPanel(
                  "Touques",
                  
                  h2("Analyse en Composantes Indépendantes"),
                  # ------------------------------ #
                  fluidRow(
                    br(),
                    column(
                      width = 4,
                      br(),
                      wellPanel(
                        h3("Menu"),
                        radioButtons("sondes_touques_aci", "Choix de la sonde",
                                     c("Touques T1" = "825",
                                       "Touques T3" = "827",
                                       "Touques T4" = "828",
                                       "Touques T6" = "830"), 
                                     selected = "825"),
                        br(),
                        p(strong("Choix des compsantes")),
                        checkboxInput(inputId = "comp1_touques", label = "Composante 1", value = T),
                        checkboxInput(inputId = "comp2_touques", label = "Composante 2", value = T),
                        checkboxInput(inputId = "comp3_touques", label = "Composante 3", value = T)
                        
                      )
                    ),
                    
                    column(
                      width = 8,
                      #h3("ACI"),
                      dygraphOutput("aci_touques")
                    )
                  ),
                  
                  # ACI diff
                  h2("Analyse en Composantes Indépendantes Diff Teau-Tair"),
                  # ------------------------------ #
                  fluidRow(
                    br(),
                    column(
                      width = 4,
                      br(),
                      wellPanel(
                        h3("Menu"),
                        radioButtons("sondes_touques_aci_dif", "Choix de la sonde",
                                     c("Touques T1" = "825",
                                       "Touques T3" = "827",
                                       "Touques T4" = "828",
                                       "Touques T6" = "830"), 
                                     selected = "825"),
                        br(),
                        p(strong("Choix des compsantes")),
                        checkboxInput(inputId = "comp1_touques_dif", label = "Composante 1", value = T),
                        checkboxInput(inputId = "comp2_touques_dif", label = "Composante 2", value = T),
                        checkboxInput(inputId = "comp3_touques_dif", label = "Composante 3", value = T)
                        
                      )
                    ),
                    
                    column(
                      width = 8,
                      #h3("ACI"),
                      dygraphOutput("aci_touques_dif")
                    )
                  ),
                  
                  h2("Analyse en Composantes Principales"),
                  # ------------------------------ #
                  fluidRow(
                    
                  )
                  
                  
                  
                  
                ),
                # ---------------------------------------- #
                tabPanel(
                  "Orne",
                  
                  h2("Analyse en Composantes Indépendantes"),
                  # ------------------------------ #
                  fluidRow(
                    br(),
                    column(
                      width = 4,
                      br(),
                      wellPanel(
                        h3("Menu"),
                        radioButtons("sondes_orne_aci", "Choix de la sonde",
                                     c("Orne T1" = "817",
                                       "Orne T2" = "819",
                                       "Orne T3" = "818"), 
                                     selected = "817"),
                        br(),
                        p(strong("Choix des compsantes")),
                        checkboxInput(inputId = "comp1_orne", label = "Composante 1", value = T),
                        checkboxInput(inputId = "comp2_orne", label = "Composante 2", value = T),
                        checkboxInput(inputId = "comp3_orne", label = "Composante 3", value = T)
                        
                      )
                    ),
                    
                    column(
                      width = 8,
                      #h3("ACI"),
                      dygraphOutput("aci_orne")
                    )
                  ),
                  
                  h2("Analyse en Composantes Indépendantes Diff Teau-Tair"),
                  # ------------------------------ #
                  fluidRow(
                    br(),
                    column(
                      width = 4,
                      br(),
                      wellPanel(
                        h3("Menu"),
                        radioButtons("sondes_orne_aci_dif", "Choix de la sonde",
                                     c("Orne T1" = "817",
                                       "Orne T2" = "819",
                                       "Orne T3" = "818"), 
                                     selected = "817"),
                        br(),
                        p(strong("Choix des compsantes")),
                        checkboxInput(inputId = "comp1_orne_dif", label = "Composante 1", value = T),
                        checkboxInput(inputId = "comp2_orne_dif", label = "Composante 2", value = T),
                        checkboxInput(inputId = "comp3_orne_dif", label = "Composante 3", value = T)
                        
                      )
                    ),
                    
                    column(
                      width = 8,
                      #h3("ACI"),
                      dygraphOutput("aci_orne_dif")
                    )
                  ),
                  
                  h2("Analyse en Composantes Principales"),
                  # ------------------------------ #
                  fluidRow(
                    
                  )
                  
                ),
                # ---------------------------------------- #
                tabPanel(
                  "Odon",
                  
                  h2("Analyse en Composantes Indépendantes"),
                  # ------------------------------ #
                  fluidRow(
                    br(),
                    column(
                      width = 4,
                      br(),
                      wellPanel(
                        h3("Menu"),
                        radioButtons("sondes_odon_aci", "Choix de la sonde",
                                     c("Odon T1" = "812",
                                       "Odon T2" = "813",
                                       "Odon T4" = "815",
                                       "Odon T5" = "816"), 
                                     selected = "812"),
                        br(),
                        p(strong("Choix des compsantes")),
                        checkboxInput(inputId = "comp1_odon", label = "Composante 1", value = T),
                        checkboxInput(inputId = "comp2_odon", label = "Composante 2", value = T),
                        checkboxInput(inputId = "comp3_odon", label = "Composante 3", value = T)
                        
                      )
                    ),
                    
                    column(
                      width = 8,
                      #h3("ACI"),
                      dygraphOutput("aci_odon")
                    )
                  ),
                  
                  h2("Analyse en Composantes Indépendantes Diff Teau-Tair"),
                  # ------------------------------ #
                  fluidRow(
                    br(),
                    column(
                      width = 4,
                      br(),
                      wellPanel(
                        h3("Menu"),
                        radioButtons("sondes_odon_aci_dif", "Choix de la sonde",
                                     c("Odon T1" = "812",
                                       "Odon T2" = "813",
                                       "Odon T4" = "815",
                                       "Odon T5" = "816"), 
                                     selected = "812"),
                        br(),
                        p(strong("Choix des compsantes")),
                        checkboxInput(inputId = "comp1_odon_dif", label = "Composante 1", value = T),
                        checkboxInput(inputId = "comp2_odon_dif", label = "Composante 2", value = T),
                        checkboxInput(inputId = "comp3_odon_dif", label = "Composante 3", value = T)
                        
                      )
                    ),
                    
                    column(
                      width = 8,
                      #h3("ACI"),
                      dygraphOutput("aci_odon_dif")
                    )
                  ),
                  
                  h2("Analyse en Composantes Principales"),
                  # ------------------------------ #
                  fluidRow(
                    
                  )
                  
                ),
                # ---------------------------------------- #
                tabPanel(
                  "Sélune",
                  
                  h2("Analyse en Composantes Indépendantes"),
                  # ------------------------------ #
                  fluidRow(
                    br(),
                    column(
                      width = 4,
                      br(),
                      wellPanel(
                        h3("Menu"),
                        radioButtons("sondes_selune_aci", "Choix de la sonde",
                                     c("Sélune T1" = "824",
                                       "Sélune T2" = "821",
                                       "Sélune T4" = "820",
                                       "Sélune T5" = "823"), 
                                     selected = "824"),
                        br(),
                        p(strong("Choix des compsantes")),
                        checkboxInput(inputId = "comp1_selune", label = "Composante 1", value = T),
                        checkboxInput(inputId = "comp2_selune", label = "Composante 2", value = T),
                        checkboxInput(inputId = "comp3_selune", label = "Composante 3", value = T)
                        
                      )
                    ),
                    
                    column(
                      width = 8,
                      #h3("ACI"),
                      dygraphOutput("aci_selune")
                    )
                  ),
                  
                  
                  h2("Analyse en Composantes Indépendantes Diff Teau-Tair"),
                  # ------------------------------ #
                  fluidRow(
                    br(),
                    column(
                      width = 4,
                      br(),
                      wellPanel(
                        h3("Menu"),
                        radioButtons("sondes_selune_aci_dif", "Choix de la sonde",
                                     c("Sélune T1" = "824",
                                       "Sélune T2" = "821",
                                       "Sélune T4" = "820",
                                       "Sélune T5" = "823"), 
                                     selected = "824"),
                        br(),
                        p(strong("Choix des compsantes")),
                        checkboxInput(inputId = "comp1_selune_dif", label = "Composante 1", value = T),
                        checkboxInput(inputId = "comp2_selune_dif", label = "Composante 2", value = T),
                        checkboxInput(inputId = "comp3_selune_dif", label = "Composante 3", value = T)
                        
                      )
                    ),
                    
                    column(
                      width = 8,
                      #h3("ACI"),
                      dygraphOutput("aci_selune_dif")
                    )
                  ),
                  
                  
                  
                  h2("Analyse en Composantes Principales"),
                  # ------------------------------ #
                  fluidRow(
                    
                  )
                  
                )
                # ---------------------------------------- #
              )
              
              
      )# Fin tabItem 7
      # ################################################## #  
      
      
      
      
    ) # End tabItems
    # ------------------------------------------------------------ #
    
    
    
  ) # End Body
  
  
  
  
) # End DashboardPage
