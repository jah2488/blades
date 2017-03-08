module District.View.SideBar.Factions exposing (view)

import Html exposing (Html, a, button, div, text, header)
import Html.Attributes exposing (class, classList, href, type_)
import Html.Events exposing (onClick, onInput)
import Models exposing (..)
import District.View.SideBar.Stats as Stats
import District.Types exposing (..)
import District.View.Utils exposing (stateClass)
import Faction.Utils exposing (tier)
import Utils exposing (isChecked, toSlug)


view : Model -> Html Msg
view model =
    let
        factions =
            model.district.factions

        factionsOpen =
            model.factionsOpen

        sectionInfo =
            if model.editing then
                [ div [ class "status" ] [ text "Action" ] ]
            else
                [ div [ class "rep" ] [ text "Tier" ]
                  -- , div [ class "hold" ] [ text "Hold" ]
                , div [ class "status" ] [ text "Status" ]
                ]
    in
        div [ class "row" ]
            [ div [ class "faction" ]
                [ header [ class "category" ] <|
                    [ div [ class (stateClass factionsOpen), onClick <| Toggle Factions ] []
                    , div [ class "name" ] [ text "Factions" ]
                    ]
                        ++ sectionInfo
                , div []
                    [ if factionsOpen then
                        if model.editing then
                            editFactions model
                        else
                            div [] (List.map viewFaction factions)
                      else
                        div [] []
                    ]
                ]
            ]


viewFaction : Faction -> Html Msg
viewFaction faction =
    div [ class "information" ]
        [ div [ class "name" ]
            [ a [ href <| "/factions/" ++ faction.slug ] [ text faction.name ]
            ]
        , div [ class "rep" ] [ text <| tier faction.reputation ]
          -- , div [ class "hold" ] [ text <| toString faction.hold ]
        , div [ class "status" ] [ text <| toString faction.faction_status ]
        ]


editFaction : Model -> Faction -> Html Msg
editFaction model faction =
    let
        isSame =
            (\fa fb -> fa == fb)

        filtered =
            List.filter (isSame faction) model.district.factions

        action =
            if (filtered == []) then
                div [ class "add-faction btn-primary", onClick (FactionList (Add faction.id)) ] [ text "ADD" ]
            else
                div [ class "remove-faction btn-primary", onClick (FactionList (Remove faction.id)) ] [ text "DEL" ]
    in
        div [ class "information" ]
            [ div [ classList [ ( "name", True ), ( "current", filtered == [] ) ] ]
                [ a [ href <| "/factions/" ++ faction.slug ] [ text faction.name ] ]
            , action
            ]


editFactions : Model -> Html Msg
editFactions model =
    div [] (List.map (editFaction model) model.allFactions)
