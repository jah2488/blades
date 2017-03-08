module District.Update exposing (..)

import District.Types exposing (..)
import District.Update.Edit
import District.Update.Toggle
import District.Update.Changed
import District.Update.Factions


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Toggle section ->
            District.Update.Toggle.update section model

        Edit state ->
            District.Update.Edit.update state model

        Changed field ->
            District.Update.Changed.update field model

        FactionList action ->
            District.Update.Factions.update action model

        SavedForm (Ok status) ->
            doNothing model

        SavedForm (Err status) ->
            doNothing model

        NoOp ->
            doNothing model


doNothing : Model -> ( Model, Cmd Msg )
doNothing model =
    model ! []
