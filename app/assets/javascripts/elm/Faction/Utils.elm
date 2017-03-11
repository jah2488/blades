module Faction.Utils exposing (..)

import Html exposing (Html, span, text)
import Html.Attributes exposing (class)
import Faction.Types exposing (Msg)


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
between n min max =
    n > min && n < max


tier : Int -> String
tier rep =
    let
        within =
            between rep
    in
        if rep <= 12 then
            "-"
        else if within 12 24 then
            "I"
        else if within 23 36 then
            "II"
        else if within 36 48 then
            "III"
        else if within 48 60 then
            "IV"
        else if within 60 84 then
            "V"
        else
            "X"
