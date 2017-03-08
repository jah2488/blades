module District.View.SideBar exposing (view)

import Html exposing (Html, a, button, div, text, header)
import Html.Attributes exposing (class, classList, href, type_)
import Html.Events exposing (onClick, onInput)
import Models exposing (..)
import District.Types exposing (..)
import District.View.Utils exposing (stateClass)
import Faction.Utils exposing (tier)
import Utils exposing (isChecked, toSlug)


view : Model -> Html Msg
view model =
    div [ class "six columns" ]
        [ statsSection model
        , factionSection model
        , viewEdit model.editable model.editing
        ]


viewEdit : Bool -> Bool -> Html Msg
viewEdit editable editMode =
    if editable == True then
        if editMode == True then
            div []
                [ a [ class "btn-primary", onClick <| Edit Cancel ] [ text "Cancel" ]
                , a [ class "btn-primary", onClick <| Edit Reset ] [ text "Reset" ]
                , a [ class "btn-primary", onClick <| Edit Exit ] [ text "Save Changes" ]
                ]
        else
            a [ class "btn-primary", onClick <| Edit Enter ] [ text "Edit" ]
    else
        div [] []


factionSection : Model -> Html Msg
factionSection model =
    let
        factions =
            model.district.factions

        factionsOpen =
            model.factionsOpen

        sectionInfo =
            if model.editing then
                [ div [ class "status" ] [ text "Action" ] ]
            else
                [ div [ class "rep" ] [ text "Tier" ]
                  -- , div [ class "hold" ] [ text "Hold" ]
                , div [ class "status" ] [ text "Status" ]
                ]
    in
        div [ class "row" ]
            [ div [ class "faction" ]
                [ header [ class "category" ] <|
                    [ div [ class (stateClass factionsOpen), onClick <| Toggle Factions ] []
                    , div [ class "name" ] [ text "Factions" ]
                    ]
                        ++ sectionInfo
                , div []
                    [ if factionsOpen then
                        if model.editing then
                            editFactions model
                        else
                            div [] (List.map viewFaction factions)
                      else
                        div [] []
                    ]
                ]
            ]


statsSection : Model -> Html Msg
statsSection model =
    div [ class "row" ] [ viewDistrict model ]


viewDistrict : Model -> Html Msg
viewDistrict model =
    let
        opened =
            model.statsOpen

        district =
            model.district

        heading =
            header [ class "category" ]
                [ div [ class (stateClass opened), onClick <| Toggle Stats ] []
                , div [ class "name" ] [ text "Info" ]
                ]

        body =
            if opened == True then
                [ viewStat "Wealth" district.wealth model.editing (Changed << Wealth)
                , viewStat "Security & Safety" district.security_and_safety model.editing (Changed << SecurityAndSafety)
                , viewStat "Criminal Influence" district.criminal_influence model.editing (Changed << CriminalInfluence)
                , viewStat "Occult Influence" district.occult_influence model.editing (Changed << OccultInfluence)
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


editFaction : Model -> Faction -> Html Msg
editFaction model faction =
    let
        isSame =
            (\fa fb -> fa == fb)

        filtered =
            List.filter (isSame faction) model.district.factions

        action =
            if (filtered == []) then
                div [ class "add-faction btn-primary", onClick (FactionList (Add faction.id)) ] [ text "ADD" ]
            else
                div [ class "remove-faction btn-primary", onClick (FactionList (Remove faction.id)) ] [ text "DEL" ]
    in
        div [ class "information" ]
            [ div [ classList [ ( "name", True ), ( "current", filtered == [] ) ] ]
                [ a [ href <| "/factions/" ++ faction.slug ] [ text faction.name ] ]
            , action
            ]


editFactions : Model -> Html Msg
editFactions model =
    div [] (List.map (editFaction model) model.allFactions)


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
