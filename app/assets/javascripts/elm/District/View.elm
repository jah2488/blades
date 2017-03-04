module District.View exposing (..)

import Html exposing (Html, a, button, div, header, section, td, text, tr, br, textarea, input)
import Html.Attributes exposing (class, classList, href, type_)
import Html.Events exposing (onClick, onInput)
import Models exposing (..)
import Faction.Utils exposing (tier)
import District.Common exposing (..)
import Utils exposing (..)


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


inRating : Int -> Int -> String
inRating idx n =
    let
        modifier =
            if idx < n then
                ""
            else
                "current"

        statNum =
            case n of
                0 ->
                    "-zero"

                1 ->
                    "-one"

                2 ->
                    "-two"

                3 ->
                    "-three"

                _ ->
                    "-four"
    in
        "stat" ++ statNum ++ " " ++ modifier


toStatBox : (Int -> Msg) -> Int -> String -> Html Msg
toStatBox msg idx classNames =
    div [ class classNames, onClick (msg idx) ] []


ratingSelect : Int -> (Int -> Msg) -> List (Html Msg)
ratingSelect n msg =
    List.range 0 4
        |> List.map (inRating n)
        |> List.indexedMap (toStatBox msg)


viewStat : String -> Int -> Bool -> (Int -> Msg) -> Html Msg
viewStat name attrValue editing msg =
    let
        body =
            if editing == True then
                div [ class "value" ] <| ratingSelect attrValue msg
            else
                div [ class "value" ] <| toRating attrValue
    in
        div
            [ classList
                [ ( "attr", True )
                , ( toSlug name, True )
                , ( "editing", editing )
                ]
            ]
            [ div [ class "name" ] [ text name ]
            , body
            ]


stateClass : Bool -> String
stateClass state =
    case state of
        True ->
            "ic expanded"

        False ->
            "ic closed"


viewDistrict : Model -> Html Msg
viewDistrict model =
    let
        opened =
            model.statsOpen

        district =
            model.district

        heading =
            header [ class "category" ]
                [ div [ class (stateClass opened), onClick ToggleStats ] []
                , div [ class "name" ] [ text "Info" ]
                ]

        body =
            if opened == True then
                [ viewStat "Wealth" district.wealth model.editing WealthChanged
                , viewStat "Security & Safety" district.security_and_safety model.editing SecurityAndSafetyChanged
                , viewStat "Criminal Influence" district.criminal_influence model.editing CriminalInfluenceChanged
                , viewStat "Occult Influence" district.occult_influence model.editing OccultInfluenceChanged
                ]
            else
                []
    in
        div [ class "stats" ] (heading :: body)


viewFaction : Faction -> Html Msg
viewFaction faction =
    div [ class "information" ]
        [ div [ class "name" ]
            [ a [ href <| "/factions/" ++ faction.slug ] [ text faction.name ]
            ]
        , div [ class "rep" ] [ text <| tier faction.reputation ]
          -- , div [ class "hold" ] [ text <| toString faction.hold ]
        , div [ class "status" ] [ text <| toString faction.faction_status ]
        ]


factionSection : Model -> Html Msg
factionSection { district, factionsOpen } =
    div [ class "row" ]
        [ div [ class "faction" ]
            [ header [ class "category" ]
                [ div [ class (stateClass factionsOpen), onClick ToggleFactions ] []
                , div [ class "name" ]
                    [ text "Factions"
                    ]
                , div [ class "rep" ] [ text "Tier" ]
                  -- , div [ class "hold" ] [ text "Hold" ]
                , div [ class "status" ] [ text "Status" ]
                ]
            , div []
                [ if factionsOpen then
                    div [] (List.map viewFaction district.factions)
                  else
                    div [] []
                ]
            ]
        ]


statsSection : Model -> Html Msg
statsSection model =
    div [ class "row" ] [ viewDistrict model ]


sideBar : Model -> Html Msg
sideBar model =
    div [ class "six columns" ]
        [ statsSection model
        , factionSection model
        , viewEdit model.editable model.editing
        ]


mainSection : Model -> Html Msg
mainSection model =
    div [ class "six columns" ]
        [ div [ classList [ ( "description", True ), ( "opened", model.descriptionOpen ) ] ]
            [ viewDescription model
            , div [ class <| "fixed-footer " ++ (stateClass model.descriptionOpen), onClick ToggleDescription ] []
            ]
        ]


viewDescription : Model -> Html Msg
viewDescription model =
    case model.editing of
        True ->
            div [ class "edit" ]
                [ text "Description (markdown)"
                , br [] []
                , textarea [ onInput DescriptionChanged ]
                    [ text <| Maybe.withDefault "Unknown" model.district.description ]
                ]

        False ->
            (renderMarkdown model.district.description NoOp)


view : Model -> Html Msg
view model =
    section [ class "district" ]
        [ div []
            [ header [ class "category" ]
                [ div [ class "name" ]
                    [ text model.district.name
                    , a [ class "icon", href <| "/districts/" ++ model.district.slug ] []
                    ]
                ]
            , div [ class "row" ]
                [ mainSection model
                , sideBar model
                ]
            ]
        ]


viewEdit : Bool -> Bool -> Html Msg
viewEdit editable editMode =
    if editable == True then
        if editMode == True then
            a [ class "btn-primary", onClick ExitEdit ] [ text "Save Changes" ]
        else
            a [ class "btn-primary", onClick EnterEdit ] [ text "Edit" ]
    else
        div [] []
