module Faction exposing (..)

import Html exposing (Html, a, br, button, div, form, header, input, label, p, section, span, td, text, textarea, tr)
import Html.Attributes exposing (attribute, checked, class, for, href, id, max, min, type_, value)
import Html.Events exposing (onClick, onDoubleClick, onCheck, onInput)
import Http
import Json.Encode as Json
import Json.Decode as Decode
import Markdown
import Maybe
import Models exposing (..)


type alias Flags =
    { faction : Faction
    , expanded : Bool
    , csrfToken : String
    }


type alias Model =
    { faction : Faction
    , expanded : Bool
    , editMode : Bool
    , csrfToken : String
    }


model : Model
model =
    { faction = nullFaction
    , expanded = False
    , editMode = False
    , csrfToken = ""
    }


type Msg
    = ShowTools
    | EnterEdit
    | ExitEdit
    | HoldChanged Bool
    | RepChanged String
    | StatusChanged String
    | DescriptionChanged String
    | SavedForm (Result Http.Error String)


saveChanges : Model -> Cmd Msg
saveChanges model =
    let
        url =
            "/factions/" ++ (toString model.faction.id)

        data =
            Json.object
                [ ( "faction"
                  , Json.object
                        [ ( "hold", Json.int model.faction.hold )
                        , ( "reputation", Json.int model.faction.reputation )
                        , ( "faction_status", Json.int model.faction.faction_status )
                        , ( "description", Json.string <| Maybe.withDefault "" model.faction.description )
                        ]
                  )
                ]

        decode =
            Decode.string

        request =
            patch model url (Http.jsonBody data) decode
    in
        Http.send SavedForm request


patch : Model -> String -> Http.Body -> Decode.Decoder a -> Http.Request a
patch model url body decoder =
    Http.request
        { method = "PATCH"
        , headers = [ Http.header "X-CSRF-Token" model.csrfToken ]
        , url = url
        , body = body
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = False
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowTools ->
            ( model, Cmd.none )

        EnterEdit ->
            ( { model | editMode = True }, Cmd.none )

        ExitEdit ->
            ( { model | editMode = False }, saveChanges model )

        SavedForm (Ok status) ->
            ( model, Cmd.none )

        SavedForm (Err status) ->
            ( model, Cmd.none )

        HoldChanged hold ->
            let
                faction =
                    model.faction

                newFaction =
                    if hold == True then
                        { faction | hold = 1 }
                    else
                        { faction | hold = 0 }
            in
                ( { model | faction = newFaction }, Cmd.none )

        RepChanged rep ->
            let
                faction =
                    model.faction

                newFaction =
                    { faction | reputation = (Result.withDefault 0 (String.toInt rep)) }
            in
                ( { model | faction = newFaction }, Cmd.none )

        StatusChanged status ->
            let
                faction =
                    model.faction

                newStatus =
                    (Result.withDefault 0 (String.toInt status))

                boundStatus =
                    if newStatus >= 3 then
                        3
                    else if newStatus <= -3 then
                        -3
                    else
                        newStatus

                newFaction =
                    { faction | faction_status = boundStatus }
            in
                ( { model | faction = newFaction }, Cmd.none )

        DescriptionChanged desc ->
            let
                faction =
                    model.faction

                newFaction =
                    { faction | description = Just desc }
            in
                ( { model | faction = newFaction }, Cmd.none )


viewDescription : Faction -> Bool -> Bool -> Html Msg
viewDescription faction expanded editMode =
    let
        description =
            case faction.description of
                Just desc ->
                    Markdown.toHtml [] desc

                Nothing ->
                    text "Unknown"
    in
        case expanded of
            True ->
                case editMode of
                    True ->
                        div [ class "faction description" ]
                            [ text "Description (markdown)"
                            , br [] []
                            , textarea [ onInput DescriptionChanged ] [ text <| Maybe.withDefault "Unknown" faction.description ]
                            ]

                    False ->
                        div [ class "faction description" ]
                            [ description
                            ]

            False ->
                span [] []


view : Model -> Html Msg
view { faction, expanded, editMode } =
    let
        categoryName =
            case faction.category of
                Just category ->
                    category.name

                Nothing ->
                    "Not In a Category"
    in
        case editMode of
            True ->
                section [ class "editing" ]
                    [ div [ class "faction" ]
                        [ header [ class "category" ]
                            [ div [ class "name" ] [ text categoryName ]
                            , div [ class "rep" ] [ text "Tier" ]
                            , div [ class "hold" ] [ text "Hold" ]
                            , div [ class "status" ] [ text "Status" ]
                            ]
                        , div [ class "information" ]
                            [ div [ class "name" ]
                                [ a [ href <| "/factions/" ++ faction.slug ] [ text faction.name ]
                                ]
                            , div [ class "rep" ]
                                [ input
                                    [ type_ "number"
                                    , value <| toString faction.reputation
                                    , onInput RepChanged
                                    ]
                                    []
                                ]
                            , div [ class "hold" ]
                                [ input
                                    [ type_ "checkbox"
                                    , id "hold"
                                    , class "tgl tgl-skewed"
                                    , checked (faction.hold == 1)
                                    , onCheck HoldChanged
                                    ]
                                    []
                                , label
                                    [ class "tgl-btn"
                                    , (attribute "data-tg-off" "W")
                                    , (attribute "data-tg-on" "S")
                                    , for "hold"
                                    ]
                                    []
                                ]
                            , div [ class "status" ]
                                [ input
                                    [ type_ "number"
                                    , Html.Attributes.min "-3"
                                    , Html.Attributes.max "3"
                                    , value <| toString faction.faction_status
                                    , onInput StatusChanged
                                    ]
                                    []
                                ]
                            ]
                        , div [ class "actions" ] []
                        ]
                    , viewDescription faction expanded True
                    , a [ class "btn-primary", onClick ExitEdit ] [ text "Save Changes" ]
                    ]

            False ->
                section []
                    [ div [ class "faction" ]
                        [ header [ class "category" ]
                            [ div [ class "name" ] [ text categoryName ]
                            , div [ class "rep" ] [ text "Tier" ]
                            , div [ class "hold" ] [ text "Hold" ]
                            , div [ class "status" ] [ text "Status" ]
                            ]
                        , div [ class "information" ]
                            [ div [ class "name" ]
                                [ a [ href <| "/factions/" ++ faction.slug ] [ text faction.name ]
                                ]
                            , div [ class "rep", onDoubleClick EnterEdit ] [ text <| tier faction.reputation ]
                            , div [ class "hold", onDoubleClick EnterEdit ] [ text <| hold faction.hold ]
                            , div [ class "status", onDoubleClick EnterEdit ] [ status faction.faction_status ]
                            ]
                        , div [ class "actions" ] []
                        ]
                    , viewDescription faction expanded False
                    , a [ class "btn-primary", onClick EnterEdit ] [ text "Edit" ]
                    ]


status : Int -> Html Msg
status n =
    if n == (-3) then
        span [ class "war" ] [ text "war" ]
    else
        text <| toString n


hold : Int -> String
hold n =
    if n == 0 then
        "W"
    else
        "S"


between : Int -> Int -> Int -> Bool
between a b n =
    n > a && n < b


tier : Int -> String
tier rep =
    if rep < 12 then
        "-"
    else if between 12 24 rep then
        "I"
    else if between 23 36 rep then
        "II"
    else if between 36 48 rep then
        "III"
    else if between 48 60 rep then
        "IV"
    else if between 60 84 rep then
        "V"
    else
        "X"


init : Flags -> ( Model, Cmd Msg )
init { faction, expanded, csrfToken } =
    ( { faction = faction, expanded = expanded, editMode = False, csrfToken = csrfToken }, Cmd.none )


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , init = init
        }
