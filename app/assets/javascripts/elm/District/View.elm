module District.View exposing (..)

import Html exposing (Html, a, button, div, header, section, td, text, tr, br, textarea, input, span, em)
import Html.Attributes exposing (class, classList, href, type_)
import Html.Events exposing (onClick, onInput)
import Models exposing (..)
import Faction.Utils exposing (tier)
import District.Types exposing (..)
import District.View.Header as Header
import District.View.MainSection as MainSection
import District.View.SideBar as SideBar
import District.View.Utils exposing (stateClass)
import Utils exposing (..)


view : Model -> Html Msg
view model =
    section [ class "district" ]
        [ div []
            [ Header.view model
            , div [ class "row" ]
                [ MainSection.view model
                , SideBar.view model
                ]
            ]
        ]
