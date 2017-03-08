module District.Update.Toggle exposing (update)

import District.Types exposing (..)


update : ToggleSection -> Model -> ( Model, Cmd Msg )
update section model =
    case section of
        Stats ->
            ( { model | statsOpen = not model.statsOpen }, Cmd.none )

        Factions ->
            ( { model | factionsOpen = not model.factionsOpen }, Cmd.none )

        Descriptions ->
            ( { model | descriptionOpen = not model.descriptionOpen }, Cmd.none )
