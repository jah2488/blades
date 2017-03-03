module Faction.View exposing (..)

import Faction.Common exposing (..)
import Html exposing (Html, a, br, button, div, form, header, input, label, p, section, span, td, text, textarea, tr)
import Html.Attributes exposing (attribute, checked, class, classList, for, href, id, max, min, type_, value)
import Html.Events exposing (onCheck, onClick, onDoubleClick, onInput)
import Markdown
import Maybe
import Models exposing (..)
import Regex exposing (regex)


categoryName : Model -> String
categoryName model =
    case model.faction.category of
        Just category ->
            category.name

        Nothing ->
            "Not In a Category"


categorySlug : Model -> String
categorySlug model =
    case model.faction.category of
        Just category ->
            String.toLower category.name
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

        Nothing ->
            ""


viewWrapper : Model -> List (Html Msg) -> Html Msg
viewWrapper model body =
    section
        [ classList [ ( "editing", model.editMode ) ]
        ]
        [ div [ class "faction" ]
            [ viewHeader model, div [ class "information" ] body ]
        , viewDescription model.faction model.expanded model.editMode
        , viewEdit model.editable model.editMode
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    header [ class "category" ]
        [ div [ class "name" ]
            [ text (categoryName model)
            , a [ class "icon", href <| "/categories/" ++ (categorySlug model) ] []
            ]
        , div [ class "rep" ] [ text "Tier" ]
        , div [ class "hold" ] [ text "Hold" ]
        , div [ class "status" ] [ text "Status" ]
        ]


viewDescription : Faction -> Bool -> Bool -> Html Msg
viewDescription faction expanded editMode =
    let
        description =
            case faction.description of
                Just desc ->
                    Markdown.toHtml [] desc

                Nothing ->
                    text "Unknown"
    in
        case expanded of
            True ->
                case editMode of
                    True ->
                        div [ class "description" ]
                            [ text "Description (markdown)"
                            , br [] []
                            , textarea [ onInput DescriptionChanged ] [ text <| Maybe.withDefault "Unknown" faction.description ]
                            ]

                    False ->
                        div [ class "faction description" ]
                            [ description
                            ]

            False ->
                span [] []


view : Model -> Html Msg
view model =
    let
        faction =
            model.faction
    in
        case model.editMode of
            True ->
                viewWrapper model
                    [ div [ class "name" ]
                        [ a [ href <| "/factions/" ++ faction.slug ] [ text faction.name ]
                        ]
                    , div [ class "rep" ]
                        [ input
                            [ type_ "number"
                            , value <| toString faction.reputation
                            , onInput RepChanged
                            ]
                            []
                        ]
                    , div [ class "hold" ]
                        [ input
                            [ type_ "checkbox"
                            , id "hold"
                            , class "tgl tgl-skewed"
                            , checked (faction.hold == 1)
                            , onCheck HoldChanged
                            ]
                            []
                        , label
                            [ class "tgl-btn"
                            , (attribute "data-tg-off" "W")
                            , (attribute "data-tg-on" "S")
                            , for "hold"
                            ]
                            []
                        ]
                    , div [ class "status" ]
                        [ input
                            [ type_ "number"
                            , Html.Attributes.min "-3"
                            , Html.Attributes.max "3"
                            , value <| toString faction.faction_status
                            , onInput StatusChanged
                            ]
                            []
                        ]
                    ]

            False ->
                viewWrapper model
                    [ div [ class "name" ] [ a [ href <| "/factions/" ++ faction.slug ] [ text faction.name ] ]
                    , viewAttr model.editable "rep" (text <| tier faction.reputation)
                    , viewAttr model.editable "hold" (text <| hold faction.hold)
                    , viewAttr model.editable "status" <| status faction.faction_status
                    ]


viewAttr : Bool -> String -> Html Msg -> Html Msg
viewAttr editable name content =
    if editable == True then
        div [ class name, onDoubleClick EnterEdit ] [ content ]
    else
        div [ class name ] [ content ]


viewEdit : Bool -> Bool -> Html Msg
viewEdit editable editMode =
    if editable == True then
        if editMode == True then
            a [ class "btn-primary", onClick ExitEdit ] [ text "Save Changes" ]
        else
            a [ class "btn-primary", onClick EnterEdit ] [ text "Edit" ]
    else
        span [] []


status : Int -> Html Msg
status n =
    if n == (-3) then
        span [ class "war" ] [ text "war" ]
    else
        text <| toString n


hold : Int -> String
hold n =
    if n == 0 then
        "W"
    else
        "S"


between : Int -> Int -> Int -> Bool
between a b n =
    n > a && n < b


tier : Int -> String
tier rep =
    if rep < 12 then
        "-"
    else if between 12 24 rep then
        "I"
    else if between 23 36 rep then
        "II"
    else if between 36 48 rep then
        "III"
    else if between 48 60 rep then
        "IV"
    else if between 60 84 rep then
        "V"
    else
        "X"
