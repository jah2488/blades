module Faction exposing (..)

import Html
import Faction.Types exposing (Flags, Model, Msg)
import Faction.Update
import Faction.View


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { faction = flags.faction
      , expanded = flags.expanded
      , editable = flags.editable
      , editMode = False
      , csrfToken = flags.csrfToken_
      }
    , Cmd.none
    )


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = Faction.View.view
        , update = Faction.Update.update
        , subscriptions = \_ -> Sub.none
        , init = init
        }
