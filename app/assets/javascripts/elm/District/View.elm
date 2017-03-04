module District.View exposing (..)

import Html exposing (Html, a, button, div, header, section, td, text, tr)
import Html.Attributes exposing (class, classList, href)
import Html.Events exposing (onClick)
import Models exposing (..)
import Faction.Utils exposing (tier)
import District.Common exposing (..)
import Utils exposing (..)


toCheckbox : String -> Html Msg
toCheckbox className =
    div [ class className ] []


toRating : Int -> List (Html Msg)
toRating n =
    let
        amount =
            div [ class "amount" ] [ text <| toString n ]

        checkboxes =
            List.range 0 3
                |> List.map (isChecked n)
                |> List.map toCheckbox
    in
        checkboxes ++ [ amount ]


viewStat : String -> Int -> Html Msg
viewStat name value =
    div [ class <| "attr " ++ toSlug name ]
        [ div [ class "name" ] [ text name ]
        , div [ class "value" ] <| toRating value
        ]


stateClass : Bool -> String
stateClass state =
    case state of
        True ->
            "ic expanded"

        False ->
            "ic closed"


viewDistrict : District -> Bool -> Html Msg
viewDistrict district opened =
    let
        heading =
            header [ class "category" ]
                [ div [ class (stateClass opened), onClick ToggleStats ] []
                , div [ class "name" ] [ text "Info" ]
                ]

        body =
            if opened == True then
                [ viewStat "Wealth" district.wealth
                , viewStat "Security & Safety" district.security_and_safety
                , viewStat "Criminal Influence" district.criminal_influence
                , viewStat "Occult Influence" district.occult_influence
                ]
            else
                []
    in
        div [ class "stats" ] (heading :: body)


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


factionSection : Model -> Html Msg
factionSection { district, factionsOpen } =
    div [ class "row" ]
        [ div [ class "faction" ]
            [ header [ class "category" ]
                [ div [ class (stateClass factionsOpen), onClick ToggleFactions ] []
                , div [ class "name" ]
                    [ text "Factions"
                    ]
                , div [ class "rep" ] [ text "Tier" ]
                  -- , div [ class "hold" ] [ text "Hold" ]
                , div [ class "status" ] [ text "Status" ]
                ]
            , div []
                [ if factionsOpen then
                    div [] (List.map viewFaction district.factions)
                  else
                    div [] []
                ]
            ]
        ]


statsSection : Model -> Html Msg
statsSection model =
    div [ class "row" ] [ viewDistrict model.district model.statsOpen ]


sideBar : Model -> Html Msg
sideBar model =
    div [ class "six columns" ]
        [ statsSection model
        , factionSection model
        ]


mainSection : Html Msg -> Bool -> Html Msg
mainSection desc opened =
    div [ class "six columns" ]
        [ div [ classList [ ( "description", True ), ( "opened", opened ) ] ]
            [ desc
            , div [ class <| "fixed-footer " ++ (stateClass opened), onClick ToggleDescription ] []
            ]
        ]


view : Model -> Html Msg
view model =
    section [ class "district" ]
        [ div []
            [ header [ class "category" ] [ div [ class "name" ] [ text model.district.name ] ]
            , div [ class "row" ]
                [ mainSection (renderMarkdown model.district.description NoOp) model.descriptionOpen
                , sideBar model
                ]
            ]
        ]
