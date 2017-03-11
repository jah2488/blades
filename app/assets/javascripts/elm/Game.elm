module Game exposing (..)

import Models exposing (..)
import Html exposing (Html, a, button, div, header, h4, text, p)
import Html.Attributes exposing (class, href)
import Utils exposing (renderMarkdown)


type alias Flags =
    { game : Game
    }


type alias Model =
    { game : Game
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
    div []
        [ h4 [] [ text model.game.name ]
        , renderMarkdown model.game.description NoOp
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
