module Faction.Update exposing (..)

import Http
import Json.Decode as Decode
import Json.Encode as Json
import Maybe
import Models exposing (..)
import Faction.Types exposing (..)
import Utils exposing (patch)


saveChanges : Model -> Cmd Msg
saveChanges model =
    let
        url =
            "/factions/" ++ (toString model.faction.id)

        data =
            Json.object
                [ ( "faction"
                  , Json.object
                        [ ( "hold", Json.int model.faction.hold )
                        , ( "reputation", Json.int model.faction.reputation )
                        , ( "faction_status", Json.int model.faction.faction_status )
                        , ( "description", Json.string <| Maybe.withDefault "" model.faction.description )
                        ]
                  )
                ]

        decode =
            Decode.string

        request =
            patch model.csrfToken url (Http.jsonBody data) decode
    in
        Http.send SavedForm request


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ShowTools ->
            ( model, Cmd.none )

        EnterEdit ->
            ( { model | editMode = True }, Cmd.none )

        ExitEdit ->
            ( { model | editMode = False }, saveChanges model )

        CancelEdit ->
            ( { model | editMode = False }, Cmd.none )

        SavedForm (Ok status) ->
            ( model, Cmd.none )

        SavedForm (Err status) ->
            ( model, Cmd.none )

        HoldChanged hold ->
            let
                faction =
                    model.faction

                newFaction =
                    if hold == True then
                        { faction | hold = 1 }
                    else
                        { faction | hold = 0 }
            in
                ( { model | faction = newFaction }, Cmd.none )

        RepChanged rep ->
            let
                faction =
                    model.faction

                newFaction =
                    { faction | reputation = (Result.withDefault 0 (String.toInt rep)) }
            in
                ( { model | faction = newFaction }, Cmd.none )

        StatusChanged status ->
            let
                faction =
                    model.faction

                newStatus =
                    (Result.withDefault 0 (String.toInt status))

                boundStatus =
                    if newStatus >= 3 then
                        3
                    else if newStatus <= -3 then
                        -3
                    else
                        newStatus

                newFaction =
                    { faction | faction_status = boundStatus }
            in
                ( { model | faction = newFaction }, Cmd.none )

        DescriptionChanged desc ->
            let
                faction =
                    model.faction

                newFaction =
                    { faction | description = Just desc }
            in
                ( { model | faction = newFaction }, Cmd.none )
