module District.Update exposing (..)

import Array exposing (toList)
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
            ignore model

        SavedForm (Err status) ->
            ignore model

        GetFactions (Ok factions) ->
            ( { model | allFactions = toList factions }, Cmd.none )

        GetFactions (Err _) ->
            let
                err =
                    Debug.log ("Could not fetch factions")
            in
                ignore model

        NoOp ->
            ignore model


ignore : Model -> ( Model, Cmd Msg )
ignore model =
    model ! []
