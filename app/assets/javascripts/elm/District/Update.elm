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
        |> List.map Json.int
        |> Array.fromList


updateEdit : EditState -> Model -> ( Model, Cmd Msg )
updateEdit state model =
    case state of
        Enter ->
            ( { model | editing = True }, Cmd.none )

        Exit ->
            ( { model | editing = False }, saveChanges model )

        Reset ->
            ( { model | district = model.originalDistrict }, Cmd.none )

        Cancel ->
            ( { model | editing = False, district = model.originalDistrict }, Cmd.none )


updateToggle : ToggleSection -> Model -> ( Model, Cmd Msg )
updateToggle section model =
    case section of
        Stats ->
            ( { model | statsOpen = not model.statsOpen }, Cmd.none )

        Factions ->
            ( { model | factionsOpen = not model.factionsOpen }, Cmd.none )

        Description ->
            ( { model | descriptionOpen = not model.descriptionOpen }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ district } as model) =
    case msg of
        Toggle section ->
            updateToggle section model

        Edit state ->
            updateEdit state model

        FactionAdded id ->
            let
                newFaction =
                    List.filter (\f -> f.id == id) model.allFactions

                newDistrict =
                    { district | factions = (district.factions ++ newFaction) }
            in
                ( { model | district = newDistrict }, Cmd.none )

        FactionRemoved id ->
            let
                newFactions =
                    List.filter (\f -> f.id /= id) model.district.factions

                newDistrict =
                    { district | factions = newFactions }
            in
                ( { model | district = newDistrict }, Cmd.none )

        WealthChanged int ->
            let
                newDistrict =
                    { district | wealth = int }
            in
                ( { model | district = newDistrict }, Cmd.none )

        SecurityAndSafetyChanged int ->
            let
                newDistrict =
                    { district | security_and_safety = int }
            in
                ( { model | district = newDistrict }, Cmd.none )

        CriminalInfluenceChanged int ->
            let
                newDistrict =
                    { district | criminal_influence = int }
            in
                ( { model | district = newDistrict }, Cmd.none )

        OccultInfluenceChanged int ->
            let
                newDistrict =
                    { district | occult_influence = int }
            in
                ( { model | district = newDistrict }, Cmd.none )

        DescriptionChanged desc ->
            let
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
