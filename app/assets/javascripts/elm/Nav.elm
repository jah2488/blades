module Nav exposing (..)

import Models exposing (..)
import Html exposing (Html, a, input, div, text, nav, p, form)
import Html.Attributes exposing (class, href, type_, value)


type alias Flags =
    { game : String
    }


type alias Model =
    { game : String
    }


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    nav []
        [ div [ class "list" ]
            [ div [ class "list-item" ] [ p [] [ text model.game ] ]
            , a [ class "list-item action", href "/factions" ] [ p [] [ text "Factions" ] ]
            , a [ class "list-item action", href "/districts" ] [ p [] [ text "Districts" ] ]
            , div [ class "list-item" ]
                [ form []
                    [ input [ type_ "button", class "btn-primary", value "Sign Out" ] []
                    ]
                ]
            ]
        ]


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( flags, Cmd.none )


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , init = init
        }
