module District.View.Header exposing (view)

import Html exposing (Html, header, div, span, em, text, a)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import District.Types exposing (..)
import District.View.Utils exposing (stateClass)


view : Model -> Html Msg
view { editing, district, descriptionOpen } =
    header [ class "category" ]
        [ div [ class "name" ]
            [ div [ class (stateClass descriptionOpen), onClick <| Toggle Descriptions ] []
            , editTag editing
            , text district.name
            , iconLink ("/districts/" ++ district.slug) "icon"
            ]
        ]


editTag : Bool -> Html Msg
editTag editing =
    if editing then
        em [ class "edit" ] [ text "Editing" ]
    else
        span [] []


iconLink : String -> String -> Html Msg
iconLink url className =
    a [ class className, href url ] []
