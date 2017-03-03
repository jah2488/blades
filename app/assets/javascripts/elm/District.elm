module District exposing (..)

import Html exposing (Html, a, button, div, header, section, td, text, tr)
import Html.Attributes exposing (class, href)
import Markdown
import Models exposing (..)
import Faction.View exposing (tier)


type alias Flags =
    { district : District
    }


type alias Model =
    { district : District
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
        , div [ class "hold" ] [ text <| toString faction.hold ]
        , div [ class "status" ] [ text <| toString faction.faction_status ]
        ]


toRating : Int -> List (Html Msg)
toRating n =
    case n of
        0 ->
            [ div [ class "unchecked" ] []
            , div [ class "unchecked" ] []
            , div [ class "unchecked" ] []
            , div [ class "unchecked" ] []
            , div [ class "amount" ] [ text <| toString n ]
            ]

        1 ->
            [ div [ class "checked" ] []
            , div [ class "unchecked" ] []
            , div [ class "unchecked" ] []
            , div [ class "unchecked" ] []
            , div [ class "amount" ] [ text <| toString n ]
            ]

        2 ->
            [ div [ class "checked" ] []
            , div [ class "checked" ] []
            , div [ class "unchecked" ] []
            , div [ class "unchecked" ] []
            , div [ class "amount" ] [ text <| toString n ]
            ]

        3 ->
            [ div [ class "checked" ] []
            , div [ class "checked" ] []
            , div [ class "checked" ] []
            , div [ class "unchecked" ] []
            , div [ class "amount" ] [ text <| toString n ]
            ]

        _ ->
            [ div [ class "checked" ] []
            , div [ class "checked" ] []
            , div [ class "checked" ] []
            , div [ class "checked" ] []
            , div [ class "amount" ] [ text <| toString n ]
            ]


viewDistrict : District -> Html Msg
viewDistrict district =
    div [ class "stats" ]
        [ header [ class "category" ]
            [ div [ class "name" ] [ text "Info" ]
            ]
        , div [ class "attr wealth" ]
            [ div [ class "name" ] [ text "Wealth" ]
            , div [ class "value" ] <| toRating district.wealth
            ]
        , div [ class "attr security-safety" ]
            [ div [ class "name" ] [ text "Security and Safety" ]
            , div [ class "value" ] <| toRating district.security_and_safety
            ]
        , div [ class "attr criminal-influence" ]
            [ div [ class "name" ] [ text "Criminal Influence" ]
            , div [ class "value" ] <| toRating district.criminal_influence
            ]
        , div [ class "attr occult-influence" ]
            [ div [ class "name" ] [ text "Occult Influence" ]
            , div [ class "value" ] <| toRating district.occult_influence
            ]
        ]


view : Model -> Html Msg
view model =
    let
        description =
            case model.district.description of
                Just desc ->
                    Markdown.toHtml [] desc

                Nothing ->
                    text "Unknown"
    in
        section [ class "district" ]
            [ div []
                [ header [ class "category" ]
                    [ div [ class "name" ] [ text model.district.name ]
                    ]
                , div [ class "row" ]
                    [ div [ class "six columns" ]
                        [ div [ class "description" ] [ description ] ]
                    , div [ class "six columns" ]
                        [ div [ class "row" ] [ viewDistrict model.district ]
                        , div [ class "row" ]
                            [ div [ class "faction" ]
                                [ header [ class "category" ]
                                    [ div [ class "name" ]
                                        [ text "Factions"
                                        ]
                                    , div [ class "rep" ] [ text "Tier" ]
                                    , div [ class "hold" ] [ text "Hold" ]
                                    , div [ class "status" ] [ text "Status" ]
                                    ]
                                , div [] (List.map viewFaction model.district.factions)
                                ]
                            ]
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
