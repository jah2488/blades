module District.View exposing (..)

import Html exposing (Html, a, button, div, header, section, td, text, tr)
import Html.Attributes exposing (class, href)
import Regex exposing (regex)
import Markdown
import Models exposing (..)
import Faction.View exposing (tier)
import District.Common exposing (..)


renderMarkdown : Maybe String -> Html Msg
renderMarkdown string =
    case string of
        Just desc ->
            Markdown.toHtml [] desc

        Nothing ->
            text "Unknown"


toSlug : String -> String
toSlug name =
    String.toLower name
        |> Regex.replace Regex.All
            (regex "[ _&.']")
            (\{ match } ->
                case match of
                    " " ->
                        "-"

                    "_" ->
                        "-"

                    "&" ->
                        ""

                    "." ->
                        ""

                    "'" ->
                        ""

                    _ ->
                        ""
            )
        |> Regex.replace Regex.All
            (regex "--")
            (\_ -> "-")


viewFaction : Faction -> Html Msg
viewFaction faction =
    div [ class "information" ]
        [ div [ class "name" ]
            [ a [ href <| "/factions/" ++ faction.slug ] [ text faction.name ]
            ]
        , div [ class "rep" ] [ text <| tier faction.reputation ]
        , div [ class "hold" ] [ text <| toString faction.hold ]
        , div [ class "status" ] [ text <| toString faction.faction_status ]
        ]


isChecked : Int -> Int -> String
isChecked idx n =
    if idx <= n then
        "unchecked"
    else
        "checked"


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


viewDistrict : District -> Html Msg
viewDistrict district =
    div [ class "stats" ]
        [ header [ class "category" ]
            [ div [ class "name" ] [ text "Info" ]
            ]
        , viewStat "Wealth" district.wealth
        , viewStat "Security & Safety" district.security_and_safety
        , viewStat "Criminal Influence" district.criminal_influence
        , viewStat "Occult Influence" district.occult_influence
        ]


factionSection : District -> Html Msg
factionSection district =
    div [ class "row" ]
        [ div [ class "faction" ]
            [ header [ class "category" ]
                [ div [ class "name" ]
                    [ text "Factions"
                    ]
                , div [ class "rep" ] [ text "Tier" ]
                , div [ class "hold" ] [ text "Hold" ]
                , div [ class "status" ] [ text "Status" ]
                ]
            , div [] (List.map viewFaction district.factions)
            ]
        ]


statsSection : District -> Html Msg
statsSection district =
    div [ class "row" ] [ viewDistrict district ]


sideBar : District -> Html Msg
sideBar district =
    div [ class "six columns" ]
        [ statsSection district
        , factionSection district
        ]


mainSection : Html Msg -> Html Msg
mainSection desc =
    div [ class "six columns" ]
        [ div [ class "description" ] [ desc ] ]


view : Model -> Html Msg
view model =
    section [ class "district" ]
        [ div []
            [ header [ class "category" ] [ div [ class "name" ] [ text model.district.name ] ]
            , div [ class "row" ]
                [ mainSection (renderMarkdown model.district.description)
                , sideBar model.district
                ]
            ]
        ]
