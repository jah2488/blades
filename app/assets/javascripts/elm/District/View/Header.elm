module District.View.Header exposing (view)

import Html exposing (Html, header, div, span, em, text, a)
import Html.Attributes exposing (class, href)
import District.Types exposing (..)


view : Model -> Html Msg
view { editing, district } =
    header [ class "category" ]
        [ div [ class "name" ]
            [ editTag editing, text district.name, iconLink ("/districts/" ++ district.slug) "icon" ]
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
