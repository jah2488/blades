module District.Update.Changed exposing (update)

import District.Types exposing (..)


update : Field -> Model -> ( Model, Cmd Msg )
update field ({ district } as model) =
    case field of
        Description string ->
            let
                newDistrict =
                    { district | description = Just string }
            in
                ( { model | district = newDistrict }, Cmd.none )

        Wealth int ->
            let
                newDistrict =
                    { district | wealth = int }
            in
                ( { model | district = newDistrict }, Cmd.none )

        SecurityAndSafety int ->
            let
                newDistrict =
                    { district | security_and_safety = int }
            in
                ( { model | district = newDistrict }, Cmd.none )

        CriminalInfluence int ->
            let
                newDistrict =
                    { district | criminal_influence = int }
            in
                ( { model | district = newDistrict }, Cmd.none )

        OccultInfluence int ->
            let
                newDistrict =
                    { district | occult_influence = int }
            in
                ( { model | district = newDistrict }, Cmd.none )
