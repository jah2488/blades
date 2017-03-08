module District.Update.Factions exposing (update)

import District.Types exposing (..)


update : FactionAction -> Model -> ( Model, Cmd Msg )
update action ({ district } as model) =
    case action of
        Add id ->
            let
                newFaction =
                    List.filter (\f -> f.id == id) model.allFactions

                newDistrict =
                    { district | factions = (district.factions ++ newFaction) }
            in
                ( { model | district = newDistrict }, Cmd.none )

        Remove id ->
            let
                newFactions =
                    List.filter (\f -> f.id /= id) model.district.factions

                newDistrict =
                    { district | factions = newFactions }
            in
                ( { model | district = newDistrict }, Cmd.none )
