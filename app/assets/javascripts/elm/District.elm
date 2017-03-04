module District exposing (..)

import Html
import District.Common exposing (..)
import District.Update exposing (..)
import District.View exposing (..)


init : Flags -> ( Model, Cmd Msg )
init { district } =
    ( { district = district
      , descriptionOpen = True
      , factionsOpen = True
      , statsOpen = False
      }
    , Cmd.none
    )


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , init = init
        }
