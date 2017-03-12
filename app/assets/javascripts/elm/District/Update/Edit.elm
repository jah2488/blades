module District.Update.Edit exposing (update)

import Array exposing (Array)
import Http
import Json.Decode.Extra exposing ((|:))
import Json.Decode as Decode
import Json.Encode as Json
import Maybe
import Models exposing (..)
import District.Types exposing (..)
import Utils exposing (patch)


--
-- { id : Int
-- , game_id : Int
-- , category_id : Maybe Int
-- , name : String
-- , description : Maybe String
-- , reputation : Int
-- , hold : Int
-- , turf : Int
-- , faction_status : Int
-- , slug : String
-- , game : Game
-- , category : Maybe Category
-- }
--


gameDecoder : Decode.Decoder Game
gameDecoder =
    Decode.succeed Game
        |: (Decode.field "id" Decode.int)
        |: (Decode.field "user_id" Decode.int)
        |: (Decode.field "name" Decode.string)
        |: (Decode.field "slug" Decode.string)
        |: (Decode.field "description" (Decode.maybe Decode.string))


categoryDecoder : Decode.Decoder Category
categoryDecoder =
    Decode.succeed Category
        |: (Decode.field "id" Decode.int)
        |: (Decode.field "name" Decode.string)
        |: (Decode.field "description" (Decode.maybe Decode.string))
        |: (Decode.field "slug" Decode.string)


factionDecoder : Decode.Decoder Faction
factionDecoder =
    Decode.succeed Faction
        |: (Decode.field "id" Decode.int)
        |: (Decode.field "game_id" Decode.int)
        |: (Decode.field "category_id" (Decode.maybe Decode.int))
        |: (Decode.field "name" Decode.string)
        |: (Decode.field "description" (Decode.maybe Decode.string))
        |: (Decode.field "reputation" Decode.int)
        |: (Decode.field "hold" Decode.int)
        |: (Decode.field "turf" Decode.int)
        |: (Decode.field "faction_status" Decode.int)
        |: (Decode.field "slug" Decode.string)
        |: (Decode.field "game" gameDecoder)
        |: (Decode.field "category" (Decode.maybe categoryDecoder))


loadFactions : Model -> Cmd Msg
loadFactions model =
    if model.allFactions == [] then
        let
            url =
                "/factions.json"

            decoder =
                Decode.array factionDecoder

            request =
                Http.get url decoder
        in
            Http.send GetFactions request
    else
        Cmd.none


saveChanges : Model -> Cmd Msg
saveChanges ({ district, csrfToken } as model) =
    let
        url =
            "/districts/" ++ (toString district.id)

        data =
            Json.object
                [ ( "district"
                  , Json.object
                        [ ( "wealth", Json.int district.wealth )
                        , ( "security_and_safety", Json.int district.security_and_safety )
                        , ( "occult_influence", Json.int district.occult_influence )
                        , ( "criminal_influence", Json.int district.criminal_influence )
                        , ( "faction_ids", Json.array (factionIDs model) )
                        , ( "description", Json.string <| Maybe.withDefault "" district.description )
                        ]
                  )
                ]

        decode =
            Decode.string

        request =
            patch csrfToken url (Http.jsonBody data) decode
    in
        Http.send SavedForm request


factionIDs : Model -> Array Json.Value
factionIDs model =
    model.district.factions
        |> List.map (.id)
        |> List.map Json.int
        |> Array.fromList


update : EditState -> Model -> ( Model, Cmd Msg )
update state model =
    case state of
        Enter ->
            ( { model | editing = True }, loadFactions model )

        Exit ->
            ( { model | editing = False }, saveChanges model )

        Reset ->
            ( { model | district = model.originalDistrict }, Cmd.none )

        Cancel ->
            ( { model | editing = False, district = model.originalDistrict }, Cmd.none )
