module District.View.Utils exposing (..)


stateClass : Bool -> String
stateClass state =
    case state of
        True ->
            "ic expanded"

        False ->
            "ic closed"
