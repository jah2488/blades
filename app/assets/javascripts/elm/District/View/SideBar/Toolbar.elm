module District.View.SideBar.Toolbar exposing (view)

import Html exposing (Html, a, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import District.Types exposing (..)


view : Model -> Html Msg
view { editable, editing } =
    if editable == True then
        if editing == True then
            div []
                [ a [ class "btn-primary", onClick <| Edit Cancel ] [ text "Cancel" ]
                , a [ class "btn-primary", onClick <| Edit Reset ] [ text "Reset" ]
                , a [ class "btn-primary", onClick <| Edit Exit ] [ text "Save Changes" ]
                ]
        else
            a [ class "btn-primary", onClick <| Edit Enter ] [ text "Edit" ]
    else
        div [] []
