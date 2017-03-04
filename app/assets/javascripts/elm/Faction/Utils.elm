module Faction.Utils exposing (..)

import Html exposing (Html, span, text)
import Html.Attributes exposing (class)
import Faction.Common exposing (Msg)


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
