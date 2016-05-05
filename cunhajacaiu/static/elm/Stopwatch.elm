module Stopwatch where

import Html exposing (..)
import Html.Events exposing (onClick)


--
-- Model
--

type alias Stopwatch =
    { days: Int
    , hours: Int
    , minutes: Int
    , seconds: Int
    , labels: List String
    }

zeroedStopwacth : Stopwatch
zeroedStopwacth =
    { days = 0
    , hours = 0
    , minutes = 0
    , seconds = 0
    , labels = ["Dias", "Horas", "Minutos", "Segundos"]
    }


--
-- Update
--

toSeconds : Stopwatch -> Int
toSeconds stopwwatch =
    stopwatch.seconds + stopwatch.minutes * 60 + stopwatch.hours * 3600 + stopwatch.days * 3600 * 24

toStopwatch : Int -> Stopwatch
toStopwatch seconds =
    { model
        | days = seconds // 3600 * 24
        , hours = (seconds % 3600 * 24) // 3600
        , minutes = (seconds % 3600) // 60
        , seconds = seconds % 60
    }

type Action = Increment | None

tic : Action -> Model -> Model
tic model action =
    case action of
        Increment ->
            toStopwatch <| toSeconds(model) + 1
        None ->
            model


--
-- View
--

view : Signal.Address Action -> Model -> Html
view address model =
  div [onClick address Increment]
    [ div [] [
        toString model.days, div [] [ stopwatch.labels[0] ]
        ]
        , div [] [
            toString model.hours, div [] [ stopwatch.labels[1] ]
        }
        , div [] [
            toString model.minutes, div [] [ stopwatch.labels[2] ]
        ]
        , div [] [
            toString model.seconds, div [] [ stopwatch.labels[3] ]
        ]
    ]


--
-- TODO:
--
-- 1. Pluralize labels when needed
-- 2. Avoid using indexes for labels (linas 65-74)
-- 3. Implenet tic every second (not on click)
--
