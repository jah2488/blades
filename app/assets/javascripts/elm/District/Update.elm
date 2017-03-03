module District.Update exposing (..)

import Models exposing (..)
import District.Common exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
