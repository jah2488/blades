module Counter exposing (..)

import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)


type alias Model =
    { counter : Int
    }


type alias Flags =
    { counter : Int
    }


model : Model
model =
    { counter = 1
    }


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | counter = model.counter + 1 }
            , Cmd.none
            )

        Decrement ->
            ( { model | counter = model.counter - 1 }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    div []
        [ div [] [ button [ onClick Increment ] [ text "+" ] ]
        , div [] [ text <| toString model.counter ]
        , div [] [ button [ onClick Decrement ] [ text "-" ] ]
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
