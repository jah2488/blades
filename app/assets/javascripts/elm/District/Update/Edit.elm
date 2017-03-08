module District.Update.Edit exposing (update)

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


update : EditState -> Model -> ( Model, Cmd Msg )
update state model =
    case state of
        Enter ->
            ( { model | editing = True }, Cmd.none )

        Exit ->
            ( { model | editing = False }, saveChanges model )

        Reset ->
            ( { model | district = model.originalDistrict }, Cmd.none )

        Cancel ->
            ( { model | editing = False, district = model.originalDistrict }, Cmd.none )
