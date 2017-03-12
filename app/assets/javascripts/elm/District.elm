module District exposing (..)

import Html
import District.Types exposing (..)
import District.Update exposing (..)
import District.View exposing (..)


init : Flags -> ( Model, Cmd Msg )
init { district, csrfToken_, editable } =
    ( { district = district
      , originalDistrict = district
      , descriptionOpen = False
      , factionIDs = []
      , factionsOpen = True
      , allFactions = []
      , statsOpen = True
      , editing = False
      , editable = editable
      , csrfToken = csrfToken_
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
