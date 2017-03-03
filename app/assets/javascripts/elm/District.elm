module District exposing (..)

import Html
import District.Common exposing (..)
import District.Update exposing (..)
import District.View exposing (..)


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( flags, Cmd.none )


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , init = init
        }
