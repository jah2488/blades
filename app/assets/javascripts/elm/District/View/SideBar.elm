module District.View.SideBar exposing (view)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import District.Types exposing (..)
import District.View.SideBar.Stats as Stats
import District.View.SideBar.Factions as Factions
import District.View.SideBar.Toolbar as Toolbar


view : Model -> Html Msg
view model =
    div [ class "six columns" ]
        [ Stats.view model
        , Factions.view model
        , Toolbar.view model
        ]
