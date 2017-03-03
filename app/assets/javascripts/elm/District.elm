module District exposing (..)

import Html exposing (Html, a, button, div, header, section, td, text, tr)
import Html.Attributes exposing (class, href)
import Regex exposing (regex)
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


toSlug : String -> String
toSlug name =
    String.toLower name
        |> Regex.replace Regex.All
            (regex "[ _&.']")
            (\{ match } ->
                case match of
                    " " ->
                        "-"

                    "_" ->
                        "-"

                    "&" ->
                        ""

                    "." ->
                        ""

                    "'" ->
                        ""

                    _ ->
                        ""
            )
        |> Regex.replace Regex.All
            (regex "--")
            (\_ -> "-")


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


isChecked : Int -> Int -> String
isChecked idx n =
    if idx <= n then
        "unchecked"
    else
        "checked"


toCheckbox : String -> Html Msg
toCheckbox className =
    div [ class className ] []


toRating : Int -> List (Html Msg)
toRating n =
    let
        amount =
            div [ class "amount" ] [ text <| toString n ]

        checkboxes =
            List.range 0 3
                |> List.map (isChecked n)
                |> List.map toCheckbox
    in
        checkboxes ++ [ amount ]


viewStat : String -> Int -> Html Msg
viewStat name value =
    div [ class <| "attr " ++ toSlug name ]
        [ div [ class "name" ] [ text name ]
        , div [ class "value" ] <| toRating value
        ]


viewDistrict : District -> Html Msg
viewDistrict district =
    div [ class "stats" ]
        [ header [ class "category" ]
            [ div [ class "name" ] [ text "Info" ]
            ]
        , viewStat "Wealth" district.wealth
        , viewStat "Security & Safety" district.security_and_safety
        , viewStat "Criminal Influence" district.criminal_influence
        , viewStat "Occult Influence" district.occult_influence
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
