module Utils exposing (..)

import Html exposing (Html, text)
import Http
import Json.Decode as Decode
import Regex exposing (regex)
import Markdown


patch : String -> String -> Http.Body -> Decode.Decoder a -> Http.Request a
patch csrfToken url body decoder =
    Http.request
        { method = "PATCH"
        , headers = [ Http.header "X-CSRF-Token" csrfToken ]
        , url = url
        , body = body
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = False
        }


renderMarkdown : Maybe String -> a -> Html a
renderMarkdown string a =
    case string of
        Just desc ->
            Markdown.toHtml [] desc

        Nothing ->
            text "Unknown"


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


isChecked : Int -> Int -> String
isChecked idx n =
    if idx <= n then
        "unchecked"
    else
        "checked"
