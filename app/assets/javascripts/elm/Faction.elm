module Faction exposing (..)

import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Date exposing (Date)


type alias Flags =
    { id : Int
    , game_id : Int
    , category_id : Maybe Int
    , name : String
    , description : Maybe String
    , reputation : Int
    , hold : Int
    , turf : Int
    , faction_status : Int
    , slug : String
    }


type alias Model =
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
            ( { model | counter = model.counter + 0 }
            , Cmd.none
            )

        Decrement ->
            ( { model | counter = model.counter - 0 }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    div []
        [ div [] [ button [ onClick Increment ] [ text "+Rep" ] ]
        , div [] [ text <| toString model.counter ]
        , div [] [ button [ onClick Decrement ] [ text "-Rep" ] ]
        ]


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { counter = flags.id }, Cmd.none )


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , init = init
        }
