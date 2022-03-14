shinyServer(function(input,output,session){

    ##############################################################
    # INTRODUCTION
    ##############################################################
# Variables
    output$Variables= renderTable({Variables})

    ###############
    # Biblio liens
    ###############

    observeEvent(input$bib1, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })

    observeEvent(input$bib2, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })

    observeEvent(input$bib3, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })

    observeEvent(input$bib4, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })

    observeEvent(input$bib5, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })

    observeEvent(input$bib6, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib7, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib8, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib9, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib10, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib11, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib12, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib13, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib14, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })

    observeEvent(input$bib15, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib15bis, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib16, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib17, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib18, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })
    observeEvent(input$bib19, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_biblio")
    })


    # ############################################################ #
    # FIN INTRODUCTION
    # ############################################################ #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    ##############################################################
    # CARTOGRAPHIE
    ##############################################################

    # ------------------------------------------------------------ #
    # map_sondes : carte des sondes
    output$map_sondes <- renderLeaflet({

        leaflet() %>%
            addTiles() %>%

            # marker DREAL
            addAwesomeMarkers(data = db_sonde_synthese,
                              lng=db_sonde_synthese$longitude,lat=db_sonde_synthese$latitude,
                              layerId = db_sonde_synthese$id_sonde, group="DREAL",
                              icon=makeAwesomeIcon(icon='tint', library='glyphicon',
                                                   iconColor = 'white', markerColor = 'blue')) %>%

            # marker OFB
            addAwesomeMarkers(data = SondesOFB, layerId = SondesOFB$Name, group = "OFB",
                              icon = makeAwesomeIcon(icon = 'tint', library = 'glyphicon',
                                                     iconColor = 'white', markerColor = 'gray',
                                                     iconRotate = 10)) %>%


            # grands bassins versants
            addPolygons(data=BV1, weight=3,
                        layerId = paste0("BV1_",1:nrow(BV1)), group = "Bassins Versants",
                        color="#31b94a",
                        highlightOptions = highlightOptions(
                            weight = 5,
                            #color = "#FFF",
                            fillOpacity = 0.5,
                            bringToFront = TRUE
                        )) %>%

            addPolylines(data=coursEau2,group="Cours d'eau",
                         opacity = 1, weight = 2, color = "blue",
                         layerId = coursEau2$Name) %>%


            # Layers control
            addLayersControl(
                #baseGroups = c("OSM (default)", "Toner", "Toner Lite"),
                overlayGroups = c("DREAL", "OFB", "Bassins Versants", "Cours d'eau"),#, "highlight"),
                options = layersControlOptions(collapsed = FALSE)
            ) %>%

            hideGroup("OFB") %>%
            hideGroup("Bassins Versants") %>%
            hideGroup("Cours d'eau") %>%
            hideGroup("Cours d'eau sonde")


    })


    observeEvent(input$link_to_details_sonde, {

        updateSelectInput(
            session=session,
            inputId = "choix_sondes",
            selected = id_sonde_reactive$id_sonde_char
        )

        updateNavbarPage(session=session, inputId = "menu_principal", selected = "sub_menu_sondes_synthese")


    })


    id_sonde_reactive <- reactiveValues(
        id_sonde_char = "",
        cours_eau = "Orne",
        pos = 7,
        sonde_df = as.data.frame(db[db$id_sonde==817,]),
        sonde_label = db_sonde_synthese[which(db_sonde_synthese$id_sonde == "817"),]$label
    )



    output$ID <- renderText({paste0(id_sonde_reactive$sonde_label," : sonde ",id_sonde_reactive$id_sonde_char)})

    output$img_sonde <- renderImage({
        # Read plot2's width and height. These are reactive values, so this
        # expression will re-run whenever these values change.
        width  <- session$clientData$output_img_sonde_width
        #height <- session$clientData$output_img_sonde_height

        # # A temp file to save the output.
        # outfile <- tempfile(fileext='.png')
        #
        # png(outfile, width=width, height=height)
        # hist(rnorm(input$n))
        # dev.off()

        # Return a list containing the filename
        list(src = paste0("www/Sonde",id_sonde_reactive$id_sonde_char,".png"),
             width = width,
             #height = height,
             alt = paste0("Emplacement de la sonde ", id_sonde_reactive$id_sonde_char, ", ", id_sonde_reactive$sonde_label))
    }, deleteFile = FALSE)

    output$temp_sonde <- renderDygraph({
        sonde_data = xts(id_sonde_reactive$sonde_df$Teau, order.by=id_sonde_reactive$sonde_df$t)
        titre = id_sonde_reactive$sonde_label

        dygraph(sonde_data)%>%
            dyAxis("y", label = "Température (°C)", valueRange = c(min(db$Teau)-1, max(db$Teau)+1)) %>%
            dyAxis("x", label = "Temps (bi-horaire)", valueRange = c(min(db$Teau)-1, max(db$Teau)+1)) %>%
            dySeries("V1", label="Température relevée")
        #dyRangeSelector() %>%
        #dyLegend(show = "follow")
    })

    # output$table_sonde <- renderTable({
    #   sonde_table = sonde_df() %>%
    #     group_by(id_sonde) %>%
    #     mutate(Min=min(Teau),
    #            t25 = quantile(Teau,.25),
    #            Mediane = median(Teau),
    #            Moyenne = mean(Teau),
    #            sd = sd(Teau),
    #            t75 = quantile(Teau,.75),
    #            Max = max(Teau))
    #
    #   sonde_table = sonde_table[1, 5:ncol(sonde_table)]
    #   sonde_table
    # })




    observeEvent(input$map_sondes_marker_click, {
        clic = input$map_sondes_marker_click


        if(clic$id != id_sonde_reactive$id_sonde_char){
            if(clic$group == "DREAL"){
                coord_sonde_regular = db_sonde_synthese[which(db_sonde_synthese$id_sonde==id_sonde_reactive$id_sonde_char),]

                id_sonde_reactive$id_sonde_char = clic$id
                id_sonde_reactive$cours_eau = db_temp[which(db_temp$id_sonde == as.numeric(clic$id)),]$cours_eau
                id_sonde_reactive$pos = db_temp[which(db_temp$id_sonde == as.numeric(clic$id)),]$pos
                id_sonde_reactive$sonde_df = as.data.frame(db[db$id_sonde==as.numeric(clic$id),])
                id_sonde_reactive$sonde_label = db_sonde_synthese[which(db_sonde_synthese$id_sonde == clic$id),]$label



                coord_sonde_highlight = db_sonde_synthese[which(db_sonde_synthese$id_sonde==clic$id),]



                proxy <- leafletProxy("map_sondes")



                proxy %>%
                    clearGroup(group = "highlight") %>%
                    addPolylines(data = coursEau2@lines[[id_sonde_reactive$pos]]@Lines[[1]]@coords, group="DREAL",
                                 layerId = "highlight", opacity = 1, weight = 2, color = "cyan") %>%

                    addAwesomeMarkers(data = coord_sonde_highlight,
                                      lng=coord_sonde_highlight$longitude,lat=coord_sonde_highlight$latitude,
                                      layerId = coord_sonde_highlight$id_sonde, group = "DREAL",
                                      icon=makeAwesomeIcon(icon='tint', library='glyphicon',
                                                           iconColor = 'white', markerColor = 'orange')) %>%

                    addAwesomeMarkers(data = coord_sonde_regular,
                                      lng=coord_sonde_regular$longitude,lat=coord_sonde_regular$latitude,
                                      layerId = coord_sonde_regular$id_sonde, group = "DREAL",
                                      icon=makeAwesomeIcon(icon='tint', library='glyphicon',
                                                           iconColor = 'white', markerColor = 'blue'))


                shinyjs::show(id = "panel_info_sondes")



                #showGroup(group="highlight")

                #proxy %>%
            }


        }


    })

    observeEvent(input$closeIP, {
        shinyjs::hide(id = "panel_info_sondes")

        coord_sonde_highlight = db_sonde_synthese[which(db_sonde_synthese$id_sonde==id_sonde_reactive$id_sonde_char),]

        proxy <- leafletProxy("map_sondes")
        proxy %>%
            removeShape("highlight") %>%
            addAwesomeMarkers(data = coord_sonde_highlight,
                              lng=coord_sonde_highlight$longitude,lat=coord_sonde_highlight$latitude,
                              layerId = coord_sonde_highlight$id_sonde, group = "DREAL",
                              icon=makeAwesomeIcon(icon='tint', library='glyphicon',
                                                   iconColor = 'white', markerColor = 'blue'))

        id_sonde_reactive$id_sonde_char = ""

    })


    # ------------------------------------------------------------ #



    # ------------------------------------------------------------ #
    # map_BV : carte des bassins versants
    #
    # output$map_BV <- renderLeaflet({
    #   leaflet() %>%
    #     addTiles() %>%
    #     addPolygons(data=BV1, weight=3, layerId = paste0("BV1_",1:nrow(BV1)), group = "BV1")
    # })
    #
    #
    #
    # # observeEvent(input$BV1, {
    # #   proxy <- leafletProxy("map_BV")
    # #
    # #   proxy %>%
    # #     clearGroup(group="BV1")
    # #
    # #   if(input$BV1){
    # #     proxy %>%
    # #       addPolygons(data=BV1, weight=3, layerId = paste0("BV1_",1:nrow(BV1)), group = "BV1")
    # #   }
    # # })
    #
    # observeEvent(input$BV2, {
    #   proxy <- leafletProxy("map_BV")
    #   proxy %>%
    #     clearGroup(group="BV2")
    #
    #   if(input$BV2){
    #     proxy %>%
    #       addPolygons(data=BV2, weight=2, layerId = paste0("BV2_",1:nrow(BV2)), color = "red", group="BV2")
    #   }
    # })
    #
    # observeEvent(input$BV3, {
    #   proxy <- leafletProxy("map_BV")
    #   proxy %>%
    #     clearGroup(group="BV3")
    #
    #   if(input$BV3){
    #     proxy %>%
    #       addPolygons(data=BV3, weight=1, layerId = paste0("BV3_",1:nrow(BV3)), color = "green", group = "BV3")
    #   }
    # })


    # ------------------------------------------------------------ #




    # ------------------------------------------------------------ #
    # map_eau : carte des cours d'eau
    # output$map_eau <- renderLeaflet({
    #   leaflet() %>%
    #     addTiles() %>%
    #
    #     # marker DREAL
    #     addAwesomeMarkers(data = db_sonde_synthese,
    #                       lng=db_sonde_synthese$longitude,lat=db_sonde_synthese$latitude,
    #                       layerId = db_sonde_synthese$id_sonde, group="DREAL",
    #                       icon=makeAwesomeIcon(icon='tint', library='glyphicon',
    #                                            iconColor = 'white', markerColor = 'blue')) %>%
    #
    #     # marker OFB
    #     addAwesomeMarkers(data = SondesOFB, layerId = SondesOFB$Name, group = "OFB",
    #                       icon = makeAwesomeIcon(icon = 'tint', library = 'glyphicon',
    #                                              iconColor = 'white', markerColor = 'gray',
    #                                              iconRotate = 10)) %>%
    #
    #     # # highlighted marker
    #     # addAwesomeMarkers(data = db_sonde_synthese[which(db_sonde_synthese$id_sonde=="817"),],
    #     #                   lng=db_sonde_synthese[which(db_sonde_synthese$id_sonde=="817"),]$longitude,
    #     #                   lat=db_sonde_synthese[which(db_sonde_synthese$id_sonde=="817"),]$latitude,
    #     #                   group="highlight",
    #     #                   icon=makeAwesomeIcon(icon='tint', library='glyphicon',
    #     #                                        iconColor = 'white', markerColor = 'orange')) %>%
    #
    #     # grands bassins versants
    #     addPolygons(data=BV1, weight=3,
    #                 layerId = paste0("BV1_",1:nrow(BV1)), group = "Bassins Versants",
    #                 color="#31b94a",
    #                 highlightOptions = highlightOptions(
    #                   weight = 5,
    #                   #color = "#FFF",
    #                   fillOpacity = 0.5,
    #                   bringToFront = TRUE
    #                   )) %>%
    #
    #     # cours d'eau
    #     addPolylines(data=ceau,group="Cours d'eau", opacity = 1, weight = 1) %>%
    #
    #     addPolylines(data=coursEau2,group="Cours d'eau sonde",
    #                  opacity = 1, weight = 2, color = "red",
    #                  layerId = coursEau2$Name) %>%
    #
    #     # addPolylines(data=coursEau2@lines[[7]]@Lines[[1]]@coords,
    #     #              group="highlight", opacity = 1, weight = 2, color = "cyan") %>%
    #
    #
    #     # Layers control
    #     addLayersControl(
    #       #baseGroups = c("OSM (default)", "Toner", "Toner Lite"),
    #       overlayGroups = c("DREAL", "OFB", "Bassins Versants", "Cours d'eau", "Cours d'eau sonde"),#, "highlight"),
    #       options = layersControlOptions(collapsed = FALSE)
    #     ) %>%
    #
    #     hideGroup("OFB") %>%
    #     hideGroup("Bassins Versants") %>%
    #     hideGroup("Cours d'eau") %>%
    #     hideGroup("Cours d'eau sonde") #%>%
    #     #hideGroup("highlight")
    #
    #
    #
    #
    #   #removeShape(map, layerId)
    #
    # })


    # map_reactive <- reactiveValues(
    #   id_sonde_char = "817",
    #   cours_eau = "Orne",
    #   pos = 7
    # )




    # observeEvent(input$map_eau_marker_click, {
    #   clic = input$map_eau_marker_click
    #
    #
    #
    #     if(clic$id != map_reactive$id_sonde_char){
    #       if(clic$group == "DREAL"){
    #
    #         coord_sonde_regular = db_sonde_synthese[which(db_sonde_synthese$id_sonde==map_reactive$id_sonde_char),]
    #
    #         map_reactive$id_sonde_char = clic$id
    #         map_reactive$cours_eau = db_temp[which(db_temp$id_sonde == as.numeric(clic$id)),]$cours_eau
    #         map_reactive$pos = db_temp[which(db_temp$id_sonde == as.numeric(clic$id)),]$pos
    #
    #
    #         coord_sonde_highlight = db_sonde_synthese[which(db_sonde_synthese$id_sonde==clic$id),]
    #
    #
    #         proxy <- leafletProxy("map_eau")
    #
    #         proxy %>%
    #           clearGroup(group = "highlight") %>%
    #           addPolylines(data = coursEau2@lines[[map_reactive$pos]]@Lines[[1]]@coords, group="DREAL",
    #                        layerId = "highlight", opacity = 1, weight = 2, color = "cyan") %>%
    #
    #           addAwesomeMarkers(data = coord_sonde_highlight,
    #                             lng=coord_sonde_highlight$longitude,lat=coord_sonde_highlight$latitude,
    #                             layerId = coord_sonde_highlight$id_sonde, group = "DREAL",
    #                             icon=makeAwesomeIcon(icon='tint', library='glyphicon',
    #                                                  iconColor = 'white', markerColor = 'orange')) %>%
    #
    #           addAwesomeMarkers(data = coord_sonde_regular,
    #                             lng=coord_sonde_regular$longitude,lat=coord_sonde_regular$latitude,
    #                             layerId = coord_sonde_regular$id_sonde, group = "DREAL",
    #                             icon=makeAwesomeIcon(icon='tint', library='glyphicon',
    #                                                  iconColor = 'white', markerColor = 'blue'))
    #
    #         #showGroup(group="highlight")
    #
    #         #proxy %>%
    #
    #     }
    #
    #
    #
    #
    #
    #   }
    #
    #
    #
    #
    # })
    # ------------------------------------------------------------ #


    # ############################################################ #
    # FIN CARTOGRAPHIE
    # ############################################################ #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    #
    ##############################################################
    # ANALYSE DES TEMPÉRATURES
    ##############################################################

    ##########################################
    # Touques
    ##########################################

    ################################
    # Description
    ################################

    # Tableau des statistiques descriptives générales
    output$touques_desc_g= renderTable(db_stats_g_touques)

    output$Touquesimg <- renderImage({
        # When input$n is 3, filename is ./images/image3.jpeg
        imagename = paste0(pathimg,"/Touques.png")
        imageOutput(imagename)

    })




    output$StatsDescTouques = DT::renderDataTable(

        db_stats_Touques,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )




    db_sonde_synthese_Touques = db_sonde_synthese[db_sonde_synthese$id_sonde == 825 |
                                                      db_sonde_synthese$id_sonde == 827 |
                                                      db_sonde_synthese$id_sonde == 828 |
                                                      db_sonde_synthese$id_sonde == 830 ,]
    output$map_Touques <- renderLeaflet({

        leaflet() %>%
            addTiles() %>%
            addAwesomeMarkers(data = db_sonde_synthese_Touques,
                              lng=db_sonde_synthese_Touques$longitude,lat=db_sonde_synthese_Touques$latitude,
                              #layerId = map_Touques$id_sonde, group="DREAL",
                              icon=makeAwesomeIcon(icon='tint', library='glyphicon',
                                                   iconColor = 'white', markerColor = 'orange'),

                              popup =  paste(db_sonde_synthese_Touques$label,"<br>",
                                             "Distance à la source : ",db_sonde_synthese_Touques$distance_source," km" ))%>%

            addPolylines(data=coursEau2[coursEau2@data$Name== "Touques",],color="blue")

    })



    ################################
    # Tmoy + MM7
    ################################


    # Données moyenne journalière + MM7
    varSelecTouques <- reactiveValues(
        `Température minimale` = F,
        `Température moyenne` = T,
        `Température maximale` = F,
        `Température minimale MM7` = F,
        `Température moyenne MM7` = F,
        `Température maximale MM7` = F
    )
    vec_col_Teau =c("#A6CEE3", "#83e12f", "#FB9A99", "#1F78B4", "#33A02C", "#E31A1C")
    ##############
    # Sonde 825
    ##############


    output$Sonde825MM7 <- renderDygraph({
        if(varSelecTouques$`Température minimale` == FALSE &
           varSelecTouques$`Température moyenne`== FALSE &
           varSelecTouques$`Température maximale` == FALSE &
           varSelecTouques$`Température minimale MM7` == FALSE &
           varSelecTouques$`Température moyenne MM7` == FALSE &
           varSelecTouques$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==825),]$date)),
                            order.by = db2[which(db2$id_sonde==825),]$date
            )
        }
        else{
            serie_xts =  db_Touques_xtsa[db_Touques_xtsa$id_sonde == 825 ,c(varSelecTouques$`Température minimale`,varSelecTouques$`Température moyenne`,varSelecTouques$`Température maximale`,
                                                                            varSelecTouques$`Température minimale MM7`,varSelecTouques$`Température moyenne MM7`,varSelecTouques$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,25.5))

        y_min = min(db_Touques_xtsa[db_Touques_xtsa$id_sonde == 825]$`Température maximale`)-2
        y_max = max(db_Touques_xtsa[db_Touques_xtsa$id_sonde == 825]$`Température maximale`)+2

        if(varSelecTouques$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==825,]$date), max(db2[db2$id_sonde==825,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecTouques$`Température minimale`,
                                                  varSelecTouques$`Température moyenne`,
                                                  varSelecTouques$`Température maximale`,
                                                  varSelecTouques$`Température minimale MM7`,
                                                  varSelecTouques$`Température moyenne MM7`,
                                                  varSelecTouques$`Température maximale MM7`)])

        }
        else if(varSelecTouques$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==825,]$date), max(db2[db2$id_sonde==825,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecTouques$`Température minimale`,
                                                  varSelecTouques$`Température moyenne`,
                                                  varSelecTouques$`Température maximale`,
                                                  varSelecTouques$`Température minimale MM7`,
                                                  varSelecTouques$`Température moyenne MM7`,
                                                  varSelecTouques$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(25.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 25.5, color="#ff7a7a", axis="y") %>%
                dyShading(25.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==825,]$date), max(db2[db2$id_sonde==825,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecTouques$`Température minimale`,
                                                  varSelecTouques$`Température moyenne`,
                                                  varSelecTouques$`Température maximale`,
                                                  varSelecTouques$`Température minimale MM7`,
                                                  varSelecTouques$`Température moyenne MM7`,
                                                  varSelecTouques$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })


    observeEvent(input$Teau_min, {
        varSelecTouques$`Température minimale` = input$Teau_min
    })

    observeEvent(input$Teau_moy, {
        varSelecTouques$`Température moyenne` = input$Teau_moy
    })

    observeEvent(input$Teau_max, {
        varSelecTouques$`Température maximale` = input$Teau_max
    })

    observeEvent(input$Teau_minMM7, {
        varSelecTouques$`Température minimale MM7` = input$Teau_minMM7
    })
    observeEvent(input$Teau_moyMM7, {
        varSelecTouques$`Température moyenne MM7` = input$Teau_moyMM7
    })
    observeEvent(input$Teau_maxMM7, {
        varSelecTouques$`Température maximale MM7` = input$Teau_maxMM7
    })
    observeEvent(input$preferendum_th, {
        varSelecTouques$preferendum = input$preferendum_th
    })


    ##############
    # Sonde 827
    ##############


    output$Sonde827MM7 <- renderDygraph({
        if(varSelecTouques$`Température minimale` == FALSE &
           varSelecTouques$`Température moyenne`== FALSE &
           varSelecTouques$`Température maximale` == FALSE &
           varSelecTouques$`Température minimale MM7` == FALSE &
           varSelecTouques$`Température moyenne MM7` == FALSE &
           varSelecTouques$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==827),]$date)),
                            order.by = db2[which(db2$id_sonde==827),]$date
            )
        }
        else{
            serie_xts =  db_Touques_xtsa[db_Touques_xtsa$id_sonde == 827 ,c(varSelecTouques$`Température minimale`,varSelecTouques$`Température moyenne`,varSelecTouques$`Température maximale`,
                                                                            varSelecTouques$`Température minimale MM7`,varSelecTouques$`Température moyenne MM7`,varSelecTouques$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,27.5))

        y_min = min(db_Touques_xtsa[db_Touques_xtsa$id_sonde == 827]$`Température maximale`)-4
        y_max = max(db_Touques_xtsa[db_Touques_xtsa$id_sonde == 827]$`Température maximale`)+2

        if(varSelecTouques$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==827,]$date), max(db2[db2$id_sonde==827,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecTouques$`Température minimale`,
                                                  varSelecTouques$`Température moyenne`,
                                                  varSelecTouques$`Température maximale`,
                                                  varSelecTouques$`Température minimale MM7`,
                                                  varSelecTouques$`Température moyenne MM7`,
                                                  varSelecTouques$`Température maximale MM7`)])

        }
        else if(varSelecTouques$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==827,]$date), max(db2[db2$id_sonde==827,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecTouques$`Température minimale`,
                                                  varSelecTouques$`Température moyenne`,
                                                  varSelecTouques$`Température maximale`,
                                                  varSelecTouques$`Température minimale MM7`,
                                                  varSelecTouques$`Température moyenne MM7`,
                                                  varSelecTouques$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(27.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 27.5, color="#ff7a7a", axis="y") %>%
                dyShading(27.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==827,]$date), max(db2[db2$id_sonde==827,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecTouques$`Température minimale`,
                                                  varSelecTouques$`Température moyenne`,
                                                  varSelecTouques$`Température maximale`,
                                                  varSelecTouques$`Température minimale MM7`,
                                                  varSelecTouques$`Température moyenne MM7`,
                                                  varSelecTouques$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })


    ##############
    # Sonde 828
    ##############
    output$Sonde828MM7 <- renderDygraph({
        if(varSelecTouques$`Température minimale` == FALSE &
           varSelecTouques$`Température moyenne`== FALSE &
           varSelecTouques$`Température maximale` == FALSE &
           varSelecTouques$`Température minimale MM7` == FALSE &
           varSelecTouques$`Température moyenne MM7` == FALSE &
           varSelecTouques$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==828),]$date)),
                            order.by = db2[which(db2$id_sonde==828),]$date
            )
        }
        else{
            serie_xts =  db_Touques_xtsa[db_Touques_xtsa$id_sonde == 828 ,c(varSelecTouques$`Température minimale`,varSelecTouques$`Température moyenne`,varSelecTouques$`Température maximale`,
                                                                            varSelecTouques$`Température minimale MM7`,varSelecTouques$`Température moyenne MM7`,varSelecTouques$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,28.5))

        y_min = min(db_Touques_xtsa[db_Touques_xtsa$id_sonde == 828]$`Température maximale`)-1
        y_max = max(db_Touques_xtsa[db_Touques_xtsa$id_sonde == 828]$`Température maximale`)+1

        if(varSelecTouques$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==828,]$date), max(db2[db2$id_sonde==828,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecTouques$`Température minimale`,
                                                  varSelecTouques$`Température moyenne`,
                                                  varSelecTouques$`Température maximale`,
                                                  varSelecTouques$`Température minimale MM7`,
                                                  varSelecTouques$`Température moyenne MM7`,
                                                  varSelecTouques$`Température maximale MM7`)])

        }
        else if(varSelecTouques$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==828,]$date), max(db2[db2$id_sonde==828,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecTouques$`Température minimale`,
                                                  varSelecTouques$`Température moyenne`,
                                                  varSelecTouques$`Température maximale`,
                                                  varSelecTouques$`Température minimale MM7`,
                                                  varSelecTouques$`Température moyenne MM7`,
                                                  varSelecTouques$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(28.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 28.5, color="#ff7a7a", axis="y") %>%
                dyShading(28.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==828,]$date), max(db2[db2$id_sonde==828,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecTouques$`Température minimale`,
                                                  varSelecTouques$`Température moyenne`,
                                                  varSelecTouques$`Température maximale`,
                                                  varSelecTouques$`Température minimale MM7`,
                                                  varSelecTouques$`Température moyenne MM7`,
                                                  varSelecTouques$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })


    ##############
    # Sonde 830
    ##############


    output$Sonde830MM7 <- renderDygraph({
        if(varSelecTouques$`Température minimale` == FALSE &
           varSelecTouques$`Température moyenne`== FALSE &
           varSelecTouques$`Température maximale` == FALSE &
           varSelecTouques$`Température minimale MM7` == FALSE &
           varSelecTouques$`Température moyenne MM7` == FALSE &
           varSelecTouques$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==830),]$date)),
                            order.by = db2[which(db2$id_sonde==830),]$date
            )
        }
        else{
            serie_xts =  db_Touques_xtsa[db_Touques_xtsa$id_sonde == 830 ,c(varSelecTouques$`Température minimale`,varSelecTouques$`Température moyenne`,varSelecTouques$`Température maximale`,
                                                                            varSelecTouques$`Température minimale MM7`,varSelecTouques$`Température moyenne MM7`,varSelecTouques$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,30.5))

        y_min = min(db_Touques_xtsa[db_Touques_xtsa$id_sonde == 830]$`Température maximale`)-3
        y_max = max(db_Touques_xtsa[db_Touques_xtsa$id_sonde == 830]$`Température maximale`)

        if(varSelecTouques$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==830,]$date), max(db2[db2$id_sonde==830,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecTouques$`Température minimale`,
                                                  varSelecTouques$`Température moyenne`,
                                                  varSelecTouques$`Température maximale`,
                                                  varSelecTouques$`Température minimale MM7`,
                                                  varSelecTouques$`Température moyenne MM7`,
                                                  varSelecTouques$`Température maximale MM7`)])

        }
        else if(varSelecTouques$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==830,]$date), max(db2[db2$id_sonde==830,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecTouques$`Température minimale`,
                                                  varSelecTouques$`Température moyenne`,
                                                  varSelecTouques$`Température maximale`,
                                                  varSelecTouques$`Température minimale MM7`,
                                                  varSelecTouques$`Température moyenne MM7`,
                                                  varSelecTouques$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 30.5, color="#ff7a7a", axis="y") %>%
                dyShading(30.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==830,]$date), max(db2[db2$id_sonde==830,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecTouques$`Température minimale`,
                                                  varSelecTouques$`Température moyenne`,
                                                  varSelecTouques$`Température maximale`,
                                                  varSelecTouques$`Température minimale MM7`,
                                                  varSelecTouques$`Température moyenne MM7`,
                                                  varSelecTouques$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })

    ################################
    # Fréquence
    ################################

    ####################
    # Tableau récap
    ####################

    output$TableTouquesFreq = DT::renderDataTable(

        prefTouques,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )

    ####################
    # Histogrammes
    ####################
    colLimite = c("Seuil critique" = "#ff2a2a",
                  "Danger pour juvéniles"="#f5f544",
                  "Danger pour les embryons"="#dde02b",
                  "Seuil létal"="#f11111",
                  "Seuil létal juvéniles"="#f53c3c",
                  "Seuil létal adulte"="#f11111",
                  "Préférendum thermique"="#a1ec54",
                  "Sans Espèce"="blue")


    ##############
    # Sonde 825
    ##############
    db825 <-  db2[db2$id_sonde == 825,]
    dataHist825 <- reactive({
        df2 <- db825  %>%
            filter(Espece %in% input$EspeceT)%>%
            filter(An >= input$AnHistT[1] & An <= input$AnHistT[2])

    })


    output$hist825 = renderPlotly({

        gghist825 <- dataHist825()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist825 <- ggplotly(gghist825)
    })

    ##############
    # Sonde 827
    ##############

    db827 <-  db2[db2$id_sonde == 827,]
    dataHist827 <- reactive({
        df2 <- db827 %>%
            filter(Espece %in% input$EspeceT)%>%
            filter(An >= input$AnHistT[1] & An <= input$AnHistT[2])

    })

    output$hist827 = renderPlotly({

        gghist827 <- dataHist827()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist827 <- ggplotly(gghist827)
    })

    ##############
    # Sonde 828
    ##############


    db828 <-  db2[db2$id_sonde == 828,]
    dataHist828 <- reactive({
        df2 <- db828  %>%
            filter(Espece %in% input$EspeceT)%>%
            filter(An >= input$AnHistT[1] & An <= input$AnHistT[2])
    })
    output$hist828 = renderPlotly({

        gghist828 <- dataHist828()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist828 <- ggplotly(gghist828)
    })

    ##############
    # Sonde 830
    ##############


    db830 <-  db2[db2$id_sonde == 830,]
    dataHist830 <- reactive({
        df2 <- db830 %>%
            filter(Espece %in% input$EspeceT)%>%
            filter(An >= input$AnHistT[1] & An <= input$AnHistT[2])
    })
    output$hist830 = renderPlotly({

        gghist830 <- dataHist830()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist830 <- ggplotly(gghist830)
    })

    ################################
    # Températures lissées sur 30 jours
    ################################

    # Tableau des droites de régressions
    output$db_Touques_stats_MM30_An2= renderTable(db_Touques_stats_MM30_An2)


    varSelecMM30 <- reactiveValues(
        `Température minimale MM30` = F,
        `Température moyenne MM30` = T,
        `Température maximale MM30` = F,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    observeEvent(input$Teau_minMM30, {
        varSelecMM30$`Température minimale MM30` = input$Teau_minMM30
    })

    observeEvent(input$Teau_moyMM30, {
        varSelecMM30$`Température moyenne MM30` = input$Teau_moyMM30
    })

    observeEvent(input$Teau_maxMM30, {
        varSelecMM30$`Température maximale MM30` = input$Teau_maxMM30
    })

    observeEvent(input$Teau_minreg30, {
        varSelecMM30$`Régression températures min` = input$Teau_minreg30
    })
    observeEvent(input$Teau_maxreg30, {
        varSelecMM30$`Régression températures max` = input$Teau_maxreg30
    })


    vec_col_MM30 = c("blue", "green", "red", "blue", "red")

    ##############
    # Sonde 825
    #############

    output$Sonde825MM30 <- renderDygraph({
        if(varSelecMM30$`Température minimale MM30` == FALSE &
           varSelecMM30$`Température moyenne MM30`== FALSE &
           varSelecMM30$`Température maximale MM30` == FALSE &
           varSelecMM30$`Régression températures max` == FALSE &
           varSelecMM30$`Régression températures min` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==825),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==825),]$date
            )
        }
        else{
            serie_xts = db_Touques_xtsb[db_Touques_xtsb$id_sonde == 825 ,c(varSelecMM30$`Température minimale MM30`,varSelecMM30$`Température moyenne MM30`,varSelecMM30$`Température maximale MM30`,
                                                                           varSelecMM30$`Régression températures min`,varSelecMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Touques_xtsb[db_Touques_xtsb$id_sonde==825,]$`Température minimale MM30`)-1,
                         max(db_Touques_xtsb[db_Touques_xtsb$id_sonde==825,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==825,]$date), max(db2[db2$id_sonde==825,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecMM30$`Température minimale MM30`,
                                              varSelecMM30$`Température moyenne MM30` ,
                                              varSelecMM30$`Température maximale MM30` ,
                                              varSelecMM30$`Régression températures min` ,
                                              varSelecMM30$`Régression températures max`)])
    })



    #############
    # Sonde 827
    #############


    output$Sonde827MM30 <- renderDygraph({
        if(varSelecMM30$`Température minimale MM30` == FALSE &
           varSelecMM30$`Température moyenne MM30`== FALSE &
           varSelecMM30$`Température maximale MM30` == FALSE &
           varSelecMM30$`Régression températures min` == FALSE &
           varSelecMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==827),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==827),]$date
            )
        }
        else{
            serie_xts = db_Touques_xtsb[db_Touques_xtsb$id_sonde == 827,c(varSelecMM30$`Température minimale MM30`,varSelecMM30$`Température moyenne MM30`,varSelecMM30$`Température maximale MM30`,
                                                                          varSelecMM30$`Régression températures min`,varSelecMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Touques_xtsb[db_Touques_xtsb$id_sonde==827,]$`Température minimale MM30`)-1,
                         max(db_Touques_xtsb[db_Touques_xtsb$id_sonde==827,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==827,]$date), max(db2[db2$id_sonde==827,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecMM30$`Température minimale MM30`,
                                              varSelecMM30$`Température moyenne MM30` ,
                                              varSelecMM30$`Température maximale MM30` ,
                                              varSelecMM30$`Régression températures min` ,
                                              varSelecMM30$`Régression températures max`)])
    })


    #############
    # Sonde 828
    #############


    output$Sonde828MM30 <- renderDygraph({
        if(varSelecMM30$`Température minimale MM30` == FALSE &
           varSelecMM30$`Température moyenne MM30`== FALSE &
           varSelecMM30$`Température maximale MM30` == FALSE &
           varSelecMM30$`Régression températures min` == FALSE &
           varSelecMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==828),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==828),]$date
            )
        }
        else{
            serie_xts = db_Touques_xtsb[db_Touques_xtsb$id_sonde == 828,c(varSelecMM30$`Température minimale MM30`,varSelecMM30$`Température moyenne MM30`,varSelecMM30$`Température maximale MM30`,
                                                                          varSelecMM30$`Régression températures min`,varSelecMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Touques_xtsb[db_Touques_xtsb$id_sonde==828,]$`Température minimale MM30`)-1,
                         max(db_Touques_xtsb[db_Touques_xtsb$id_sonde==828,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==828,]$date), max(db2[db2$id_sonde==828,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecMM30$`Température minimale MM30`,
                                              varSelecMM30$`Température moyenne MM30` ,
                                              varSelecMM30$`Température maximale MM30` ,
                                              varSelecMM30$`Régression températures min` ,
                                              varSelecMM30$`Régression températures max`)])
    })


    #############
    # Sonde 830
    #############


    output$Sonde830MM30 <- renderDygraph({
        if(varSelecMM30$`Température minimale MM30` == FALSE &
           varSelecMM30$`Température moyenne MM30`== FALSE &
           varSelecMM30$`Température maximale MM30` == FALSE &
           varSelecMM30$`Régression températures min` == FALSE &
           varSelecMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==830),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==830),]$date
            )
        }
        else{
            serie_xts = db_Touques_xtsb[db_Touques_xtsb$id_sonde == 830,c(varSelecMM30$`Température minimale MM30`,varSelecMM30$`Température moyenne MM30`,varSelecMM30$`Température maximale MM30`,
                                                                          varSelecMM30$`Régression températures min`,varSelecMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Touques_xtsb[db_Touques_xtsb$id_sonde==830,]$`Température minimale MM30`)-1,
                         max(db_Touques_xtsb[db_Touques_xtsb$id_sonde==830,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==830,]$date), max(db2[db2$id_sonde==830,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecMM30$`Température minimale MM30`,
                                              varSelecMM30$`Température moyenne MM30` ,
                                              varSelecMM30$`Température maximale MM30` ,
                                              varSelecMM30$`Régression températures min` ,
                                              varSelecMM30$`Régression températures max`)])
    })






    ####################
    # Stats avec MM30 pour tableau récap moyenne mensuelle et annuelles
    ####################

    output$db_Touques_stats_MM30_An = DT::renderDataTable(

        db_Touques_stats_MM30_An,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )

    output$db_Touques_stats_MM30_mois = DT::renderDataTable(

        db_Touques_stats_MM30_mois,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )
    ################################
    # Températures lissées sur 365jours
    ################################

    # Températures lissées sur 365 jours
    # ------------------------------------------------------------ #

    varSelecMM365 <- reactiveValues(
        `Température minimale MM365` = F,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = F,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    observeEvent(input$Teau_minMM365, {
        varSelecMM365$`Température minimale MM365` = input$Teau_minMM365
    })

    observeEvent(input$Teau_moyMM365, {
        varSelecMM365$`Température moyenne MM365` = input$Teau_moyMM365
    })

    observeEvent(input$Teau_maxMM365, {
        varSelecMM365$`Température maximale MM365` = input$Teau_maxMM365
    })

    observeEvent(input$Teau_minreg365, {
        varSelecMM365$`Régression températures min` = input$Teau_minreg365
    })
    observeEvent(input$Teau_maxreg365, {
        varSelecMM365$`Régression températures max` = input$Teau_maxreg365
    })

    ##############
    # Sonde 825
    #############
    output$Sonde825MM365 <- renderDygraph({
        if(varSelecMM365$`Température minimale MM365` == FALSE &
           varSelecMM365$`Température moyenne MM365`== FALSE &
           varSelecMM365$`Température maximale MM365` == FALSE &
           varSelecMM365$`Régression températures min` == FALSE &
           varSelecMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==825),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==825),]$date
            )
        }
        else{
            serie_xts = db_Touques_xtsc[db_Touques_xtsc$id_sonde == 825,c(varSelecMM365$`Température minimale MM365`,varSelecMM365$`Température moyenne MM365`,varSelecMM365$`Température maximale MM365`,
                                                                          varSelecMM365$`Régression températures min`,varSelecMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Touques_xtsc[db_Touques_xtsc$id_sonde==825,]$`Température minimale MM365`)-2,
                         max(db_Touques_xtsc[db_Touques_xtsc$id_sonde==825,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==825,]$date), max(db2[db2$id_sonde==825,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecMM365$`Température minimale MM365`,
                                              varSelecMM365$`Température moyenne MM365` ,
                                              varSelecMM365$`Température maximale MM365` ,
                                              varSelecMM365$`Régression températures min` ,
                                              varSelecMM365$`Régression températures max`)])
    })





    ##############
    # Sonde 827
    #############


    output$Sonde827MM365 <- renderDygraph({
        if(varSelecMM365$`Température minimale MM365` == FALSE &
           varSelecMM365$`Température moyenne MM365`== FALSE &
           varSelecMM365$`Température maximale MM365` == FALSE &
           varSelecMM365$`Régression températures min` == FALSE &
           varSelecMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==827),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==827),]$date
            )
        }
        else{
            serie_xts = db_Touques_xtsc[db_Touques_xtsc$id_sonde == 827,c(varSelecMM365$`Température minimale MM365`,varSelecMM365$`Température moyenne MM365`,varSelecMM365$`Température maximale MM365`,
                                                                          varSelecMM365$`Régression températures min`,varSelecMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Touques_xtsc[db_Touques_xtsc$id_sonde==827,]$`Température minimale MM365`)-2,
                         max(db_Touques_xtsc[db_Touques_xtsc$id_sonde==827,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==827,]$date), max(db2[db2$id_sonde==827,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecMM365$`Température minimale MM365`,
                                              varSelecMM365$`Température moyenne MM365` ,
                                              varSelecMM365$`Température maximale MM365`,
                                              varSelecMM365$`Régression températures min`,
                                              varSelecMM365$`Régression températures max`)])
    })


    ##############
    # Sonde 828
    #############

    varSelecMM365 <- reactiveValues(
        `Température minimale MM365` = T,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = T,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    output$Sonde828MM365 <- renderDygraph({
        if(varSelecMM365$`Température minimale MM365` == FALSE &
           varSelecMM365$`Température moyenne MM365`== FALSE &
           varSelecMM365$`Température maximale MM365` == FALSE &
           varSelecMM365$`Régression températures min` == FALSE &
           varSelecMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==828),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==828),]$date
            )
        }
        else{
            serie_xts = db_Touques_xtsc[db_Touques_xtsc$id_sonde == 828,c(varSelecMM365$`Température minimale MM365`,varSelecMM365$`Température moyenne MM365`,varSelecMM365$`Température maximale MM365`,
                                                                          varSelecMM365$`Régression températures min`,varSelecMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)",valueRange =
                       c(min(db_Touques_xtsc[db_Touques_xtsc$id_sonde==828,]$`Température minimale MM365`)-2,
                         max(db_Touques_xtsc[db_Touques_xtsc$id_sonde==828,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==828,]$date), max(db2[db2$id_sonde==828,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecMM365$`Température minimale MM365`,
                                              varSelecMM365$`Température moyenne MM365`,
                                              varSelecMM365$`Température maximale MM365`,
                                              varSelecMM365$`Régression températures min`,
                                              varSelecMM365$`Régression températures max`)])
    })


    ##############
    # Sonde 830
    #############

    varSelecMM365 <- reactiveValues(
        `Température minimale MM365` = T,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = T,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    output$Sonde830MM365 <- renderDygraph({
        if(varSelecMM365$`Température minimale MM365` == FALSE &
           varSelecMM365$`Température moyenne MM365`== FALSE &
           varSelecMM365$`Température maximale MM365` == FALSE &
           varSelecMM365$`Régression températures min` == FALSE &
           varSelecMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==830),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==830),]$date
            )
        }
        else{
            serie_xts = db_Touques_xtsc[db_Touques_xtsc$id_sonde == 830,c(varSelecMM365$`Température minimale MM365`,varSelecMM365$`Température moyenne MM365`,varSelecMM365$`Température maximale MM365`,
                                                                          varSelecMM365$`Régression températures min`,varSelecMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Touques_xtsc[db_Touques_xtsc$id_sonde==830,]$`Température minimale MM365`)-2,
                         max(db_Touques_xtsc[db_Touques_xtsc$id_sonde==830,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==830,]$date), max(db2[db2$id_sonde==830,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecMM365$`Température minimale MM365`,
                                              varSelecMM365$`Température moyenne MM365` ,
                                              varSelecMM365$`Température maximale MM365`,
                                              varSelecMM365$`Régression températures min`,
                                              varSelecMM365$`Régression températures max`)])
    })



    ################################
    # Régressions
    ################################

    ##############
    # Reg Touques 825
    #############


    output$Reg825 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 825,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"825"],
                        slope = dataRegCoeff[2,"825"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })

    ##############
    # Reg Touques 827
    #############


    output$Reg827 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 827,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"827"],
                        slope = dataRegCoeff[2,"827"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })

    ##############
    # Reg Touques 828
    #############


    output$Reg828 = renderPlotly({

        ggplot(data=  db_teau_tair3[db_teau_tair3$id_sonde == 828,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"828"],
                        slope = dataRegCoeff[2,"828"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })

    ##############
    # Reg Touques 830
    #############


    output$Reg830 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 830,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"830"],
                        slope = dataRegCoeff[2,"830"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })






    ##########################################
    # Orne
    ##########################################

    ################################
    # Description
    ################################

    output$StatsDescOrne = DT::renderDataTable(

        db_stats_Orne,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )

    db_sonde_synthese_Orne = db_sonde_synthese[db_sonde_synthese$id_sonde == 817 |
                                                   db_sonde_synthese$id_sonde == 819 |
                                                   db_sonde_synthese$id_sonde == 818 ,]
    output$map_Orne <- renderLeaflet({

        leaflet() %>%
            addTiles() %>%
            addAwesomeMarkers(data = db_sonde_synthese_Orne,
                              lng=db_sonde_synthese_Orne$longitude,lat=db_sonde_synthese_Orne$latitude,
                              #layerId = map_Touques$id_sonde, group="DREAL",
                              icon=makeAwesomeIcon(icon='tint', library='glyphicon',
                                                   iconColor = 'white', markerColor = 'orange'),

                              popup =  paste(db_sonde_synthese_Orne$label,"<br>",
                                             "Distance à la source : ",db_sonde_synthese_Orne$distance_source," km" ))%>%

            addPolylines(data=coursEau2[coursEau2@data$Name== "Orne",],color="blue")

    })










    ################################
    # Tmoy + MM7
    ################################


    # Données moyenne journalière + MM7
    varSelecOrne <- reactiveValues(
        `Température minimale` = F,
        `Température moyenne` = T,
        `Température maximale` = F,
        `Température minimale MM7` = F,
        `Température moyenne MM7` = F,
        `Température maximale MM7` = F
    )
    vec_col_Teau =c("#A6CEE3", "#83e12f", "#FB9A99", "#1F78B4", "#33A02C", "#E31A1C")
    ##############
    # Sonde 817
    ##############


    output$Sonde817MM7 <- renderDygraph({
        if(varSelecOrne$`Température minimale` == FALSE &
           varSelecOrne$`Température moyenne`== FALSE &
           varSelecOrne$`Température maximale` == FALSE &
           varSelecOrne$`Température minimale MM7` == FALSE &
           varSelecOrne$`Température moyenne MM7` == FALSE &
           varSelecOrne$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==817),]$date)),
                            order.by = db2[which(db2$id_sonde==817),]$date
            )
        }
        else{
            serie_xts =  db_Orne_xtsa[db_Orne_xtsa$id_sonde == 817 ,c(varSelecOrne$`Température minimale`,varSelecOrne$`Température moyenne`,varSelecOrne$`Température maximale`,
                                                                      varSelecOrne$`Température minimale MM7`,varSelecOrne$`Température moyenne MM7`,varSelecOrne$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,25.5))

        y_min = min(db_Orne_xtsa[db_Orne_xtsa$id_sonde == 817]$`Température maximale`)
        y_max = max(db_Orne_xtsa[db_Orne_xtsa$id_sonde == 817]$`Température maximale`)

        if(varSelecOrne$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==817,]$date), max(db2[db2$id_sonde==817,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOrne$`Température minimale`,
                                                  varSelecOrne$`Température moyenne`,
                                                  varSelecOrne$`Température maximale`,
                                                  varSelecOrne$`Température minimale MM7`,
                                                  varSelecOrne$`Température moyenne MM7`,
                                                  varSelecOrne$`Température maximale MM7`)])

        }
        else if(varSelecOrne$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==817,]$date), max(db2[db2$id_sonde==817,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOrne$`Température minimale`,
                                                  varSelecOrne$`Température moyenne`,
                                                  varSelecOrne$`Température maximale`,
                                                  varSelecOrne$`Température minimale MM7`,
                                                  varSelecOrne$`Température moyenne MM7`,
                                                  varSelecOrne$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(25.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 0.5, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 25.5, color="#ff7a7a", axis="y") %>%
                dyShading(25.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==817,]$date), max(db2[db2$id_sonde==817,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOrne$`Température minimale`,
                                                  varSelecOrne$`Température moyenne`,
                                                  varSelecOrne$`Température maximale`,
                                                  varSelecOrne$`Température minimale MM7`,
                                                  varSelecOrne$`Température moyenne MM7`,
                                                  varSelecOrne$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })


    observeEvent(input$Teau_minOrne, {
        varSelecOrne$`Température minimale` = input$Teau_minOrne
    })

    observeEvent(input$Teau_moyOrne, {
        varSelecOrne$`Température moyenne` = input$Teau_moyOrne
    })

    observeEvent(input$Teau_maxOrne, {
        varSelecOrne$`Température maximale` = input$Teau_maxOrne
    })

    observeEvent(input$Teau_minMM7Orne, {
        varSelecOrne$`Température minimale MM7` = input$Teau_minMM7Orne
    })
    observeEvent(input$Teau_moyMM7Orne, {
        varSelecOrne$`Température moyenne MM7` = input$Teau_moyMM7Orne
    })
    observeEvent(input$Teau_maxMM7Orne, {
        varSelecOrne$`Température maximale MM7` = input$Teau_maxMM7Orne
    })
    observeEvent(input$preferendum_thOrne, {
        varSelecOrne$preferendum = input$preferendum_thOrne
    })


    ##############
    # Sonde 819
    ##############


    output$Sonde819MM7 <- renderDygraph({
        if(varSelecOrne$`Température minimale` == FALSE &
           varSelecOrne$`Température moyenne`== FALSE &
           varSelecOrne$`Température maximale` == FALSE &
           varSelecOrne$`Température minimale MM7` == FALSE &
           varSelecOrne$`Température moyenne MM7` == FALSE &
           varSelecOrne$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==819),]$date)),
                            order.by = db2[which(db2$id_sonde==819),]$date
            )
        }
        else{
            serie_xts =  db_Orne_xtsa[db_Orne_xtsa$id_sonde == 819 ,c(varSelecOrne$`Température minimale`,varSelecOrne$`Température moyenne`,varSelecOrne$`Température maximale`,
                                                                      varSelecOrne$`Température minimale MM7`,varSelecOrne$`Température moyenne MM7`,varSelecOrne$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,27.5))

        y_min = min(db_Orne_xtsa[db_Orne_xtsa$id_sonde == 819]$`Température maximale`)-4
        y_max = max(db_Orne_xtsa[db_Orne_xtsa$id_sonde == 819]$`Température maximale`)+2

        if(varSelecOrne$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==819,]$date), max(db2[db2$id_sonde==819,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOrne$`Température minimale`,
                                                  varSelecOrne$`Température moyenne`,
                                                  varSelecOrne$`Température maximale`,
                                                  varSelecOrne$`Température minimale MM7`,
                                                  varSelecOrne$`Température moyenne MM7`,
                                                  varSelecOrne$`Température maximale MM7`)])

        }
        else if(varSelecOrne$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==819,]$date), max(db2[db2$id_sonde==819,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOrne$`Température minimale`,
                                                  varSelecOrne$`Température moyenne`,
                                                  varSelecOrne$`Température maximale`,
                                                  varSelecOrne$`Température minimale MM7`,
                                                  varSelecOrne$`Température moyenne MM7`,
                                                  varSelecOrne$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(27.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 0.5, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 27.5, color="#ff7a7a", axis="y") %>%
                dyShading(27.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==819,]$date), max(db2[db2$id_sonde==819,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOrne$`Température minimale`,
                                                  varSelecOrne$`Température moyenne`,
                                                  varSelecOrne$`Température maximale`,
                                                  varSelecOrne$`Température minimale MM7`,
                                                  varSelecOrne$`Température moyenne MM7`,
                                                  varSelecOrne$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })




    ##############
    # Sonde 818
    ##############
    output$Sonde818MM7 <- renderDygraph({
        if(varSelecOrne$`Température minimale` == FALSE &
           varSelecOrne$`Température moyenne`== FALSE &
           varSelecOrne$`Température maximale` == FALSE &
           varSelecOrne$`Température minimale MM7` == FALSE &
           varSelecOrne$`Température moyenne MM7` == FALSE &
           varSelecOrne$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==818),]$date)),
                            order.by = db2[which(db2$id_sonde==818),]$date
            )
        }
        else{
            serie_xts =  db_Orne_xtsa[db_Orne_xtsa$id_sonde == 818 ,c(varSelecOrne$`Température minimale`,varSelecOrne$`Température moyenne`,varSelecOrne$`Température maximale`,
                                                                      varSelecOrne$`Température minimale MM7`,varSelecOrne$`Température moyenne MM7`,varSelecOrne$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,28.5))

        y_min = min(db_Orne_xtsa[db_Orne_xtsa$id_sonde == 818]$`Température maximale`)-1
        y_max = max(db_Orne_xtsa[db_Orne_xtsa$id_sonde == 818]$`Température maximale`)+1

        if(varSelecOrne$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==818,]$date), max(db2[db2$id_sonde==818,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOrne$`Température minimale`,
                                                  varSelecOrne$`Température moyenne`,
                                                  varSelecOrne$`Température maximale`,
                                                  varSelecOrne$`Température minimale MM7`,
                                                  varSelecOrne$`Température moyenne MM7`,
                                                  varSelecOrne$`Température maximale MM7`)])

        }
        else if(varSelecOrne$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==818,]$date), max(db2[db2$id_sonde==818,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOrne$`Température minimale`,
                                                  varSelecOrne$`Température moyenne`,
                                                  varSelecOrne$`Température maximale`,
                                                  varSelecOrne$`Température minimale MM7`,
                                                  varSelecOrne$`Température moyenne MM7`,
                                                  varSelecOrne$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(28.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 28.5, color="#ff7a7a", axis="y") %>%
                dyShading(28.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==818,]$date), max(db2[db2$id_sonde==818,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOrne$`Température minimale`,
                                                  varSelecOrne$`Température moyenne`,
                                                  varSelecOrne$`Température maximale`,
                                                  varSelecOrne$`Température minimale MM7`,
                                                  varSelecOrne$`Température moyenne MM7`,
                                                  varSelecOrne$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })




    ################################
    # Températures lissées sur 30 jours
    ################################

    varSelecOrneMM30 <- reactiveValues(
        `Température minimale MM30` = F,
        `Température moyenne MM30` = T,
        `Température maximale MM30` = F,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    observeEvent(input$Teau_minMM30Orne, {
        varSelecOrneMM30$`Température minimale MM30` = input$Teau_minMM30Orne
    })

    observeEvent(input$Teau_moyMM30Orne, {
        varSelecOrneMM30$`Température moyenne MM30` = input$Teau_moyMM30Orne
    })

    observeEvent(input$Teau_maxMM30Orne, {
        varSelecOrneMM30$`Température maximale MM30` = input$Teau_maxMM30Orne
    })

    observeEvent(input$Teau_minreg30Orne, {
        varSelecOrneMM30$`Régression températures min` = input$Teau_minreg30Orne
    })
    observeEvent(input$Teau_maxreg30Orne, {
        varSelecOrneMM30$`Régression températures max` = input$Teau_maxreg30Orne
    })


    vec_col_MM30 = c("blue", "green", "red", "blue", "red")

    ##############
    # Sonde 817
    #############

    output$Sonde817MM30 <- renderDygraph({
        if(varSelecOrneMM30$`Température minimale MM30` == FALSE &
           varSelecOrneMM30$`Température moyenne MM30`== FALSE &
           varSelecOrneMM30$`Température maximale MM30` == FALSE &
           varSelecOrneMM30$`Régression températures max` == FALSE &
           varSelecOrneMM30$`Régression températures min` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==817),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==817),]$date
            )
        }
        else{
            serie_xts = db_Orne_xtsb[db_Orne_xtsb$id_sonde == 817 ,c(varSelecOrneMM30$`Température minimale MM30`,varSelecOrneMM30$`Température moyenne MM30`,varSelecOrneMM30$`Température maximale MM30`,
                                                                     varSelecOrneMM30$`Régression températures min`,varSelecOrneMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Orne_xtsb[db_Orne_xtsb$id_sonde==817,]$`Température minimale MM30`)-1,
                         max(db_Orne_xtsb[db_Orne_xtsb$id_sonde==817,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==817,]$date), max(db2[db2$id_sonde==817,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOrneMM30$`Température minimale MM30`,
                                              varSelecOrneMM30$`Température moyenne MM30` ,
                                              varSelecOrneMM30$`Température maximale MM30` ,
                                              varSelecOrneMM30$`Régression températures min` ,
                                              varSelecOrneMM30$`Régression températures max`)])
    })



    #############
    # Sonde 819
    #############


    output$Sonde819MM30 <- renderDygraph({
        if(varSelecOrneMM30$`Température minimale MM30` == FALSE &
           varSelecOrneMM30$`Température moyenne MM30`== FALSE &
           varSelecOrneMM30$`Température maximale MM30` == FALSE &
           varSelecOrneMM30$`Régression températures min` == FALSE &
           varSelecOrneMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==819),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==819),]$date
            )
        }
        else{
            serie_xts = db_Orne_xtsb[db_Orne_xtsb$id_sonde == 819,c(varSelecOrneMM30$`Température minimale MM30`,varSelecOrneMM30$`Température moyenne MM30`,varSelecOrneMM30$`Température maximale MM30`,
                                                                    varSelecOrneMM30$`Régression températures min`,varSelecOrneMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Orne_xtsb[db_Orne_xtsb$id_sonde==819,]$`Température minimale MM30`)-1,
                         max(db_Orne_xtsb[db_Orne_xtsb$id_sonde==819,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==819,]$date), max(db2[db2$id_sonde==819,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOrneMM30$`Température minimale MM30`,
                                              varSelecOrneMM30$`Température moyenne MM30` ,
                                              varSelecOrneMM30$`Température maximale MM30` ,
                                              varSelecOrneMM30$`Régression températures min` ,
                                              varSelecOrneMM30$`Régression températures max`)])
    })


    #############
    # Sonde 818
    #############


    output$Sonde818MM30 <- renderDygraph({
        if(varSelecOrneMM30$`Température minimale MM30` == FALSE &
           varSelecOrneMM30$`Température moyenne MM30`== FALSE &
           varSelecOrneMM30$`Température maximale MM30` == FALSE &
           varSelecOrneMM30$`Régression températures min` == FALSE &
           varSelecOrneMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==818),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==818),]$date
            )
        }
        else{
            serie_xts = db_Orne_xtsb[db_Orne_xtsb$id_sonde == 818,c(varSelecOrneMM30$`Température minimale MM30`,varSelecOrneMM30$`Température moyenne MM30`,varSelecOrneMM30$`Température maximale MM30`,
                                                                    varSelecOrneMM30$`Régression températures min`,varSelecOrneMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Orne_xtsb[db_Orne_xtsb$id_sonde==818,]$`Température minimale MM30`)-1,
                         max(db_Orne_xtsb[db_Orne_xtsb$id_sonde==818,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==818,]$date), max(db2[db2$id_sonde==818,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOrneMM30$`Température minimale MM30`,
                                              varSelecOrneMM30$`Température moyenne MM30` ,
                                              varSelecOrneMM30$`Température maximale MM30` ,
                                              varSelecOrneMM30$`Régression températures min` ,
                                              varSelecOrneMM30$`Régression températures max`)])
    })


    ####################
    # Stats avec MM30 pour tableau récap moyenne mensuelle et annuelles
    ####################

    output$db_Orne_stats_MM30_An = DT::renderDataTable(

        db_Orne_stats_MM30_An,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )

    output$db_Orne_stats_MM30_mois = DT::renderDataTable(

        db_Orne_stats_MM30_mois,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )



    ################################
    # Températures lissées sur 365jours
    ################################

    # Températures lissées sur 365 jours
    # ------------------------------------------------------------ #

    varSelecOrneMM365 <- reactiveValues(
        `Température minimale MM365` = F,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = F,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    observeEvent(input$Teau_minMM365Orne, {
        varSelecOrneMM365$`Température minimale MM365` = input$Teau_minMM365Orne
    })

    observeEvent(input$Teau_moyMM365Orne, {
        varSelecOrneMM365$`Température moyenne MM365` = input$Teau_moyMM365Orne
    })

    observeEvent(input$Teau_maxMM365Orne, {
        varSelecOrneMM365$`Température maximale MM365` = input$Teau_maxMM365Orne
    })

    observeEvent(input$Teau_minreg365Orne, {
        varSelecOrneMM365$`Régression températures min` = input$Teau_minreg365Orne
    })
    observeEvent(input$Teau_maxreg365Orne, {
        varSelecOrneMM365$`Régression températures max` = input$Teau_maxreg365Orne
    })

    ##############
    # Sonde 817
    #############
    output$Sonde817MM365 <- renderDygraph({
        if(varSelecOrneMM365$`Température minimale MM365` == FALSE &
           varSelecOrneMM365$`Température moyenne MM365`== FALSE &
           varSelecOrneMM365$`Température maximale MM365` == FALSE &
           varSelecOrneMM365$`Régression températures min` == FALSE &
           varSelecOrneMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==817),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==817),]$date
            )
        }
        else{
            serie_xts = db_Orne_xtsc[db_Orne_xtsc$id_sonde == 817,c(varSelecOrneMM365$`Température minimale MM365`,varSelecOrneMM365$`Température moyenne MM365`,varSelecOrneMM365$`Température maximale MM365`,
                                                                    varSelecOrneMM365$`Régression températures min`,varSelecOrneMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Orne_xtsc[db_Orne_xtsc$id_sonde==817,]$`Température minimale MM365`)-2,
                         max(db_Orne_xtsc[db_Orne_xtsc$id_sonde==817,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==817,]$date), max(db2[db2$id_sonde==817,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOrneMM365$`Température minimale MM365`,
                                              varSelecOrneMM365$`Température moyenne MM365` ,
                                              varSelecOrneMM365$`Température maximale MM365` ,
                                              varSelecOrneMM365$`Régression températures min` ,
                                              varSelecOrneMM365$`Régression températures max`)])
    })





    ##############
    # Sonde 819
    #############


    output$Sonde819MM365 <- renderDygraph({
        if(varSelecOrneMM365$`Température minimale MM365` == FALSE &
           varSelecOrneMM365$`Température moyenne MM365`== FALSE &
           varSelecOrneMM365$`Température maximale MM365` == FALSE &
           varSelecOrneMM365$`Régression températures min` == FALSE &
           varSelecOrneMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==819),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==819),]$date
            )
        }
        else{
            serie_xts = db_Orne_xtsc[db_Orne_xtsc$id_sonde == 819,c(varSelecOrneMM365$`Température minimale MM365`,varSelecOrneMM365$`Température moyenne MM365`,varSelecOrneMM365$`Température maximale MM365`,
                                                                    varSelecOrneMM365$`Régression températures min`,varSelecOrneMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Orne_xtsc[db_Orne_xtsc$id_sonde==819,]$`Température minimale MM365`)-2,
                         max(db_Orne_xtsc[db_Orne_xtsc$id_sonde==819,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==819,]$date), max(db2[db2$id_sonde==819,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOrneMM365$`Température minimale MM365`,
                                              varSelecOrneMM365$`Température moyenne MM365` ,
                                              varSelecOrneMM365$`Température maximale MM365`,
                                              varSelecOrneMM365$`Régression températures min`,
                                              varSelecOrneMM365$`Régression températures max`)])
    })


    ##############
    # Sonde 818
    #############

    varSelecOrneMM365 <- reactiveValues(
        `Température minimale MM365` = T,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = T,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    output$Sonde818MM365 <- renderDygraph({
        if(varSelecOrneMM365$`Température minimale MM365` == FALSE &
           varSelecOrneMM365$`Température moyenne MM365`== FALSE &
           varSelecOrneMM365$`Température maximale MM365` == FALSE &
           varSelecOrneMM365$`Régression températures min` == FALSE &
           varSelecOrneMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==818),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==818),]$date
            )
        }
        else{
            serie_xts = db_Orne_xtsc[db_Orne_xtsc$id_sonde == 818,c(varSelecOrneMM365$`Température minimale MM365`,varSelecOrneMM365$`Température moyenne MM365`,varSelecOrneMM365$`Température maximale MM365`,
                                                                    varSelecOrneMM365$`Régression températures min`,varSelecOrneMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)",valueRange =
                       c(min(db_Orne_xtsc[db_Orne_xtsc$id_sonde==818,]$`Température minimale MM365`)-2,
                         max(db_Orne_xtsc[db_Orne_xtsc$id_sonde==818,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==818,]$date), max(db2[db2$id_sonde==818,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOrneMM365$`Température minimale MM365`,
                                              varSelecOrneMM365$`Température moyenne MM365`,
                                              varSelecOrneMM365$`Température maximale MM365`,
                                              varSelecOrneMM365$`Régression températures min`,
                                              varSelecOrneMM365$`Régression températures max`)])
    })




    ################################
    # Fréquence
    ################################

    ####################
    # Tableau récap
    ####################

    output$TableOrneFreq = DT::renderDataTable(

        prefOrne,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )

    ####################
    # Histogrammes
    ####################
    colLimite = c("Seuil critique" = "#ff2a2a",
                  "Danger pour juvéniles"="#f5f544",
                  "Danger pour les embryons"="#dde02b",
                  "Seuil létal"="#f11111",
                  "Seuil létal juvéniles"="#f53c3c",
                  "Seuil létal adulte"="#f11111",
                  "Préférendum thermique"="#a1ec54",
                  "Sans Espèce"="blue")


    ##############
    # Sonde 817
    ##############
    db817 <-  db2[db2$id_sonde == 817,]
    dataHist817 <- reactive({
        df2 <- db817 %>%
            filter(Espece %in% input$EspeceOr)%>%
            filter(An >= input$AnHistOr[1] & An <= input$AnHistOr[2])

    })


    output$hist817 = renderPlotly({

        gghist817 <- dataHist817()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist817 <- ggplotly(gghist817)
    })

    ##############
    # Sonde 819
    ##############

    db819 <-  db2[db2$id_sonde == 819,]
    dataHist819 <- reactive({
        df2 <- db819 %>%
            filter(Espece %in% input$EspeceOr)%>%
            filter(An >= input$AnHistOr[1] & An <= input$AnHistOr[2])

    })

    output$hist819 = renderPlotly({

        gghist819 <- dataHist819()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist819 <- ggplotly(gghist819)
    })

    ##############
    # Sonde 818
    ##############


    db818 <-  db2[db2$id_sonde == 818,]
    dataHist818 <- reactive({
        df2 <- db818 %>%
            filter(Espece %in% input$EspeceOr)%>%
            filter(An >= input$AnHistOr[1] & An <= input$AnHistOr[2])
    })
    output$hist818 = renderPlotly({

        gghist818 <- dataHist818()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist818 <- ggplotly(gghist818)
    })






    ################################
    # Régressions
    ################################

    ##############
    # Reg Orne 817
    #############


    output$Reg817 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 817,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"817"],
                        slope = dataRegCoeff[2,"817"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })

    ##############
    # Reg Orne 819
    #############


    output$Reg819 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 819,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"819"],
                        slope = dataRegCoeff[2,"819"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })

    ##############
    # Reg Orne 818
    #############


    output$Reg818 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 818,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"818"],
                        slope = dataRegCoeff[2,"818"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })




    #########################################
    # Odon
    ##########################################

    ################################
    # Description
    ################################

    output$StatsDescOdon = DT::renderDataTable(

        db_stats_Odon,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )




    db_sonde_synthese_Odon = db_sonde_synthese[db_sonde_synthese$id_sonde == 812 |
                                                   db_sonde_synthese$id_sonde == 813 |
                                                   db_sonde_synthese$id_sonde == 814 |
                                                   db_sonde_synthese$id_sonde == 815 |
                                                   db_sonde_synthese$id_sonde == 816 ,]
    output$map_Odon <- renderLeaflet({

        leaflet() %>%
            addTiles() %>%
            addAwesomeMarkers(data = db_sonde_synthese_Odon,
                              lng=db_sonde_synthese_Odon$longitude,lat=db_sonde_synthese_Odon$latitude,
                              #layerId = map_Odon$id_sonde, group="DREAL",
                              icon=makeAwesomeIcon(icon='tint', library='glyphicon',
                                                   iconColor = 'white', markerColor = 'orange'),

                              popup =  paste(db_sonde_synthese_Odon$label,"<br>",
                                             "Distance à la source : ",db_sonde_synthese_Odon$distance_source," km" ))%>%

            addPolylines(data=coursEau2[coursEau2@data$Name== "Odon",],color="blue")

    })



    ################################
    # Tmoy + MM7
    ################################


    # Données moyenne journalière + MM7
    varSelecOdon <- reactiveValues(
        `Température minimale` = F,
        `Température moyenne` = T,
        `Température maximale` = F,
        `Température minimale MM7` = F,
        `Température moyenne MM7` = F,
        `Température maximale MM7` = F
    )
    vec_col_Teau =c("#A6CEE3", "#83e12f", "#FB9A99", "#1F78B4", "#33A02C", "#E31A1C")
    ##############
    # Sonde 812
    ##############


    output$Sonde812MM7 <- renderDygraph({
        if(varSelecOdon$`Température minimale` == FALSE &
           varSelecOdon$`Température moyenne`== FALSE &
           varSelecOdon$`Température maximale` == FALSE &
           varSelecOdon$`Température minimale MM7` == FALSE &
           varSelecOdon$`Température moyenne MM7` == FALSE &
           varSelecOdon$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==812),]$date)),
                            order.by = db2[which(db2$id_sonde==812),]$date
            )
        }
        else{
            serie_xts =  db_Odon_xtsa[db_Odon_xtsa$id_sonde == 812 ,c(varSelecOdon$`Température minimale`,varSelecOdon$`Température moyenne`,varSelecOdon$`Température maximale`,
                                                                      varSelecOdon$`Température minimale MM7`,varSelecOdon$`Température moyenne MM7`,varSelecOdon$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,25.5))

        y_min = min(db_Odon_xtsa[db_Odon_xtsa$id_sonde == 812]$`Température maximale`)-2
        y_max = max(db_Odon_xtsa[db_Odon_xtsa$id_sonde == 812]$`Température maximale`)+2

        if(varSelecOdon$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==812,]$date), max(db2[db2$id_sonde==812,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)])

        }
        else if(varSelecOdon$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==812,]$date), max(db2[db2$id_sonde==812,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(25.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 25.5, color="#ff7a7a", axis="y") %>%
                dyShading(25.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==812,]$date), max(db2[db2$id_sonde==812,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })


    observeEvent(input$Teau_minOdon, {
        varSelecOdon$`Température minimale` = input$Teau_minOdon
    })

    observeEvent(input$Teau_moyOdon, {
        varSelecOdon$`Température moyenne` = input$Teau_moyOdon
    })

    observeEvent(input$Teau_maxOdon, {
        varSelecOdon$`Température maximale` = input$Teau_maxOdon
    })

    observeEvent(input$Teau_minMM7Odon, {
        varSelecOdon$`Température minimale MM7` = input$Teau_minMM7Odon
    })
    observeEvent(input$Teau_moyMM7Odon, {
        varSelecOdon$`Température moyenne MM7` = input$Teau_moyMM7Odon
    })
    observeEvent(input$Teau_maxMM7Odon, {
        varSelecOdon$`Température maximale MM7` = input$Teau_maxMM7Odon
    })
    observeEvent(input$preferendum_thOdon, {
        varSelecOdon$preferendum = input$preferendum_thOdon
    })


    ##############
    # Sonde 813
    ##############


    output$Sonde813MM7 <- renderDygraph({
        if(varSelecOdon$`Température minimale` == FALSE &
           varSelecOdon$`Température moyenne`== FALSE &
           varSelecOdon$`Température maximale` == FALSE &
           varSelecOdon$`Température minimale MM7` == FALSE &
           varSelecOdon$`Température moyenne MM7` == FALSE &
           varSelecOdon$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==813),]$date)),
                            order.by = db2[which(db2$id_sonde==813),]$date
            )
        }
        else{
            serie_xts =  db_Odon_xtsa[db_Odon_xtsa$id_sonde == 813 ,c(varSelecOdon$`Température minimale`,varSelecOdon$`Température moyenne`,varSelecOdon$`Température maximale`,
                                                                      varSelecOdon$`Température minimale MM7`,varSelecOdon$`Température moyenne MM7`,varSelecOdon$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,27.5))

        y_min = min(db_Odon_xtsa[db_Odon_xtsa$id_sonde == 813]$`Température maximale`)-4
        y_max = max(db_Odon_xtsa[db_Odon_xtsa$id_sonde == 813]$`Température maximale`)+2

        if(varSelecOdon$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==813,]$date), max(db2[db2$id_sonde==813,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)])

        }
        else if(varSelecOdon$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==813,]$date), max(db2[db2$id_sonde==813,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(27.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 27.5, color="#ff7a7a", axis="y") %>%
                dyShading(27.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==813,]$date), max(db2[db2$id_sonde==813,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })


    ##############
    # Sonde 814
    ##############
    output$Sonde814MM7 <- renderDygraph({
        if(varSelecOdon$`Température minimale` == FALSE &
           varSelecOdon$`Température moyenne`== FALSE &
           varSelecOdon$`Température maximale` == FALSE &
           varSelecOdon$`Température minimale MM7` == FALSE &
           varSelecOdon$`Température moyenne MM7` == FALSE &
           varSelecOdon$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==814),]$date)),
                            order.by = db2[which(db2$id_sonde==814),]$date
            )
        }
        else{
            serie_xts =  db_Odon_xtsa[db_Odon_xtsa$id_sonde == 814 ,c(varSelecOdon$`Température minimale`,varSelecOdon$`Température moyenne`,varSelecOdon$`Température maximale`,
                                                                      varSelecOdon$`Température minimale MM7`,varSelecOdon$`Température moyenne MM7`,varSelecOdon$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,28.5))

        y_min = min(db_Odon_xtsa[db_Odon_xtsa$id_sonde == 814]$`Température maximale`)-1
        y_max = max(db_Odon_xtsa[db_Odon_xtsa$id_sonde == 814]$`Température maximale`)+1

        if(varSelecOdon$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==814,]$date), max(db2[db2$id_sonde==814,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)])

        }
        else if(varSelecOdon$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==814,]$date), max(db2[db2$id_sonde==814,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(28.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 28.5, color="#ff7a7a", axis="y") %>%
                dyShading(28.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==814,]$date), max(db2[db2$id_sonde==814,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })


    ##############
    # Sonde 815
    ##############


    output$Sonde815MM7 <- renderDygraph({
        if(varSelecOdon$`Température minimale` == FALSE &
           varSelecOdon$`Température moyenne`== FALSE &
           varSelecOdon$`Température maximale` == FALSE &
           varSelecOdon$`Température minimale MM7` == FALSE &
           varSelecOdon$`Température moyenne MM7` == FALSE &
           varSelecOdon$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==815),]$date)),
                            order.by = db2[which(db2$id_sonde==815),]$date
            )
        }
        else{
            serie_xts =  db_Odon_xtsa[db_Odon_xtsa$id_sonde == 815 ,c(varSelecOdon$`Température minimale`,varSelecOdon$`Température moyenne`,varSelecOdon$`Température maximale`,
                                                                      varSelecOdon$`Température minimale MM7`,varSelecOdon$`Température moyenne MM7`,varSelecOdon$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,30.5))

        y_min = min(db_Odon_xtsa[db_Odon_xtsa$id_sonde == 815]$`Température maximale`)-3
        y_max = max(db_Odon_xtsa[db_Odon_xtsa$id_sonde == 815]$`Température maximale`)

        if(varSelecOdon$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==815,]$date), max(db2[db2$id_sonde==815,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)])

        }
        else if(varSelecOdon$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==815,]$date), max(db2[db2$id_sonde==815,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 30.5, color="#ff7a7a", axis="y") %>%
                dyShading(30.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==815,]$date), max(db2[db2$id_sonde==815,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })

    ##############
    # Sonde 816
    ##############

    output$Sonde816MM7 <- renderDygraph({
        if(varSelecOdon$`Température minimale` == FALSE &
           varSelecOdon$`Température moyenne`== FALSE &
           varSelecOdon$`Température maximale` == FALSE &
           varSelecOdon$`Température minimale MM7` == FALSE &
           varSelecOdon$`Température moyenne MM7` == FALSE &
           varSelecOdon$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==816),]$date)),
                            order.by = db2[which(db2$id_sonde==816),]$date
            )
        }
        else{
            serie_xts =  db_Odon_xtsa[db_Odon_xtsa$id_sonde == 816 ,c(varSelecOdon$`Température minimale`,varSelecOdon$`Température moyenne`,varSelecOdon$`Température maximale`,
                                                                      varSelecOdon$`Température minimale MM7`,varSelecOdon$`Température moyenne MM7`,varSelecOdon$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,30.5))

        y_min = min(db_Odon_xtsa[db_Odon_xtsa$id_sonde == 816]$`Température maximale`)-3
        y_max = max(db_Odon_xtsa[db_Odon_xtsa$id_sonde == 816]$`Température maximale`)

        if(varSelecOdon$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==816,]$date), max(db2[db2$id_sonde==816,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)])

        }
        else if(varSelecOdon$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==816,]$date), max(db2[db2$id_sonde==816,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 30.5, color="#ff7a7a", axis="y") %>%
                dyShading(30.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==816,]$date), max(db2[db2$id_sonde==816,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecOdon$`Température minimale`,
                                                  varSelecOdon$`Température moyenne`,
                                                  varSelecOdon$`Température maximale`,
                                                  varSelecOdon$`Température minimale MM7`,
                                                  varSelecOdon$`Température moyenne MM7`,
                                                  varSelecOdon$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })

    ################################
    # Fréquence
    ################################

    ####################
    # Tableau récap
    ####################

    output$TableOdonFreq = DT::renderDataTable(

        prefOdon,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )

    ####################
    # Histogrammes
    ####################
    colLimite = c("Seuil critique" = "#ff2a2a",
                  "Danger pour juvéniles"="#f5f544",
                  "Danger pour les embryons"="#dde02b",
                  "Seuil létal"="#f11111",
                  "Seuil létal juvéniles"="#f53c3c",
                  "Seuil létal adulte"="#f11111",
                  "Préférendum thermique"="#a1ec54",
                  "Sans Espèce"="blue")


    ##############
    # Sonde 812
    ##############
    db812 <-  db2[db2$id_sonde == 812,]
    dataHist812 <- reactive({
        df2 <- db812 %>%
            filter(Espece %in% input$EspeceOd)%>%
            filter(An >= input$AnHistOd[1] & An <= input$AnHistOd[2])

    })


    output$hist812 = renderPlotly({

        gghist812 <- dataHist812()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist812 <- ggplotly(gghist812)
    })

    ##############
    # Sonde 813
    ##############

    db813 <-  db2[db2$id_sonde == 813,]
    dataHist813 <- reactive({
        df2 <- db813 %>%
            filter(Espece %in% input$EspeceOd)%>%
            filter(An >= input$AnHistOd[1] & An <= input$AnHistOd[2])

    })

    output$hist813 = renderPlotly({

        gghist813 <- dataHist813()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist813 <- ggplotly(gghist813)
    })

    ##############
    # Sonde 814
    ##############


    db814 <-  db2[db2$id_sonde == 814,]
    dataHist814 <- reactive({
        df2 <- db814 %>%
            filter(Espece %in% input$EspeceOd)%>%
            filter(An >= input$AnHistOd[1] & An <= input$AnHistOd[2])
    })
    output$hist814 = renderPlotly({

        gghist814 <- dataHist814()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist814 <- ggplotly(gghist814)
    })

    ##############
    # Sonde 815
    ##############


    db815 <-  db2[db2$id_sonde == 815,]
    dataHist815 <- reactive({
        df2 <- db815%>%
            filter(Espece %in% input$EspeceOd)%>%
            filter(An >= input$AnHistOd[1] & An <= input$AnHistOd[2])
    })
    output$hist815 = renderPlotly({

        gghist815 <- dataHist815()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist815 <- ggplotly(gghist815)
    })



    ##############
    # Sonde 816
    ##############


    db816 <-  db2[db2$id_sonde == 816,]
    dataHist816 <- reactive({
        df2 <- db816%>%
            filter(Espece %in% input$EspeceOd)%>%
            filter(An >= input$AnHistOd[1] & An <= input$AnHistOd[2])
    })
    output$hist816 = renderPlotly({

        gghist816 <- dataHist816()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist816 <- ggplotly(gghist816)
    })

    ################################
    # Températures lissées sur 30 jours
    ################################
    # ------------------------------------------------------------ #

    # Températures lissées sur 30 jours
    # ------------------------------------------------------------ #

    varSelecOdonMM30 <- reactiveValues(
        `Température minimale MM30` = F,
        `Température moyenne MM30` = T,
        `Température maximale MM30` = F,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    observeEvent(input$Teau_minMM30Odon, {
        varSelecOdonMM30$`Température minimale MM30` = input$Teau_minMM30Odon
    })

    observeEvent(input$Teau_moyMM30Odon, {
        varSelecOdonMM30$`Température moyenne MM30` = input$Teau_moyMM30Odon
    })

    observeEvent(input$Teau_maxMM30Odon, {
        varSelecOdonMM30$`Température maximale MM30` = input$Teau_maxMM30Odon
    })

    observeEvent(input$Teau_minreg30Odon, {
        varSelecOdonMM30$`Régression températures min` = input$Teau_minreg30Odon
    })
    observeEvent(input$Teau_maxreg30Odon, {
        varSelecOdonMM30$`Régression températures max` = input$Teau_maxreg30Odon
    })


    vec_col_MM30 = c("blue", "green", "red", "blue", "red")

    ##############
    # Sonde 812
    #############

    output$Sonde812MM30 <- renderDygraph({
        if(varSelecOdonMM30$`Température minimale MM30` == FALSE &
           varSelecOdonMM30$`Température moyenne MM30`== FALSE &
           varSelecOdonMM30$`Température maximale MM30` == FALSE &
           varSelecOdonMM30$`Régression températures max` == FALSE &
           varSelecOdonMM30$`Régression températures min` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==812),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==812),]$date
            )
        }
        else{
            serie_xts = db_Odon_xtsb[db_Odon_xtsb$id_sonde == 812 ,c(varSelecOdonMM30$`Température minimale MM30`,varSelecOdonMM30$`Température moyenne MM30`,varSelecOdonMM30$`Température maximale MM30`,
                                                                     varSelecOdonMM30$`Régression températures min`,varSelecOdonMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Odon_xtsb[db_Odon_xtsb$id_sonde==812,]$`Température minimale MM30`)-1,
                         max(db_Odon_xtsb[db_Odon_xtsb$id_sonde==812,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==812,]$date), max(db2[db2$id_sonde==812,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOdonMM30$`Température minimale MM30`,
                                              varSelecOdonMM30$`Température moyenne MM30` ,
                                              varSelecOdonMM30$`Température maximale MM30` ,
                                              varSelecOdonMM30$`Régression températures min` ,
                                              varSelecOdonMM30$`Régression températures max`)])
    })



    #############
    # Sonde 813
    #############


    output$Sonde813MM30 <- renderDygraph({
        if(varSelecOdonMM30$`Température minimale MM30` == FALSE &
           varSelecOdonMM30$`Température moyenne MM30`== FALSE &
           varSelecOdonMM30$`Température maximale MM30` == FALSE &
           varSelecOdonMM30$`Régression températures min` == FALSE &
           varSelecOdonMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==813),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==813),]$date
            )
        }
        else{
            serie_xts = db_Odon_xtsb[db_Odon_xtsb$id_sonde == 813,c(varSelecOdonMM30$`Température minimale MM30`,varSelecOdonMM30$`Température moyenne MM30`,varSelecOdonMM30$`Température maximale MM30`,
                                                                    varSelecOdonMM30$`Régression températures min`,varSelecOdonMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Odon_xtsb[db_Odon_xtsb$id_sonde==813,]$`Température minimale MM30`)-1,
                         max(db_Odon_xtsb[db_Odon_xtsb$id_sonde==813,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==813,]$date), max(db2[db2$id_sonde==813,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOdonMM30$`Température minimale MM30`,
                                              varSelecOdonMM30$`Température moyenne MM30` ,
                                              varSelecOdonMM30$`Température maximale MM30` ,
                                              varSelecOdonMM30$`Régression températures min` ,
                                              varSelecOdonMM30$`Régression températures max`)])
    })


    #############
    # Sonde 814
    #############


    output$Sonde814MM30 <- renderDygraph({
        if(varSelecOdonMM30$`Température minimale MM30` == FALSE &
           varSelecOdonMM30$`Température moyenne MM30`== FALSE &
           varSelecOdonMM30$`Température maximale MM30` == FALSE &
           varSelecOdonMM30$`Régression températures min` == FALSE &
           varSelecOdonMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==814),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==814),]$date
            )
        }
        else{
            serie_xts = db_Odon_xtsb[db_Odon_xtsb$id_sonde == 814,c(varSelecOdonMM30$`Température minimale MM30`,varSelecOdonMM30$`Température moyenne MM30`,varSelecOdonMM30$`Température maximale MM30`,
                                                                    varSelecOdonMM30$`Régression températures min`,varSelecOdonMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Odon_xtsb[db_Odon_xtsb$id_sonde==814,]$`Température minimale MM30`)-1,
                         max(db_Odon_xtsb[db_Odon_xtsb$id_sonde==814,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==814,]$date), max(db2[db2$id_sonde==814,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOdonMM30$`Température minimale MM30`,
                                              varSelecOdonMM30$`Température moyenne MM30` ,
                                              varSelecOdonMM30$`Température maximale MM30` ,
                                              varSelecOdonMM30$`Régression températures min` ,
                                              varSelecOdonMM30$`Régression températures max`)])
    })


    #############
    # Sonde 815
    #############


    output$Sonde815MM30 <- renderDygraph({
        if(varSelecOdonMM30$`Température minimale MM30` == FALSE &
           varSelecOdonMM30$`Température moyenne MM30`== FALSE &
           varSelecOdonMM30$`Température maximale MM30` == FALSE &
           varSelecOdonMM30$`Régression températures min` == FALSE &
           varSelecOdonMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==815),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==815),]$date
            )
        }
        else{
            serie_xts = db_Odon_xtsb[db_Odon_xtsb$id_sonde == 815,c(varSelecOdonMM30$`Température minimale MM30`,varSelecOdonMM30$`Température moyenne MM30`,varSelecOdonMM30$`Température maximale MM30`,
                                                                    varSelecOdonMM30$`Régression températures min`,varSelecOdonMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Odon_xtsb[db_Odon_xtsb$id_sonde==815,]$`Température minimale MM30`)-1,
                         max(db_Odon_xtsb[db_Odon_xtsb$id_sonde==815,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==815,]$date), max(db2[db2$id_sonde==815,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOdonMM30$`Température minimale MM30`,
                                              varSelecOdonMM30$`Température moyenne MM30` ,
                                              varSelecOdonMM30$`Température maximale MM30` ,
                                              varSelecOdonMM30$`Régression températures min` ,
                                              varSelecOdonMM30$`Régression températures max`)])
    })


    #############
    # Sonde 816
    #############


    output$Sonde816MM30 <- renderDygraph({
        if(varSelecOdonMM30$`Température minimale MM30` == FALSE &
           varSelecOdonMM30$`Température moyenne MM30`== FALSE &
           varSelecOdonMM30$`Température maximale MM30` == FALSE &
           varSelecOdonMM30$`Régression températures min` == FALSE &
           varSelecOdonMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==816),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==816),]$date
            )
        }
        else{
            serie_xts = db_Odon_xtsb[db_Odon_xtsb$id_sonde == 816,c(varSelecOdonMM30$`Température minimale MM30`,varSelecOdonMM30$`Température moyenne MM30`,varSelecOdonMM30$`Température maximale MM30`,
                                                                    varSelecOdonMM30$`Régression températures min`,varSelecOdonMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Odon_xtsb[db_Odon_xtsb$id_sonde==816,]$`Température minimale MM30`)-1,
                         max(db_Odon_xtsb[db_Odon_xtsb$id_sonde==816,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==816,]$date), max(db2[db2$id_sonde==816,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOdonMM30$`Température minimale MM30`,
                                              varSelecOdonMM30$`Température moyenne MM30` ,
                                              varSelecOdonMM30$`Température maximale MM30` ,
                                              varSelecOdonMM30$`Régression températures min` ,
                                              varSelecOdonMM30$`Régression températures max`)])
    })





    ####################
    # Stats avec MM30 pour tableau récap moyenne mensuelle et annuelles
    ####################

    output$db_Odon_stats_MM30_An = DT::renderDataTable(

        db_Odon_stats_MM30_An,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )

    output$db_Odon_stats_MM30_mois = DT::renderDataTable(

        db_Odon_stats_MM30_mois,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )
    ################################
    # Températures lissées sur 365jours
    ################################

    # Températures lissées sur 365 jours
    # ------------------------------------------------------------ #

    varSelecOdonMM365 <- reactiveValues(
        `Température minimale MM365` = F,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = F,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    observeEvent(input$Teau_minMM365Odon, {
        varSelecOdonMM365$`Température minimale MM365` = input$Teau_minMM365Odon
    })

    observeEvent(input$Teau_moyMM365Odon, {
        varSelecOdonMM365$`Température moyenne MM365` = input$Teau_moyMM365Odon
    })

    observeEvent(input$Teau_maxMM365Odon, {
        varSelecOdonMM365$`Température maximale MM365` = input$Teau_maxMM365Odon
    })

    observeEvent(input$Teau_minreg365Odon, {
        varSelecOdonMM365$`Régression températures min` = input$Teau_minreg365Odon
    })
    observeEvent(input$Teau_maxreg365Odon, {
        varSelecOdonMM365$`Régression températures max` = input$Teau_maxreg365Odon
    })

    ##############
    # Sonde 812
    #############
    output$Sonde812MM365 <- renderDygraph({
        if(varSelecOdonMM365$`Température minimale MM365` == FALSE &
           varSelecOdonMM365$`Température moyenne MM365`== FALSE &
           varSelecOdonMM365$`Température maximale MM365` == FALSE &
           varSelecOdonMM365$`Régression températures min` == FALSE &
           varSelecOdonMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==812),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==812),]$date
            )
        }
        else{
            serie_xts = db_Odon_xtsc[db_Odon_xtsc$id_sonde == 812,c(varSelecOdonMM365$`Température minimale MM365`,varSelecOdonMM365$`Température moyenne MM365`,varSelecOdonMM365$`Température maximale MM365`,
                                                                    varSelecOdonMM365$`Régression températures min`,varSelecOdonMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Odon_xtsc[db_Odon_xtsc$id_sonde==812,]$`Température minimale MM365`)-2,
                         max(db_Odon_xtsc[db_Odon_xtsc$id_sonde==812,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==812,]$date), max(db2[db2$id_sonde==812,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOdonMM365$`Température minimale MM365`,
                                              varSelecOdonMM365$`Température moyenne MM365` ,
                                              varSelecOdonMM365$`Température maximale MM365` ,
                                              varSelecOdonMM365$`Régression températures min` ,
                                              varSelecOdonMM365$`Régression températures max`)])
    })





    ##############
    # Sonde 813
    #############


    output$Sonde813MM365 <- renderDygraph({
        if(varSelecOdonMM365$`Température minimale MM365` == FALSE &
           varSelecOdonMM365$`Température moyenne MM365`== FALSE &
           varSelecOdonMM365$`Température maximale MM365` == FALSE &
           varSelecOdonMM365$`Régression températures min` == FALSE &
           varSelecOdonMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==813),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==813),]$date
            )
        }
        else{
            serie_xts = db_Odon_xtsc[db_Odon_xtsc$id_sonde == 813,c(varSelecOdonMM365$`Température minimale MM365`,varSelecOdonMM365$`Température moyenne MM365`,varSelecOdonMM365$`Température maximale MM365`,
                                                                    varSelecOdonMM365$`Régression températures min`,varSelecOdonMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Odon_xtsc[db_Odon_xtsc$id_sonde==813,]$`Température minimale MM365`)-2,
                         max(db_Odon_xtsc[db_Odon_xtsc$id_sonde==813,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==813,]$date), max(db2[db2$id_sonde==813,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOdonMM365$`Température minimale MM365`,
                                              varSelecOdonMM365$`Température moyenne MM365` ,
                                              varSelecOdonMM365$`Température maximale MM365`,
                                              varSelecOdonMM365$`Régression températures min`,
                                              varSelecOdonMM365$`Régression températures max`)])
    })


    ##############
    # Sonde 814
    #############

    varSelecOdonMM365 <- reactiveValues(
        `Température minimale MM365` = T,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = T,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    output$Sonde814MM365 <- renderDygraph({
        if(varSelecOdonMM365$`Température minimale MM365` == FALSE &
           varSelecOdonMM365$`Température moyenne MM365`== FALSE &
           varSelecOdonMM365$`Température maximale MM365` == FALSE &
           varSelecOdonMM365$`Régression températures min` == FALSE &
           varSelecOdonMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==814),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==814),]$date
            )
        }
        else{
            serie_xts = db_Odon_xtsc[db_Odon_xtsc$id_sonde == 814,c(varSelecOdonMM365$`Température minimale MM365`,varSelecOdonMM365$`Température moyenne MM365`,varSelecOdonMM365$`Température maximale MM365`,
                                                                    varSelecOdonMM365$`Régression températures min`,varSelecOdonMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)",valueRange =
                       c(min(db_Odon_xtsc[db_Odon_xtsc$id_sonde==814,]$`Température minimale MM365`)-2,
                         max(db_Odon_xtsc[db_Odon_xtsc$id_sonde==814,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==814,]$date), max(db2[db2$id_sonde==814,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOdonMM365$`Température minimale MM365`,
                                              varSelecOdonMM365$`Température moyenne MM365`,
                                              varSelecOdonMM365$`Température maximale MM365`,
                                              varSelecOdonMM365$`Régression températures min`,
                                              varSelecOdonMM365$`Régression températures max`)])
    })


    ##############
    # Sonde 815
    #############

    varSelecOdonMM365 <- reactiveValues(
        `Température minimale MM365` = T,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = T,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    output$Sonde815MM365 <- renderDygraph({
        if(varSelecOdonMM365$`Température minimale MM365` == FALSE &
           varSelecOdonMM365$`Température moyenne MM365`== FALSE &
           varSelecOdonMM365$`Température maximale MM365` == FALSE &
           varSelecOdonMM365$`Régression températures min` == FALSE &
           varSelecOdonMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==815),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==815),]$date
            )
        }
        else{
            serie_xts = db_Odon_xtsc[db_Odon_xtsc$id_sonde == 815,c(varSelecOdonMM365$`Température minimale MM365`,varSelecOdonMM365$`Température moyenne MM365`,varSelecOdonMM365$`Température maximale MM365`,
                                                                    varSelecOdonMM365$`Régression températures min`,varSelecOdonMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Odon_xtsc[db_Odon_xtsc$id_sonde==815,]$`Température minimale MM365`)-2,
                         max(db_Odon_xtsc[db_Odon_xtsc$id_sonde==815,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==815,]$date), max(db2[db2$id_sonde==815,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOdonMM365$`Température minimale MM365`,
                                              varSelecOdonMM365$`Température moyenne MM365` ,
                                              varSelecOdonMM365$`Température maximale MM365`,
                                              varSelecOdonMM365$`Régression températures min`,
                                              varSelecOdonMM365$`Régression températures max`)])
    })

    ##############
    # Sonde 816
    #############

    varSelecOdonMM365 <- reactiveValues(
        `Température minimale MM365` = T,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = T,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    output$Sonde816MM365 <- renderDygraph({
        if(varSelecOdonMM365$`Température minimale MM365` == FALSE &
           varSelecOdonMM365$`Température moyenne MM365`== FALSE &
           varSelecOdonMM365$`Température maximale MM365` == FALSE &
           varSelecOdonMM365$`Régression températures min` == FALSE &
           varSelecOdonMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==816),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==816),]$date
            )
        }
        else{
            serie_xts = db_Odon_xtsc[db_Odon_xtsc$id_sonde == 816,c(varSelecOdonMM365$`Température minimale MM365`,varSelecOdonMM365$`Température moyenne MM365`,varSelecOdonMM365$`Température maximale MM365`,
                                                                    varSelecOdonMM365$`Régression températures min`,varSelecOdonMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Odon_xtsc[db_Odon_xtsc$id_sonde==816,]$`Température minimale MM365`)-2,
                         max(db_Odon_xtsc[db_Odon_xtsc$id_sonde==816,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==816,]$date), max(db2[db2$id_sonde==816,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecOdonMM365$`Température minimale MM365`,
                                              varSelecOdonMM365$`Température moyenne MM365` ,
                                              varSelecOdonMM365$`Température maximale MM365`,
                                              varSelecOdonMM365$`Régression températures min`,
                                              varSelecOdonMM365$`Régression températures max`)])
    })

    ################################
    # Régressions
    ################################

    ##############
    # Reg Odon 812
    #############


    output$Reg812 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 812,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"812"],
                        slope = dataRegCoeff[2,"812"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })

    ##############
    # Reg Odon 813
    #############


    output$Reg813 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 813,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"813"],
                        slope = dataRegCoeff[2,"813"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })

    ##############
    # Reg Odon 814
    #############


    output$Reg814 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 814,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"814"],
                        slope = dataRegCoeff[2,"814"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })

    ##############
    # Reg Odon 815
    #############


    output$Reg815 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 815,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"815"],
                        slope = dataRegCoeff[2,"815"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })





    ##############
    # Reg Odon 816
    #############


    output$Reg816 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 816,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"816"],
                        slope = dataRegCoeff[2,"816"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })


    ##########################################
    # Sélune
    ##########################################

    ################################
    # Description
    ################################

    output$StatsDescSelune = DT::renderDataTable(

        db_stats_Selune,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )




    db_sonde_synthese_Selune = db_sonde_synthese[db_sonde_synthese$id_sonde == 824 |
                                                     db_sonde_synthese$id_sonde == 821 |
                                                     db_sonde_synthese$id_sonde == 822 |
                                                     db_sonde_synthese$id_sonde == 820 |
                                                     db_sonde_synthese$id_sonde == 823 ,]
    output$map_Selune <- renderLeaflet({

        leaflet() %>%
            addTiles() %>%
            addAwesomeMarkers(data = db_sonde_synthese_Selune,
                              lng=db_sonde_synthese_Selune$longitude,lat=db_sonde_synthese_Selune$latitude,
                              #layerId = map_Selune$id_sonde, group="DREAL",
                              icon=makeAwesomeIcon(icon='tint', library='glyphicon',
                                                   iconColor = 'white', markerColor = 'orange'),

                              popup =  paste(db_sonde_synthese_Selune$label,"<br>",
                                             "Distance à la source : ",db_sonde_synthese_Selune$distance_source," km" ))%>%

            addPolylines(data=coursEau2[coursEau2@data$Name== "Selune",],color="blue")

    })



    ################################
    # Tmoy + MM7
    ################################


    # Données moyenne journalière + MM7
    varSelecSelune <- reactiveValues(
        `Température minimale` = F,
        `Température moyenne` = T,
        `Température maximale` = F,
        `Température minimale MM7` = F,
        `Température moyenne MM7` = F,
        `Température maximale MM7` = F
    )
    vec_col_Teau =c("#A6CEE3", "#83e12f", "#FB9A99", "#1F78B4", "#33A02C", "#E31A1C")
    ##############
    # Sonde 824
    ##############


    output$Sonde824MM7 <- renderDygraph({
        if(varSelecSelune$`Température minimale` == FALSE &
           varSelecSelune$`Température moyenne`== FALSE &
           varSelecSelune$`Température maximale` == FALSE &
           varSelecSelune$`Température minimale MM7` == FALSE &
           varSelecSelune$`Température moyenne MM7` == FALSE &
           varSelecSelune$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==824),]$date)),
                            order.by = db2[which(db2$id_sonde==824),]$date
            )
        }
        else{
            serie_xts =  db_Selune_xtsa[db_Selune_xtsa$id_sonde == 824 ,c(varSelecSelune$`Température minimale`,varSelecSelune$`Température moyenne`,varSelecSelune$`Température maximale`,
                                                                          varSelecSelune$`Température minimale MM7`,varSelecSelune$`Température moyenne MM7`,varSelecSelune$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,25.5))

        y_min = min(db_Selune_xtsa[db_Selune_xtsa$id_sonde == 824]$`Température maximale`)-2
        y_max = max(db_Selune_xtsa[db_Selune_xtsa$id_sonde == 824]$`Température maximale`)+2

        if(varSelecSelune$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==824,]$date), max(db2[db2$id_sonde==824,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)])

        }
        else if(varSelecSelune$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==824,]$date), max(db2[db2$id_sonde==824,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(25.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 25.5, color="#ff7a7a", axis="y") %>%
                dyShading(25.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==824,]$date), max(db2[db2$id_sonde==824,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })


    observeEvent(input$Teau_minSelune, {
        varSelecSelune$`Température minimale` = input$Teau_minSelune
    })

    observeEvent(input$Teau_moySelune, {
        varSelecSelune$`Température moyenne` = input$Teau_moySelune
    })

    observeEvent(input$Teau_maxSelune, {
        varSelecSelune$`Température maximale` = input$Teau_maxSelune
    })

    observeEvent(input$Teau_minMM7Selune, {
        varSelecSelune$`Température minimale MM7` = input$Teau_minMM7Selune
    })
    observeEvent(input$Teau_moyMM7Selune, {
        varSelecSelune$`Température moyenne MM7` = input$Teau_moyMM7Selune
    })
    observeEvent(input$Teau_maxMM7Selune, {
        varSelecSelune$`Température maximale MM7` = input$Teau_maxMM7Selune
    })
    observeEvent(input$preferendum_thSelune, {
        varSelecSelune$preferendum = input$preferendum_thSelune
    })


    ##############
    # Sonde 821
    ##############


    output$Sonde821MM7 <- renderDygraph({
        if(varSelecSelune$`Température minimale` == FALSE &
           varSelecSelune$`Température moyenne`== FALSE &
           varSelecSelune$`Température maximale` == FALSE &
           varSelecSelune$`Température minimale MM7` == FALSE &
           varSelecSelune$`Température moyenne MM7` == FALSE &
           varSelecSelune$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==821),]$date)),
                            order.by = db2[which(db2$id_sonde==821),]$date
            )
        }
        else{
            serie_xts =  db_Selune_xtsa[db_Selune_xtsa$id_sonde == 821 ,c(varSelecSelune$`Température minimale`,varSelecSelune$`Température moyenne`,varSelecSelune$`Température maximale`,
                                                                          varSelecSelune$`Température minimale MM7`,varSelecSelune$`Température moyenne MM7`,varSelecSelune$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,27.5))

        y_min = min(db_Selune_xtsa[db_Selune_xtsa$id_sonde == 821]$`Température maximale`)-4
        y_max = max(db_Selune_xtsa[db_Selune_xtsa$id_sonde == 821]$`Température maximale`)+2

        if(varSelecSelune$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==821,]$date), max(db2[db2$id_sonde==821,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)])

        }
        else if(varSelecSelune$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==821,]$date), max(db2[db2$id_sonde==821,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(27.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 27.5, color="#ff7a7a", axis="y") %>%
                dyShading(27.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==821,]$date), max(db2[db2$id_sonde==821,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })


    ##############
    # Sonde 822
    ##############
    output$Sonde822MM7 <- renderDygraph({
        if(varSelecSelune$`Température minimale` == FALSE &
           varSelecSelune$`Température moyenne`== FALSE &
           varSelecSelune$`Température maximale` == FALSE &
           varSelecSelune$`Température minimale MM7` == FALSE &
           varSelecSelune$`Température moyenne MM7` == FALSE &
           varSelecSelune$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==822),]$date)),
                            order.by = db2[which(db2$id_sonde==822),]$date
            )
        }
        else{
            serie_xts =  db_Selune_xtsa[db_Selune_xtsa$id_sonde == 822 ,c(varSelecSelune$`Température minimale`,varSelecSelune$`Température moyenne`,varSelecSelune$`Température maximale`,
                                                                          varSelecSelune$`Température minimale MM7`,varSelecSelune$`Température moyenne MM7`,varSelecSelune$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,28.5))

        y_min = min(db_Selune_xtsa[db_Selune_xtsa$id_sonde == 822]$`Température maximale`)-1
        y_max = max(db_Selune_xtsa[db_Selune_xtsa$id_sonde == 822]$`Température maximale`)+1

        if(varSelecSelune$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==822,]$date), max(db2[db2$id_sonde==822,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)])

        }
        else if(varSelecSelune$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==822,]$date), max(db2[db2$id_sonde==822,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(28.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 28.5, color="#ff7a7a", axis="y") %>%
                dyShading(28.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==822,]$date), max(db2[db2$id_sonde==822,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })

    ##############
    # Sonde 820
    ##############


    output$Sonde820MM7 <- renderDygraph({
        if(varSelecSelune$`Température minimale` == FALSE &
           varSelecSelune$`Température moyenne`== FALSE &
           varSelecSelune$`Température maximale` == FALSE &
           varSelecSelune$`Température minimale MM7` == FALSE &
           varSelecSelune$`Température moyenne MM7` == FALSE &
           varSelecSelune$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==820),]$date)),
                            order.by = db2[which(db2$id_sonde==820),]$date
            )
        }
        else{
            serie_xts =  db_Selune_xtsa[db_Selune_xtsa$id_sonde == 820 ,c(varSelecSelune$`Température minimale`,varSelecSelune$`Température moyenne`,varSelecSelune$`Température maximale`,
                                                                          varSelecSelune$`Température minimale MM7`,varSelecSelune$`Température moyenne MM7`,varSelecSelune$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,30.5))

        y_min = min(db_Selune_xtsa[db_Selune_xtsa$id_sonde == 820]$`Température maximale`)-3
        y_max = max(db_Selune_xtsa[db_Selune_xtsa$id_sonde == 820]$`Température maximale`)

        if(varSelecSelune$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==820,]$date), max(db2[db2$id_sonde==820,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)])

        }
        else if(varSelecSelune$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==820,]$date), max(db2[db2$id_sonde==820,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 30.5, color="#ff7a7a", axis="y") %>%
                dyShading(30.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==820,]$date), max(db2[db2$id_sonde==820,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })

    ##############
    # Sonde 823
    ##############

    output$Sonde823MM7 <- renderDygraph({
        if(varSelecSelune$`Température minimale` == FALSE &
           varSelecSelune$`Température moyenne`== FALSE &
           varSelecSelune$`Température maximale` == FALSE &
           varSelecSelune$`Température minimale MM7` == FALSE &
           varSelecSelune$`Température moyenne MM7` == FALSE &
           varSelecSelune$`Température maximale MM7` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==823),]$date)),
                            order.by = db2[which(db2$id_sonde==823),]$date
            )
        }
        else{
            serie_xts =  db_Selune_xtsa[db_Selune_xtsa$id_sonde == 823 ,c(varSelecSelune$`Température minimale`,varSelecSelune$`Température moyenne`,varSelecSelune$`Température maximale`,
                                                                          varSelecSelune$`Température minimale MM7`,varSelecSelune$`Température moyenne MM7`,varSelecSelune$`Température maximale MM7`, F)]

        }

        check <- as.data.frame(c(0.5,4.5,16.5,19.5,30.5))

        y_min = min(db_Selune_xtsa[db_Selune_xtsa$id_sonde == 823]$`Température maximale`)-3
        y_max = max(db_Selune_xtsa[db_Selune_xtsa$id_sonde == 823]$`Température maximale`)

        if(varSelecSelune$preferendum == "rien"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = TRUE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==823,]$date), max(db2[db2$id_sonde==823,]$date)),
                       drawGrid = TRUE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)])

        }
        else if(varSelecSelune$preferendum == "truite"){
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==823,]$date), max(db2[db2$id_sonde==823,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyLimit(0.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(4.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(16.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "seuil critique", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 1, color="#f53838", axis="y") %>%
                dyShading(0.5, 4.5, color="#fafa6e", axis="y") %>%
                dyShading(4.5, 16.5, color="#cafe95", axis="y") %>%
                dyShading(16.5, 19.5, color="#fafa6e", axis="y") %>%
                dyShading(19.5, 30.5, color="#ff7a7a", axis="y") %>%
                dyShading(30.5, 40, color="#f53838", axis="y")

        }
        else{
            dygraph(serie_xts, main = "")%>%
                dyAxis("y", label = "Température (en °C)", valueRange = c(y_min, y_max), drawGrid = FALSE) %>%
                dyAxis("x", label = "Temps",
                       #valueRange = c(min(db2[db2$id_sonde==823,]$date), max(db2[db2$id_sonde==823,]$date)),
                       drawGrid = FALSE) %>%
                dyRangeSelector()%>%
                dyHighlight(highlightCircleSize = 5,
                            highlightSeriesBackgroundAlpha = 0.4,
                            highlightSeriesOpts = list(strokeWidth = 1),
                            hideOnMouseOut = TRUE) %>%
                dyOptions(colors = vec_col_Teau[c(varSelecSelune$`Température minimale`,
                                                  varSelecSelune$`Température moyenne`,
                                                  varSelecSelune$`Température maximale`,
                                                  varSelecSelune$`Température minimale MM7`,
                                                  varSelecSelune$`Température moyenne MM7`,
                                                  varSelecSelune$`Température maximale MM7`)]) %>%
                dyLimit(y_min, "seuil létal adulte", labelLoc = "right", color = "gray18") %>%
                dyLimit(2.5, "seuil létal juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(5.5, "danger pour juvéniles", labelLoc = "right", color = "gray18") %>%
                dyLimit(9.5, "préférendum thermique", labelLoc = "right", color = "gray18") %>%
                dyLimit(19.5, "danger pour les embryons", labelLoc = "right", color = "gray18") %>%
                dyLimit(24.5, "danger pour les larves", labelLoc = "right", color = "gray18") %>%
                dyLimit(30.5, "seuil létal", labelLoc = "right", color = "gray18") %>%
                dyShading(y_min, 2.5, color="#f53838", axis="y") %>%
                dyShading(2.5, 5.5, color="#ff7a7a", axis="y") %>%
                dyShading(5.5, 9.5, color="#fafa6e", axis="y") %>%
                dyShading(9.5, 19.5, color="#cafe95", axis="y") %>%
                dyShading(19.5, 24.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 30.5, color="#fafa6e", axis="y") %>%
                dyShading(24.5, 40, color="#f53838", axis="y")

        }


    })

    ################################
    # Fréquence
    ################################

    ####################
    # Tableau récap
    ####################

    output$TableSeluneFreq = DT::renderDataTable(

        prefSelune,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )

    ####################
    # Histogrammes
    ####################
    colLimite = c("Seuil critique" = "#ff2a2a",
                  "Danger pour juvéniles"="#f5f544",
                  "Danger pour les embryons"="#dde02b",
                  "Seuil létal"="#f11111",
                  "Seuil létal juvéniles"="#f53c3c",
                  "Seuil létal adulte"="#f11111",
                  "Préférendum thermique"="#a1ec54",
                  "Sans Espèce"="blue")


    ##############
    # Sonde 824
    ##############
    db824 <-  db2[db2$id_sonde == 824,]
    dataHist824 <- reactive({
        df2 <- db824 %>%
            filter(Espece %in% input$EspeceSel)%>%
            filter(An >= input$AnHistSel[1] & An <= input$AnHistSel[2])

    })


    output$hist824 = renderPlotly({

        gghist824 <- dataHist824()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist824 <- ggplotly(gghist824)
    })

    ##############
    # Sonde 821
    ##############

    db821 <-  db2[db2$id_sonde == 821,]
    dataHist821 <- reactive({
        df2 <- db821 %>%
            filter(Espece %in% input$EspeceSel)%>%
            filter(An >= input$AnHistSel[1] & An <= input$AnHistSel[2])

    })

    output$hist821 = renderPlotly({

        gghist821 <- dataHist821()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist821 <- ggplotly(gghist821)
    })

    ##############
    # Sonde 822
    ##############


    db822 <-  db2[db2$id_sonde == 822,]
    dataHist822 <- reactive({
        df2 <- db822 %>%
            filter(Espece %in% input$EspeceSel)%>%
            filter(An >= input$AnHistSel[1] & An <= input$AnHistSel[2])
    })
    output$hist822 = renderPlotly({

        gghist822 <- dataHist822()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist822 <- ggplotly(gghist822)
    })

    ##############
    # Sonde 820
    ##############


    db820 <-  db2[db2$id_sonde == 820,]
    dataHist820 <- reactive({
        df2 <- db820%>%
            filter(Espece %in% input$EspeceSel)%>%
            filter(An >= input$AnHistSel[1] & An <= input$AnHistSel[2])
    })
    output$hist820 = renderPlotly({

        gghist820 <- dataHist820()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist820 <- ggplotly(gghist820)
    })



    ##############
    # Sonde 823
    ##############


    db823 <-  db2[db2$id_sonde == 823,]
    dataHist823 <- reactive({
        df2 <- db823%>%
            filter(Espece %in% input$EspeceSel)%>%
            filter(An >= input$AnHistSel[1] & An <= input$AnHistSel[2])
    })
    output$hist823 = renderPlotly({

        gghist823 <- dataHist823()%>%
            ggplot(aes(x=`Température moyenne`,color=Pref,fill=Pref))+
            geom_histogram(position="identity",alpha=0.5,binwidth = 0.5)+
            labs( #title="Séries brutes des taux d'incidences : ",
                x="Température de l'eau (en °C)",
                y="Nombre d'occurences\n(Sur les  moyennes journalières)")+
            #ylim(0.5,500)+
            scale_color_manual(values =colLimite) +
            scale_fill_manual(values =colLimite ) +

            theme_minimal()+
            theme(legend.title = element_blank())

        gghist823 <- ggplotly(gghist823)
    })

    ################################
    # Températures lissées sur 30 jours
    ################################
    # ------------------------------------------------------------ #

    # Températures lissées sur 30 jours
    # ------------------------------------------------------------ #

    varSelecSeluneMM30 <- reactiveValues(
        `Température minimale MM30` = F,
        `Température moyenne MM30` = T,
        `Température maximale MM30` = F,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    observeEvent(input$Teau_minMM30Selune, {
        varSelecSeluneMM30$`Température minimale MM30` = input$Teau_minMM30Selune
    })

    observeEvent(input$Teau_moyMM30Selune, {
        varSelecSeluneMM30$`Température moyenne MM30` = input$Teau_moyMM30Selune
    })

    observeEvent(input$Teau_maxMM30Selune, {
        varSelecSeluneMM30$`Température maximale MM30` = input$Teau_maxMM30Selune
    })

    observeEvent(input$Teau_minreg30Selune, {
        varSelecSeluneMM30$`Régression températures min` = input$Teau_minreg30Selune
    })
    observeEvent(input$Teau_maxreg30Selune, {
        varSelecSeluneMM30$`Régression températures max` = input$Teau_maxreg30Selune
    })


    vec_col_MM30 = c("blue", "green", "red", "blue", "red")

    ##############
    # Sonde 824
    #############

    output$Sonde824MM30 <- renderDygraph({
        if(varSelecSeluneMM30$`Température minimale MM30` == FALSE &
           varSelecSeluneMM30$`Température moyenne MM30`== FALSE &
           varSelecSeluneMM30$`Température maximale MM30` == FALSE &
           varSelecSeluneMM30$`Régression températures max` == FALSE &
           varSelecSeluneMM30$`Régression températures min` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==824),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==824),]$date
            )
        }
        else{
            serie_xts = db_Selune_xtsb[db_Selune_xtsb$id_sonde == 824 ,c(varSelecSeluneMM30$`Température minimale MM30`,varSelecSeluneMM30$`Température moyenne MM30`,varSelecSeluneMM30$`Température maximale MM30`,
                                                                         varSelecSeluneMM30$`Régression températures min`,varSelecSeluneMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Selune_xtsb[db_Selune_xtsb$id_sonde==824,]$`Température minimale MM30`)-1,
                         max(db_Selune_xtsb[db_Selune_xtsb$id_sonde==824,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==824,]$date), max(db2[db2$id_sonde==824,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecSeluneMM30$`Température minimale MM30`,
                                              varSelecSeluneMM30$`Température moyenne MM30` ,
                                              varSelecSeluneMM30$`Température maximale MM30` ,
                                              varSelecSeluneMM30$`Régression températures min` ,
                                              varSelecSeluneMM30$`Régression températures max`)])
    })



    #############
    # Sonde 821
    #############


    output$Sonde821MM30 <- renderDygraph({
        if(varSelecSeluneMM30$`Température minimale MM30` == FALSE &
           varSelecSeluneMM30$`Température moyenne MM30`== FALSE &
           varSelecSeluneMM30$`Température maximale MM30` == FALSE &
           varSelecSeluneMM30$`Régression températures min` == FALSE &
           varSelecSeluneMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==821),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==821),]$date
            )
        }
        else{
            serie_xts = db_Selune_xtsb[db_Selune_xtsb$id_sonde == 821,c(varSelecSeluneMM30$`Température minimale MM30`,varSelecSeluneMM30$`Température moyenne MM30`,varSelecSeluneMM30$`Température maximale MM30`,
                                                                        varSelecSeluneMM30$`Régression températures min`,varSelecSeluneMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Selune_xtsb[db_Selune_xtsb$id_sonde==821,]$`Température minimale MM30`)-1,
                         max(db_Selune_xtsb[db_Selune_xtsb$id_sonde==821,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==821,]$date), max(db2[db2$id_sonde==821,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecSeluneMM30$`Température minimale MM30`,
                                              varSelecSeluneMM30$`Température moyenne MM30` ,
                                              varSelecSeluneMM30$`Température maximale MM30` ,
                                              varSelecSeluneMM30$`Régression températures min` ,
                                              varSelecSeluneMM30$`Régression températures max`)])
    })


    #############
    # Sonde 822
    #############


    output$Sonde822MM30 <- renderDygraph({
        if(varSelecSeluneMM30$`Température minimale MM30` == FALSE &
           varSelecSeluneMM30$`Température moyenne MM30`== FALSE &
           varSelecSeluneMM30$`Température maximale MM30` == FALSE &
           varSelecSeluneMM30$`Régression températures min` == FALSE &
           varSelecSeluneMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==822),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==822),]$date
            )
        }
        else{
            serie_xts = db_Selune_xtsb[db_Selune_xtsb$id_sonde == 822,c(varSelecSeluneMM30$`Température minimale MM30`,varSelecSeluneMM30$`Température moyenne MM30`,varSelecSeluneMM30$`Température maximale MM30`,
                                                                        varSelecSeluneMM30$`Régression températures min`,varSelecSeluneMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Selune_xtsb[db_Selune_xtsb$id_sonde==822,]$`Température minimale MM30`)-1,
                         max(db_Selune_xtsb[db_Selune_xtsb$id_sonde==822,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==822,]$date), max(db2[db2$id_sonde==822,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecSeluneMM30$`Température minimale MM30`,
                                              varSelecSeluneMM30$`Température moyenne MM30` ,
                                              varSelecSeluneMM30$`Température maximale MM30` ,
                                              varSelecSeluneMM30$`Régression températures min` ,
                                              varSelecSeluneMM30$`Régression températures max`)])
    })


    #############
    # Sonde 820
    #############


    output$Sonde820MM30 <- renderDygraph({
        if(varSelecSeluneMM30$`Température minimale MM30` == FALSE &
           varSelecSeluneMM30$`Température moyenne MM30`== FALSE &
           varSelecSeluneMM30$`Température maximale MM30` == FALSE &
           varSelecSeluneMM30$`Régression températures min` == FALSE &
           varSelecSeluneMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==820),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==820),]$date
            )
        }
        else{
            serie_xts = db_Selune_xtsb[db_Selune_xtsb$id_sonde == 820,c(varSelecSeluneMM30$`Température minimale MM30`,varSelecSeluneMM30$`Température moyenne MM30`,varSelecSeluneMM30$`Température maximale MM30`,
                                                                        varSelecSeluneMM30$`Régression températures min`,varSelecSeluneMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Selune_xtsb[db_Selune_xtsb$id_sonde==820,]$`Température minimale MM30`)-1,
                         max(db_Selune_xtsb[db_Selune_xtsb$id_sonde==820,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==820,]$date), max(db2[db2$id_sonde==820,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecSeluneMM30$`Température minimale MM30`,
                                              varSelecSeluneMM30$`Température moyenne MM30` ,
                                              varSelecSeluneMM30$`Température maximale MM30` ,
                                              varSelecSeluneMM30$`Régression températures min` ,
                                              varSelecSeluneMM30$`Régression températures max`)])
    })


    #############
    # Sonde 823
    #############


    output$Sonde823MM30 <- renderDygraph({
        if(varSelecSeluneMM30$`Température minimale MM30` == FALSE &
           varSelecSeluneMM30$`Température moyenne MM30`== FALSE &
           varSelecSeluneMM30$`Température maximale MM30` == FALSE &
           varSelecSeluneMM30$`Régression températures min` == FALSE &
           varSelecSeluneMM30$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==823),]$`Température minimale MM30`)),
                            order.by = db2[which(db2$id_sonde==823),]$date
            )
        }
        else{
            serie_xts = db_Selune_xtsb[db_Selune_xtsb$id_sonde == 823,c(varSelecSeluneMM30$`Température minimale MM30`,varSelecSeluneMM30$`Température moyenne MM30`,varSelecSeluneMM30$`Température maximale MM30`,
                                                                        varSelecSeluneMM30$`Régression températures min`,varSelecSeluneMM30$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Selune_xtsb[db_Selune_xtsb$id_sonde==823,]$`Température minimale MM30`)-1,
                         max(db_Selune_xtsb[db_Selune_xtsb$id_sonde==823,]$`Température maximale MM30`)+4)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==823,]$date), max(db2[db2$id_sonde==823,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecSeluneMM30$`Température minimale MM30`,
                                              varSelecSeluneMM30$`Température moyenne MM30` ,
                                              varSelecSeluneMM30$`Température maximale MM30` ,
                                              varSelecSeluneMM30$`Régression températures min` ,
                                              varSelecSeluneMM30$`Régression températures max`)])
    })





    ####################
    # Stats avec MM30 pour tableau récap moyenne mensuelle et annuelles
    ####################

    output$db_Selune_stats_MM30_An = DT::renderDataTable(

        db_Selune_stats_MM30_An,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )

    output$db_Selune_stats_MM30_mois = DT::renderDataTable(

        db_Selune_stats_MM30_mois,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )
    ################################
    # Températures lissées sur 365jours
    ################################

    # Températures lissées sur 365 jours
    # ------------------------------------------------------------ #

    varSelecSeluneMM365 <- reactiveValues(
        `Température minimale MM365` = F,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = F,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    observeEvent(input$Teau_minMM365Selune, {
        varSelecSeluneMM365$`Température minimale MM365` = input$Teau_minMM365Selune
    })

    observeEvent(input$Teau_moyMM365Selune, {
        varSelecSeluneMM365$`Température moyenne MM365` = input$Teau_moyMM365Selune
    })

    observeEvent(input$Teau_maxMM365Selune, {
        varSelecSeluneMM365$`Température maximale MM365` = input$Teau_maxMM365Selune
    })

    observeEvent(input$Teau_minreg365Selune, {
        varSelecSeluneMM365$`Régression températures min` = input$Teau_minreg365Selune
    })
    observeEvent(input$Teau_maxreg365Selune, {
        varSelecSeluneMM365$`Régression températures max` = input$Teau_maxreg365Selune
    })

    ##############
    # Sonde 824
    #############
    output$Sonde824MM365 <- renderDygraph({
        if(varSelecSeluneMM365$`Température minimale MM365` == FALSE &
           varSelecSeluneMM365$`Température moyenne MM365`== FALSE &
           varSelecSeluneMM365$`Température maximale MM365` == FALSE &
           varSelecSeluneMM365$`Régression températures min` == FALSE &
           varSelecSeluneMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==824),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==824),]$date
            )
        }
        else{
            serie_xts = db_Selune_xtsc[db_Selune_xtsc$id_sonde == 824,c(varSelecSeluneMM365$`Température minimale MM365`,varSelecSeluneMM365$`Température moyenne MM365`,varSelecSeluneMM365$`Température maximale MM365`,
                                                                        varSelecSeluneMM365$`Régression températures min`,varSelecSeluneMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Selune_xtsc[db_Selune_xtsc$id_sonde==824,]$`Température minimale MM365`)-2,
                         max(db_Selune_xtsc[db_Selune_xtsc$id_sonde==824,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==824,]$date), max(db2[db2$id_sonde==824,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecSeluneMM365$`Température minimale MM365`,
                                              varSelecSeluneMM365$`Température moyenne MM365` ,
                                              varSelecSeluneMM365$`Température maximale MM365` ,
                                              varSelecSeluneMM365$`Régression températures min` ,
                                              varSelecSeluneMM365$`Régression températures max`)])
    })





    ##############
    # Sonde 821
    #############


    output$Sonde821MM365 <- renderDygraph({
        if(varSelecSeluneMM365$`Température minimale MM365` == FALSE &
           varSelecSeluneMM365$`Température moyenne MM365`== FALSE &
           varSelecSeluneMM365$`Température maximale MM365` == FALSE &
           varSelecSeluneMM365$`Régression températures min` == FALSE &
           varSelecSeluneMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==821),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==821),]$date
            )
        }
        else{
            serie_xts = db_Selune_xtsc[db_Selune_xtsc$id_sonde == 821,c(varSelecSeluneMM365$`Température minimale MM365`,varSelecSeluneMM365$`Température moyenne MM365`,varSelecSeluneMM365$`Température maximale MM365`,
                                                                        varSelecSeluneMM365$`Régression températures min`,varSelecSeluneMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Selune_xtsc[db_Selune_xtsc$id_sonde==821,]$`Température minimale MM365`)-2,
                         max(db_Selune_xtsc[db_Selune_xtsc$id_sonde==821,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==821,]$date), max(db2[db2$id_sonde==821,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecSeluneMM365$`Température minimale MM365`,
                                              varSelecSeluneMM365$`Température moyenne MM365` ,
                                              varSelecSeluneMM365$`Température maximale MM365`,
                                              varSelecSeluneMM365$`Régression températures min`,
                                              varSelecSeluneMM365$`Régression températures max`)])
    })


    ##############
    # Sonde 822
    #############

    varSelecSeluneMM365 <- reactiveValues(
        `Température minimale MM365` = T,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = T,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    output$Sonde822MM365 <- renderDygraph({
        if(varSelecSeluneMM365$`Température minimale MM365` == FALSE &
           varSelecSeluneMM365$`Température moyenne MM365`== FALSE &
           varSelecSeluneMM365$`Température maximale MM365` == FALSE &
           varSelecSeluneMM365$`Régression températures min` == FALSE &
           varSelecSeluneMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==822),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==822),]$date
            )
        }
        else{
            serie_xts = db_Selune_xtsc[db_Selune_xtsc$id_sonde == 822,c(varSelecSeluneMM365$`Température minimale MM365`,varSelecSeluneMM365$`Température moyenne MM365`,varSelecSeluneMM365$`Température maximale MM365`,
                                                                        varSelecSeluneMM365$`Régression températures min`,varSelecSeluneMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)",valueRange =
                       c(min(db_Selune_xtsc[db_Selune_xtsc$id_sonde==822,]$`Température minimale MM365`)-2,
                         max(db_Selune_xtsc[db_Selune_xtsc$id_sonde==822,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==822,]$date), max(db2[db2$id_sonde==822,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecSeluneMM365$`Température minimale MM365`,
                                              varSelecSeluneMM365$`Température moyenne MM365`,
                                              varSelecSeluneMM365$`Température maximale MM365`,
                                              varSelecSeluneMM365$`Régression températures min`,
                                              varSelecSeluneMM365$`Régression températures max`)])
    })


    ##############
    # Sonde 820
    #############

    varSelecSeluneMM365 <- reactiveValues(
        `Température minimale MM365` = T,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = T,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    output$Sonde820MM365 <- renderDygraph({
        if(varSelecSeluneMM365$`Température minimale MM365` == FALSE &
           varSelecSeluneMM365$`Température moyenne MM365`== FALSE &
           varSelecSeluneMM365$`Température maximale MM365` == FALSE &
           varSelecSeluneMM365$`Régression températures min` == FALSE &
           varSelecSeluneMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==820),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==820),]$date
            )
        }
        else{
            serie_xts = db_Selune_xtsc[db_Selune_xtsc$id_sonde == 820,c(varSelecSeluneMM365$`Température minimale MM365`,varSelecSeluneMM365$`Température moyenne MM365`,varSelecSeluneMM365$`Température maximale MM365`,
                                                                        varSelecSeluneMM365$`Régression températures min`,varSelecSeluneMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Selune_xtsc[db_Selune_xtsc$id_sonde==820,]$`Température minimale MM365`)-2,
                         max(db_Selune_xtsc[db_Selune_xtsc$id_sonde==820,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==820,]$date), max(db2[db2$id_sonde==820,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecSeluneMM365$`Température minimale MM365`,
                                              varSelecSeluneMM365$`Température moyenne MM365` ,
                                              varSelecSeluneMM365$`Température maximale MM365`,
                                              varSelecSeluneMM365$`Régression températures min`,
                                              varSelecSeluneMM365$`Régression températures max`)])
    })

    ##############
    # Sonde 823
    #############

    varSelecSeluneMM365 <- reactiveValues(
        `Température minimale MM365` = T,
        `Température moyenne MM365` = T,
        `Température maximale MM365` = T,
        `Régression températures min` = F,
        `Régression températures max` = F
    )

    output$Sonde823MM365 <- renderDygraph({
        if(varSelecSeluneMM365$`Température minimale MM365` == FALSE &
           varSelecSeluneMM365$`Température moyenne MM365`== FALSE &
           varSelecSeluneMM365$`Température maximale MM365` == FALSE &
           varSelecSeluneMM365$`Régression températures min` == FALSE &
           varSelecSeluneMM365$`Régression températures max` == FALSE
        )
        {
            serie_xts = xts(x = rep(NA, length(db2[which(db2$id_sonde==823),]$`Température minimale MM365`)),
                            order.by = db2[which(db2$id_sonde==823),]$date
            )
        }
        else{
            serie_xts = db_Selune_xtsc[db_Selune_xtsc$id_sonde == 823,c(varSelecSeluneMM365$`Température minimale MM365`,varSelecSeluneMM365$`Température moyenne MM365`,varSelecSeluneMM365$`Température maximale MM365`,
                                                                        varSelecSeluneMM365$`Régression températures min`,varSelecSeluneMM365$`Régression températures max`,F)]
        }



        dygraph(serie_xts, main = "")%>%
            dyAxis("y", label = "Température (en °C)", valueRange =
                       c(min(db_Selune_xtsc[db_Selune_xtsc$id_sonde==823,]$`Température minimale MM365`)-2,
                         max(db_Selune_xtsc[db_Selune_xtsc$id_sonde==823,]$`Température maximale MM365`)+2)) %>%
            dyAxis("x", label = "Temps",
                   valueRange = c(min(db2[db2$id_sonde==823,]$date), max(db2[db2$id_sonde==823,]$date)),
                   drawGrid = TRUE) %>%
            dyRangeSelector()%>%
            dyHighlight(highlightCircleSize = 5,
                        highlightSeriesBackgroundAlpha = 0.2,
                        highlightSeriesOpts = list(strokeWidth = 1),
                        hideOnMouseOut = TRUE) %>%
            dyOptions(colors = vec_col_MM30[c(varSelecSeluneMM365$`Température minimale MM365`,
                                              varSelecSeluneMM365$`Température moyenne MM365` ,
                                              varSelecSeluneMM365$`Température maximale MM365`,
                                              varSelecSeluneMM365$`Régression températures min`,
                                              varSelecSeluneMM365$`Régression températures max`)])
    })

    ################################
    # Régressions
    ################################

    ##############
    # Reg Selune 824
    #############


    output$Reg824 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 824,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"824"],
                        slope = dataRegCoeff[2,"824"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })

    ##############
    # Reg Selune 821
    #############


    output$Reg821 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 821,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"821"],
                        slope = dataRegCoeff[2,"821"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })

    ##############
    # Reg Selune 822
    #############


    output$Reg822 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 822,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"822"],
                        slope = dataRegCoeff[2,"822"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })

    ##############
    # Reg Selune 820
    #############


    output$Reg820 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 820,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"820"],
                        slope = dataRegCoeff[2,"820"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })





    ##############
    # Reg Selune 823
    #############


    output$Reg823 = renderPlotly({

        ggplot(data= db_teau_tair3[db_teau_tair3$id_sonde == 823,])+
            geom_point(aes(x= `Température de l'air`,y= `Température de l'eau`),color="blue",size=0.5)+
            geom_abline(intercept = dataRegCoeff[1,"823"],
                        slope = dataRegCoeff[2,"823"],color="red")+
            geom_vline(aes(xintercept =0),color="black")+
            geom_hline(aes(yintercept =0),color="black")+
            labs(
                x="Température de l'air (en °C)",
                y="Température de l'eau (en °C)")+

            theme_minimal()+
            theme(legend.title = element_blank())



    })


    ##############################################################
    # fiche synthese par sonde
    ##############################################################
    # ------------------------------------------------------------ #

    sonde_synthese_reactive <- reactiveValues(
        id_sonde_char = "817",
        id_sonde_num = 817,
        label_sonde = "Orne T1",
        sonde_lat = "48.90405",
        sonde_lng = "-0.45678",
        sonde_db = as.data.frame(db[db$id_sonde==817,]),
        sonde_deb = "2011-06-17",
        sonde_fin = "2021-10-19",
        sonde_nb_obs = 1,
        freq = 0 ,
        nb_jour = 0,
        periodicite = 0,
        sonde_debit = "0",
        sonde_dist_source = "137",
        sonde_alt = "33"
    )


    observeEvent(input$choix_sondes, {
        id_sonde_synthese = as.numeric(input$choix_sondes)
        #print(db_sonde_synthese[which(db_sonde_synthese==id_sonde_synthese),])
        sonde_info = db_sonde_synthese[which(db_sonde_synthese$id_sonde==id_sonde_synthese),]

        sonde_synthese_reactive$id_sonde_num = id_sonde_synthese
        sonde_synthese_reactive$id_sonde_char = input$choix_sondes
        sonde_synthese_reactive$label_sonde = sonde_info$label

        sonde_synthese_reactive$sonde_lat = sonde_info$latitude
        sonde_synthese_reactive$sonde_lng = sonde_info$longitude
        sonde_synthese_reactive$sonde_alt = sonde_info$Altitude
        sonde_synthese_reactive$sonde_dist_source = sonde_info$distance_source

        sonde_synthese_reactive$sonde_db = as.data.frame(db[db$id_sonde==id_sonde_synthese,])

        sonde_synthese_reactive$sonde_deb = sonde_info$date_deb
        sonde_synthese_reactive$sonde_fin = sonde_info$date_fin
        sonde_synthese_reactive$sonde_nb_obs = sonde_info$nb_obs


    },ignoreInit = F)

    observeEvent(input$return_to_sub_menu_map_sonde, {
        updateNavbarPage(session=session, inputId = "menu_principal", selected = "menu_cartes")
    })


    output$sonde_synthese_map <- renderLeaflet({
        pos = db_temp[which(db_temp$id_sonde == sonde_synthese_reactive$id_sonde_num),]$pos
        leaflet() %>%
            addTiles() %>%
            addAwesomeMarkers(lng = as.numeric(sonde_synthese_reactive$sonde_lng),
                              lat = as.numeric(sonde_synthese_reactive$sonde_lat),
                              group="sondes_synthese",
                              icon=makeAwesomeIcon(icon='tint', library='glyphicon',
                                                   iconColor = 'white', markerColor = 'blue')) %>%
            addPolylines(data = coursEau2@lines[[pos]]@Lines[[1]]@coords, weight = 2, opacity = 0.9, color = "blue")
    })

    # histogramme fréquence des température (bi-horaire)
    output$freq_sonde_synthese <- renderPlotly({
        gghist <- sonde_synthese_reactive$sonde_db %>%
            ggplot(aes(x=Teau))+
            geom_histogram(fill="#B2DF8A", colour="white", binwidth = .8)+
            theme_minimal()+
            theme(legend.title = element_blank())+
            xlab("Température de l'eau (en °C)") +
            ylab("Nombre d'occurences\n(sur la série bi-horaire)")

        gghist <- ggplotly(gghist)
    })

    output$tableau_stats_sonde_synthese <- renderTable({
        sonde_table = sonde_synthese_reactive$sonde_db %>%
            group_by(id_sonde) %>%
            mutate(Min=min(Teau),
                   t25 = quantile(Teau,.25),
                   Mediane = median(Teau),
                   Moyenne = mean(Teau),
                   sd = sd(Teau),
                   t75 = quantile(Teau,.75),
                   Max = max(Teau))

        sonde_table = sonde_table[1, 5:ncol(sonde_table)]
        sonde_table

    })

    # representation graphique de la serie
    output$graphe_sonde_synthese <- renderDygraph({
        df_sonde = sonde_synthese_reactive$sonde_db
        sonde_data = xts(df_sonde$Teau, order.by=df_sonde$t)
        dygraph(sonde_data)%>%
            dyAxis("y", label = "Température (°C)", valueRange = c(min(db$Teau)-1, max(db$Teau)+1)) %>%
            dyAxis("x", drawGrid = F, label = "Temps (relevé bi-horaire)") %>%
            dySeries("V1", label = "Température relevée") %>%
            #dyRangeSelector() %>%
            dyLegend(width = 170)#, show="follow")

    })

    # Periodogramme
    output$perio_sonde_synthese <- renderPlot({
        db_tempo2=db2[which(db2$id_sonde==sonde_synthese_reactive$id_sonde_num),]
        perio <- periodogram(db_tempo2$`Température moyenne`,log="yes",xlim=c(0,0.005))
        i = which.max(perio$spec)
        sonde_synthese_reactive$freq = perio$freq[i]
        sonde_synthese_reactive$nb_jour = length(na.omit(db_xts_comp_teau_moy[[sonde_synthese_reactive$id_sonde_char]]))
       # print(sonde_synthese_reactive$freq)
    })


    # textes
    output$id_lab_txt <- renderText({
        paste0(sonde_synthese_reactive$label_sonde," : ","sondes n°",sonde_synthese_reactive$id_sonde_char)
    })

    # output$debit_txt <- renderText({
    #     paste0("Débit : ", sonde_synthese_reactive$sonde_debit)
    # })

    output$dist_source_txt <- renderText({
        paste0("Distance à la source : ", sonde_synthese_reactive$sonde_dist_source, " km.")
    })

    output$long_lat_txt <- renderText({
        paste0("Longitude : ", sonde_synthese_reactive$sonde_lng,
               ". Latitude : ", sonde_synthese_reactive$sonde_lat,
               ". Altitude : ", sonde_synthese_reactive$sonde_alt,".")
    })

    output$deb_txt <- renderText({
        paste0("Première observation : ", sonde_synthese_reactive$sonde_deb,".")
    })

    output$fin_txt <- renderText({
        paste0("Dernière observation : ", sonde_synthese_reactive$sonde_fin,".")
    })

    output$nb_obs_txt <- renderText({
        paste0("Nombre d'observation (bi-horaire) : ",sonde_synthese_reactive$sonde_nb_obs, ".")
    })

    output$perio <- renderText({
        paste0("Fréquence maximale de ",
               round(sonde_synthese_reactive$freq,6),
               " x ",
               sonde_synthese_reactive$nb_jour, " observations journalières ",
               ", soit ",
               round(sonde_synthese_reactive$freq*sonde_synthese_reactive$nb_jour,3),
               " événements sur  ",
               year(sonde_synthese_reactive$sonde_fin)-year(sonde_synthese_reactive$sonde_deb),
               " ans.")
    })




    # ------------------------------------------------------------ #






    ##############################################################
    # comparaison sondes
    ##############################################################
    # ------------------------------------------------------------ #
    sonde_comp_reactive <- reactiveValues(
        choix_sondes = c("817", "818", "819")
    )

    df_xts_comp_teau <- reactive({
        df_xts_choix = data.frame(date = db_xts_comp_teau_moy$date)

        for(c in sonde_comp_reactive$choix_sondes){
            df_xts_choix[[c]] = db_xts_comp_teau_moy[[c]]
        }

        label_choix_sondes = c("date")
        for(c in as.numeric(sonde_comp_reactive$choix_sondes)){
            label_choix_sondes = c(label_choix_sondes, db_sonde_synthese[which(db_sonde_synthese$id_sonde==c),]$label)
        }

        names(df_xts_choix) = label_choix_sondes

        df_xts_choix = xts(df_xts_choix[,-1], order.by=df_xts_choix$date)

        df_xts_choix
    })




    df_xts_comp_MM30 <- reactive({
        df_xts_choix = data.frame(date = db_xts_comp_teau_MM30$date)

        for(c in sonde_comp_reactive$choix_sondes){
            df_xts_choix[[c]] = db_xts_comp_teau_MM30[[c]]
        }

        label_choix_sondes = c("date")
        for(c in as.numeric(sonde_comp_reactive$choix_sondes)){
            label_choix_sondes = c(label_choix_sondes, db_sonde_synthese[which(db_sonde_synthese$id_sonde==c),]$label)
        }

        names(df_xts_choix) = label_choix_sondes

        df_xts_choix = xts(df_xts_choix[,-1], order.by=df_xts_choix$date)

        df_xts_choix
    })


    df_xts_comp_MM365 <- reactive({
        df_xts_choix = data.frame(date = db_xts_comp_teau_MM365$date)

        for(c in sonde_comp_reactive$choix_sondes){
            df_xts_choix[[c]] = db_xts_comp_teau_MM365[[c]]
        }


        label_choix_sondes = c("date")
        for(c in as.numeric(sonde_comp_reactive$choix_sondes)){
            label_choix_sondes = c(label_choix_sondes, db_sonde_synthese[which(db_sonde_synthese$id_sonde==c),]$label)
        }

        names(df_xts_choix) = label_choix_sondes

        df_xts_choix = xts(df_xts_choix[,-1], order.by=df_xts_choix$date)

        df_xts_choix
    })

    df_xts_comp_bih <- reactive({
        df_xts_choix = data.frame(t = db_xts_comp_teau_bih$t)

        for(c in sonde_comp_reactive$choix_sondes){
            df_xts_choix[[c]] = db_xts_comp_teau_bih[[c]]
        }

        label_choix_sondes = c("t")
        for(c in as.numeric(sonde_comp_reactive$choix_sondes)){
            label_choix_sondes = c(label_choix_sondes, db_sonde_synthese[which(db_sonde_synthese$id_sonde==c),]$label)
        }

        names(df_xts_choix) = label_choix_sondes

        df_xts_choix = xts(df_xts_choix[,-1], order.by=df_xts_choix$t)

        df_xts_choix
    })





    observeEvent(input$choix_comparaison, {
        sonde_comp_reactive$choix_sondes = input$choix_comparaison
    },ignoreInit = TRUE)




    output$comp_Teau <- renderDygraph({
        if(length(sonde_comp_reactive$choix_sondes)==1){
            dygraph(df_xts_comp_teau(), group="comparison")%>%
                dyAxis("y", label = "Température (°C)") %>%
                dyAxis("x", label = "Temps") %>%
                dyRangeSelector() %>%
                dySeries("V1", label=db_sonde_synthese[which(db_sonde_synthese$id_sonde==as.numeric(sonde_comp_reactive$choix_sondes)),]$label)
        }
        else{
            dygraph(df_xts_comp_teau(), group="comparison")%>%
                dyAxis("y", label = "Température (°C)") %>%
                dyAxis("x", label = "Temps") %>%
                dyRangeSelector()
        }
    })


    output$comp_MM30 <- renderDygraph({
        if(length(sonde_comp_reactive$choix_sondes)==1){
            dygraph(df_xts_comp_MM30(), group="comparison")%>%
                dyAxis("y", label = "Température (°C)") %>%
                dyAxis("x", label = "Temps") %>%
                dyRangeSelector() %>%
                dySeries("V1", label=db_sonde_synthese[which(db_sonde_synthese$id_sonde==as.numeric(sonde_comp_reactive$choix_sondes)),]$label)
        }
        else{
            dygraph(df_xts_comp_MM30(), group="comparison")%>%
                dyAxis("y", label = "Température (°C)") %>%
                dyAxis("x", label = "Temps") %>%
                dyRangeSelector()
        }
    })

    output$comp_MM365 <- renderDygraph({
        if(length(sonde_comp_reactive$choix_sondes)==1){
            dygraph(df_xts_comp_MM365(), group="comparison")%>%
                dyAxis("y", label = "Température (°C)") %>%
                dyAxis("x", label = "Temps") %>%
                dyRangeSelector() %>%
                dySeries("V1", label=db_sonde_synthese[which(db_sonde_synthese$id_sonde==as.numeric(sonde_comp_reactive$choix_sondes)),]$label)
        }
        else{
            dygraph(df_xts_comp_MM365(), group="comparison")%>%
                dyAxis("y", label = "Température (°C)") %>%
                dyAxis("x", label = "Temps") %>%
                dyRangeSelector()
        }
    })


    output$comp_bih <- renderDygraph({
        if(length(sonde_comp_reactive$choix_sondes)==1){
            dygraph(df_xts_comp_bih(), group="comparison")%>%
                dyAxis("y", label = "Température (°C)") %>%
                dyAxis("x", label = "Temps") %>%
                dyRangeSelector() %>%
                dySeries("V1", label=db_sonde_synthese[which(db_sonde_synthese$id_sonde==as.numeric(sonde_comp_reactive$choix_sondes)),]$label)
        }
        else{
            dygraph(df_xts_comp_bih(), group="comparison")%>%
                dyAxis("y", label = "Température (°C)") %>%
                dyAxis("x", label = "Temps") %>%
                dyRangeSelector()
        }
    })
    # Fin onglet comparaison
    # ------------------------------------------------------------ #





    # ############################################################ #
    # FIN ANALYSE DES TEMPÉRATURES
    # ############################################################ #











    ##############################################################
    # Analyse de données avancée
    #############################################################

    ##########################################
    # O'Driscoll
    ##########################################
    output$Odris = renderPlotly({

        g = ggplot(data=odris,aes(x=slope,y=intercept,label =Sondes2,color=Sondes))+
            geom_abline(intercept = regOdris$coefficients[1],
                        slope = regOdris$coefficients[2])+
            xlab("Pente") +
            ylab("Ordonnées à l'origine")+
            geom_point()+
            geom_text(aes(x=slope-0.009),show.legend = FALSE) +
            theme_classic()

        g
    })

    ##########################################
    # ACI ACP
    ##########################################
    ###############
    # Touques Desc
    ###############
    desc_touques_reactive <- reactiveValues(
        choix_sonde = "825",
        choix_composantes = c(T, T, T),
        composantes = c("Teau", "Tair", "diff"),
        col_label = c("825Teau", "825Tair", "825diff")
    )

    observeEvent(input$sondes_touques_desc, {
        desc_touques_reactive$choix_sonde = input$sondes_touques_desc
        desc_touques_reactive$col_label = paste0(desc_touques_reactive$choix_sonde,desc_touques_reactive$composantes)
    })

    observeEvent(input$Teau_touques, {
        desc_touques_reactive$choix_composantes[1] = input$Teau_touques
    })
    observeEvent(input$Tair_touques, {
        desc_touques_reactive$choix_composantes[2] = input$Tair_touques
    })
    observeEvent(input$diff_touques, {
        desc_touques_reactive$choix_composantes[3] = input$diff_touques
    })

    output$desc_touques <- renderDygraph({
        db_xts_tempo = xts(teau_tair_diff_touques[,desc_touques_reactive$col_label[desc_touques_reactive$choix_composantes]],
                           teau_tair_diff_touques[,"date"])
        colnames(db_xts_tempo) = c("Température de l'eau",
                                   "Température de l'air",
                                   "Différence Teau-Tair")[desc_touques_reactive$choix_composantes]
        lab_sonde = db_sonde_synthese[which(db_sonde_synthese$id_sonde == desc_touques_reactive$choix_sonde),]$label
        dygraph(db_xts_tempo,ylab = "Température (en °C)",xlab="Temps") %>%

            dyOptions(colors = c("blue", "red", "black")[desc_touques_reactive$choix_composantes])
    })

    ###############
    # Touques ACI Données brutes
    ###############
    aci_touques_reactive <- reactiveValues(
        choix_sonde = "825",
        choix_composantes = c(T, T),
        composantes = c("comp1", "comp2"),
        col_label = c("comp1_825", "comp2_825")
    )

    observeEvent(input$sondes_touques_aci, {
        aci_touques_reactive$choix_sonde = input$sondes_touques_aci
        aci_touques_reactive$col_label = paste0(aci_touques_reactive$composantes, "_", aci_touques_reactive$choix_sonde)
    })

    observeEvent(input$comp1_touques, {
        aci_touques_reactive$choix_composantes[1] = input$comp1_touques
    })
    observeEvent(input$comp2_touques, {
        aci_touques_reactive$choix_composantes[2] = input$comp2_touques
    })
    # observeEvent(input$comp3_touques, {
    #     aci_touques_reactive$choix_composantes[3] = input$comp3_touques
    # })

    output$aci_touques <- renderDygraph({
        db_xts_tempo = xts(b_touques[,aci_touques_reactive$col_label[aci_touques_reactive$choix_composantes]],
                           b_touques[,"date"])
        colnames(db_xts_tempo) = c("Composante 1", "Composante 2")[aci_touques_reactive$choix_composantes]
        lab_sonde = db_sonde_synthese[which(db_sonde_synthese$id_sonde == aci_touques_reactive$choix_sonde),]$label
        dygraph(db_xts_tempo) %>%
            dyAxis("y", label = "Température (en °C)") %>%
            dyAxis("x", label = "Temps") %>%
            dyOptions(colors = c("blue", "red")[aci_touques_reactive$choix_composantes])
    })
    ###############
    # Touques matrice de passage Données Brutes
    ###############
    output$mat_pass_Touques= renderTable(mat_touques,rownames=T)
    ###############
    # Touques diff 3 comp
    ###############
    aci_touques_dif3_reactive <- reactiveValues(
        choix_sonde = "825",
        choix_composantes = c(T, T, T),
        composantes = c("comp1", "comp2", "comp3"),
        col_label = c("comp1_825diff", "comp2_825diff", "comp3_825diff")
    )

    observeEvent(input$sondes_touques_aci_dif3, {
        aci_touques_dif3_reactive$choix_sonde = input$sondes_touques_aci_dif3
        aci_touques_dif3_reactive$col_label = paste0(aci_touques_dif3_reactive$composantes, "_", aci_touques_dif3_reactive$choix_sonde,"diff")
    })

    observeEvent(input$comp1_touques_dif, {
        aci_touques_dif3_reactive$choix_composantes[1] = input$comp1_touques_dif
    })
    observeEvent(input$comp2_touques_dif, {
        aci_touques_dif3_reactive$choix_composantes[2] = input$comp2_touques_dif
    })
    observeEvent(input$comp3_touques_dif, {
        aci_touques_dif3_reactive$choix_composantes[3] = input$comp3_touques_dif
    })

    output$aci_touques_dif3 <- renderDygraph({
        db_xts_tempo = xts(b_touques_dif3[,aci_touques_dif3_reactive$col_label[aci_touques_dif3_reactive$choix_composantes]],
                           b_touques_dif3[,"date"])
        colnames(db_xts_tempo) = c("Composante 1", "Composante 2", "Composante 3")[aci_touques_dif3_reactive$choix_composantes]
        lab_sonde = db_sonde_synthese[which(db_sonde_synthese$id_sonde == aci_touques_dif3_reactive$choix_sonde),]$label
        dygraph(db_xts_tempo) %>%
            dyAxis("y", label = "Température (en °C)") %>%
            dyAxis("x", label = "Temps") %>%
            dyOptions(colors = c("blue", "red", "black")[aci_touques_dif3_reactive$choix_composantes])
    })

    ###############
    # Touques diff 2 comp
    ###############
    aci_touques_dif2_reactive <- reactiveValues(
        choix_sonde = "825",
        choix_composantes = c(T, T),
        composantes = c("comp1", "comp2"),
        col_label = c("comp1_825diff", "comp2_825diff")
    )

    observeEvent(input$sondes_touques_aci_dif2, {
        aci_touques_dif2_reactive$choix_sonde = input$sondes_touques_aci_dif2
        aci_touques_dif2_reactive$col_label = paste0(aci_touques_dif2_reactive$composantes, "_", aci_touques_dif2_reactive$choix_sonde,"diff")
    })

    observeEvent(input$comp1_touques_dif2, {
        aci_touques_dif2_reactive$choix_composantes[1] = input$comp1_touques_dif2
    })
    observeEvent(input$comp2_touques_dif2, {
        aci_touques_dif2_reactive$choix_composantes[2] = input$comp2_touques_dif2
    })


    output$aci_touques_dif2 <- renderDygraph({
        db_xts_tempo = xts(b_touques_dif2[,aci_touques_dif2_reactive$col_label[aci_touques_dif2_reactive$choix_composantes]],
                           b_touques_dif2[,"date"])
        colnames(db_xts_tempo) = c("Composante 1", "Composante 2")[aci_touques_dif2_reactive$choix_composantes]
        lab_sonde = db_sonde_synthese[which(db_sonde_synthese$id_sonde == aci_touques_dif2_reactive$choix_sonde),]$label
        dygraph(db_xts_tempo, paste0("Composantes indépendantes de ", lab_sonde)) %>%
            dyOptions(colors = c("blue", "red", "black")[aci_touques_dif2_reactive$choix_composantes])
    })
    ###############
    # Touques matrice de passage Données Diff
    ###############
    output$mat_pass_Touques_diff= renderTable( mat_touques_dif_3comp,rownames=T)


    ###############
    # Touques ACPs
    ###############
    output$ACP_825_diff <- renderPlot({
        res_ACP_825_diff_3comp_C1C2C3
    })
    output$ACP_827_diff <- renderPlot({
        res_ACP_827_diff_3comp_C1C2C3
    })
    output$ACP_828_diff <- renderPlot({
        res_ACP_828_diff_3comp_C1C2C3
    })
    output$ACP_830_diff <- renderPlot({
        res_ACP_830_diff_3comp_C1C2C3
    })

    ###############
    # Touques corrélations
    ###############

    output$touques_corr = DT::renderDataTable(

        correlation_touques,  rownames = NULL,
        filter = 'top', options = list(
            pageLength = 5, autoWidth = TRUE
        )

    )


    ###############
    # selune Desc
    ###############

    desc_selune_reactive2 <- reactiveValues(
        choix_sonde = "824"
    )

    observeEvent(input$selune_choix_sonde, {
        desc_selune_reactive2$choix_sonde = input$selune_choix_sonde
    })

    output$desc_selune <- renderDygraph({
        db_xts_tempo = xts(db_aci_bih_selune[,desc_selune_reactive2$choix_sonde],
                           db_aci_bih_selune[,"t"])
        colnames(db_xts_tempo) = c("Température de l'eau")
        lab_sonde = db_sonde_synthese[which(db_sonde_synthese$id_sonde == desc_selune_reactive2$choix_sonde),]
        dygraph(db_xts_tempo) %>%
            dyAxis("y", label = "Température (en °C)") %>%
            dyAxis("x", label = "Temps")
            #dyOptions(colors = c("blue", "red", "black")[desc_selune_reactive2$choix_sonde])
    })


    db_sonde_synthese_Selune2 = db_sonde_synthese[db_sonde_synthese$id_sonde == 824 |
                                                     #db_sonde_synthese$id_sonde == 820 |
                                                     #db_sonde_synthese$id_sonde == 822 |
                                                     db_sonde_synthese$id_sonde == 821 |
                                                     db_sonde_synthese$id_sonde == 823 ,]

    output$map_Selune_ACI <- renderLeaflet({

        leaflet() %>%
            addTiles() %>%
            addAwesomeMarkers(data = db_sonde_synthese_Selune2,
                              lng=db_sonde_synthese_Selune2$longitude,lat=db_sonde_synthese_Selune2$latitude,
                              icon=makeAwesomeIcon(icon='tint', library='glyphicon',
                                                   iconColor = 'white', markerColor = 'blue'),

                              popup =  paste(db_sonde_synthese_Selune2$label))%>%
            addAwesomeMarkers(
                              lng=-1.2336,lat=48.5786,
                              icon=makeAwesomeIcon(icon="flash", library='glyphicon',
                                                   iconColor = 'white', markerColor = 'red'),

                              popup =  "Barrage de Vézins" )%>%
            addAwesomeMarkers(
                lng= -1.2586,lat=48.6061,
                icon=makeAwesomeIcon(icon="flash", library='glyphicon',
                                     iconColor = 'white', markerColor = 'red'),

                popup =  "Barrage de La Roche qui Boit")%>%


            addPolylines(data=coursEau2[coursEau2@data$Name== "Selune",],color="blue")

    })



    ###############
    # Selune 2 comp
    ###############
    aci_selune_2comp_reactive <- reactiveValues(
        choix_sonde = "824",
        choix_composantes = c(T, T),
        composantes = c("comp1", "comp2"),
        col_label = c("comp1_824", "comp2_824")
    )

    observeEvent(input$sondes_selune_aci_2comp, {
        aci_selune_2comp_reactive$choix_sonde = input$sondes_selune_aci_2comp
        aci_selune_2comp_reactive$col_label = paste0(aci_selune_2comp_reactive$composantes, "_", aci_selune_2comp_reactive$choix_sonde)
    })

    observeEvent(input$comp1_selune_2comp, {
        aci_selune_2comp_reactive$choix_composantes[1] = input$comp1_selune_2comp
    })
    observeEvent(input$comp2_selune_2comp, {
        aci_selune_2comp_reactive$choix_composantes[2] = input$comp2_selune_2comp
    })


    output$aci_selune_2comp <- renderDygraph({
        db_xts_tempo = xts(b_selune2[,aci_selune_2comp_reactive$col_label[aci_selune_2comp_reactive$choix_composantes]],
                           b_selune2[,"t"])
        colnames(db_xts_tempo) = c("Composante 1", "Composante 2")[aci_selune_2comp_reactive$choix_composantes]
        lab_sonde = db_sonde_synthese[which(db_sonde_synthese$id_sonde == aci_selune_2comp_reactive$choix_sonde),]$label
        dygraph(db_xts_tempo) %>%
            dyAxis("y", label = "Température (en °C)") %>%
            dyAxis("x", label = "Temps") %>%
            dyOptions(colors = c("blue", "red")[aci_selune_2comp_reactive$choix_composantes])
    })



    ###############
    # Selune matrice de passage
    ###############
    output$mat_selune_3comp= renderTable( mat_selune_3comp,rownames=T)
    output$mat_selune_2comp= renderTable( mat_selune_2comp,rownames=T)



}) # Fin shinyServer
