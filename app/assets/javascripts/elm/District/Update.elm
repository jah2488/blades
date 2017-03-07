module District.Update exposing (..)

import Array exposing (Array)
import Http
import Json.Decode as Decode
import Json.Encode as Json
import Maybe
import Models exposing (..)
import District.Types exposing (..)
import Utils exposing (patch)


saveChanges : Model -> Cmd Msg
saveChanges ({ district, csrfToken } as model) =
    let
        url =
            "/districts/" ++ (toString district.id)

        data =
            Json.object
                [ ( "district"
                  , Json.object
                        [ ( "wealth", Json.int district.wealth )
                        , ( "security_and_safety", Json.int district.security_and_safety )
                        , ( "occult_influence", Json.int district.occult_influence )
                        , ( "criminal_influence", Json.int district.criminal_influence )
                        , ( "faction_ids", Json.array (factionIDs model) )
                        , ( "description", Json.string <| Maybe.withDefault "" district.description )
                        ]
                  )
                ]

        decode =
            Decode.string

        request =
            patch csrfToken url (Http.jsonBody data) decode
    in
        Http.send SavedForm request


factionIDs : Model -> Array Json.Value
factionIDs model =
    model.district.factions
        |> List.map (.id)
        |> List.map (\x -> Json.int x)
        |> Array.fromList


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
            ( { model | editing = False }, saveChanges model )

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

        SavedForm (Ok status) ->
            ( model, Cmd.none )

        SavedForm (Err status) ->
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
