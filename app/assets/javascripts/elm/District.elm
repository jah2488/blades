module District exposing (..)

import Html
import District.Common exposing (..)
import District.Update exposing (..)
import District.View exposing (..)


init : Flags -> ( Model, Cmd Msg )
init { district, allFactions, csrfToken_ } =
    ( { district = district
      , descriptionOpen = True
      , factionIDs = []
      , factionsOpen = False
      , allFactions = allFactions
      , statsOpen = True
      , editing = False
      , editable = True
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
