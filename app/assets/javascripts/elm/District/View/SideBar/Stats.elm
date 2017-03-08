module District.View.SideBar.Stats exposing (view)

import District.Types exposing (..)
import District.View.Utils exposing (stateClass)
import Html exposing (Html, div, header, text)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (onClick)
import Utils exposing (isChecked, toSlug)


view : Model -> Html Msg
view model =
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
