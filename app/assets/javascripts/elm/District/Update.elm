module District.Update exposing (..)

import District.Common exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleDescription ->
            ( { model | descriptionOpen = not model.descriptionOpen }, Cmd.none )

        ToggleFactions ->
            ( { model | factionsOpen = not model.factionsOpen }, Cmd.none )

        ToggleStats ->
            ( { model | statsOpen = not model.statsOpen }, Cmd.none )

        EnterEdit ->
            ( { model | editing = True }, Cmd.none )

        ExitEdit ->
            ( { model | editing = False }, Cmd.none )

        FactionAdded id ->
            let
                district =
                    model.district

                newFaction =
                    List.filter (\f -> f.id == id) model.allFactions

                newDistrict =
                    { district | factions = (district.factions ++ newFaction) }
            in
                ( { model | district = newDistrict }, Cmd.none )

        FactionRemoved id ->
            let
                district =
                    model.district

                newFactions =
                    List.filter (\f -> f.id /= id) model.district.factions

                newDistrict =
                    { district | factions = newFactions }
            in
                ( { model | district = newDistrict }, Cmd.none )

        WealthChanged int ->
            let
                district =
                    model.district

                newDistrict =
                    { district | wealth = int }
            in
                ( { model | district = newDistrict }, Cmd.none )

        SecurityAndSafetyChanged int ->
            let
                district =
                    model.district

                newDistrict =
                    { district | security_and_safety = int }
            in
                ( { model | district = newDistrict }, Cmd.none )

        CriminalInfluenceChanged int ->
            let
                district =
                    model.district

                newDistrict =
                    { district | criminal_influence = int }
            in
                ( { model | district = newDistrict }, Cmd.none )

        OccultInfluenceChanged int ->
            let
                district =
                    model.district

                newDistrict =
                    { district | occult_influence = int }
            in
                ( { model | district = newDistrict }, Cmd.none )

        DescriptionChanged desc ->
            let
                district =
                    model.district

                newDistrict =
                    { district | description = Just desc }
            in
                ( { model | district = newDistrict }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
