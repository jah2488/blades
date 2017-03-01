module Faction exposing (..)

import Html exposing (Html, a, button, div, header, td, text, tr)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Models exposing (..)


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
    , game : Game
    , category : Maybe Category
    }


type alias Model =
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
    , game : Game
    , category : Maybe Category
    }


model : Model
model =
    { id = 0
    , game_id = 0
    , category_id = Nothing
    , name = "No Faction Given"
    , description = Nothing
    , reputation = 0
    , hold = 0
    , turf = 0
    , faction_status = 0
    , slug = "no-faction-given"
    , game = nullGame
    , category = Just nullCategory
    }


type Msg
    = ShowTools


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowTools ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    let
        categoryName =
            case model.category of
                Just category ->
                    category.name

                Nothing ->
                    "Not In a Category"
    in
        div [ class "faction" ]
            [ header [ class "category" ]
                [ div [ class "name" ] [ text categoryName ]
                , div [ class "rep" ] [ text "Tier" ]
                , div [ class "hold" ] [ text "Hold" ]
                , div [ class "status" ] [ text "Status" ]
                ]
            , div [ class "information" ]
                [ div [ class "name" ]
                    [ a [ href <| "/factions/" ++ model.slug ] [ text model.name ]
                    ]
                , div [ class "rep" ] [ text <| tier model.reputation ]
                , div [ class "hold" ] [ text <| toString model.hold ]
                , div [ class "status" ] [ text <| toString model.faction_status ]
                ]
            , div [ class "actions" ]
                [ button [ onClick ShowTools ] [ text "edit" ] ]
            ]


tier : Int -> String
tier rep =
    if rep < 12 then
        "-"
    else if rep > 12 && rep < 24 then
        "I"
    else if rep > 24 && rep < 36 then
        "II"
    else if rep > 36 && rep < 48 then
        "III"
    else if rep > 48 && rep < 60 then
        "IV"
    else if rep > 60 && rep < 82 then
        "V"
    else
        "X"


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
