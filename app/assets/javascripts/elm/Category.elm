module Category exposing (..)

import Models exposing (..)
import Html exposing (Html, a, button, div, header, td, text, tr)
import Html.Attributes exposing (class, href)
import Faction.Utils exposing (tier, hold, status)


type alias Flags =
    { category : Category
    , factions : List Faction
    }


type alias Model =
    { category : Category
    , factions : List Faction
    }


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


viewFaction : Faction -> Html Msg
viewFaction faction =
    div [ class "information" ]
        [ div [ class "name" ]
            [ a [ href <| "/factions/" ++ faction.slug ] [ text faction.name ]
            ]
        , div [ class "rep" ] [ text <| tier faction.reputation ]
        , div [ class "hold" ] [ text <| hold faction.hold ]
        , div [ class "status" ] [ status faction.faction_status ]
        ]


view : Model -> Html Msg
view model =
    div [ class "faction" ]
        [ header [ class "category" ]
            [ div [ class "name" ]
                [ text model.category.name
                , a [ class "icon", href <| "/categories/" ++ model.category.slug ] []
                ]
            , div [ class "rep" ] [ text "Tier" ]
            , div [ class "hold" ] [ text "Hold" ]
            , div [ class "status" ] [ text "Status" ]
            ]
        , div [ class "factions" ] (List.map viewFaction model.factions)
        , div [ class "actions" ] []
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
