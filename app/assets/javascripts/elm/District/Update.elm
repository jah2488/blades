module District.Update exposing (..)

import District.Common exposing (..)


toggleAttr : Bool -> Bool
toggleAttr attr =
    if attr == False then
        True
    else
        False


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleDescription ->
            ( { model | descriptionOpen = toggleAttr model.descriptionOpen }, Cmd.none )

        ToggleFactions ->
            ( { model | factionsOpen = toggleAttr model.factionsOpen }, Cmd.none )

        ToggleStats ->
            ( { model | statsOpen = toggleAttr model.statsOpen }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
