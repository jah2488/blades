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

        EnterEdit ->
            ( { model | editing = True }, Cmd.none )

        ExitEdit ->
            ( { model | editing = False }, Cmd.none )

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
