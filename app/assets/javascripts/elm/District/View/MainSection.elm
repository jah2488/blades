module District.View.MainSection exposing (view)

import Html exposing (Html, a, button, div, header, section, td, text, tr, br, textarea, input, span, em)
import Html.Attributes exposing (class, classList, href, type_)
import Html.Events exposing (onClick, onInput)
import Models exposing (..)
import Faction.Utils exposing (tier)
import District.Types exposing (..)
import Utils exposing (..)
import District.View.Utils exposing (stateClass)


view : Model -> Html Msg
view model =
    div [ class "six columns" ]
        [ div [ classList [ ( "description", True ), ( "opened", model.descriptionOpen ) ] ]
            [ viewDescription model
              -- , div [ class <| "fixed-footer " ++ (stateClass model.descriptionOpen), onClick <| Toggle Descriptions ] []
            ]
        ]


viewDescription : Model -> Html Msg
viewDescription model =
    case model.editing of
        True ->
            div [ class "edit" ]
                [ text "Description (markdown)"
                , br [] []
                , textarea [ onInput <| (Changed << Description) ]
                    [ text <| Maybe.withDefault "Unknown" model.district.description ]
                ]

        False ->
            (renderMarkdown model.district.description NoOp)
