module TestStopwatch exposing (all)

import ElmTest exposing (Test, assertEqual, suite, test)
import Stopwatch exposing (Model, Msg, toSeconds, toStopwatch)


all : Test
all =
    suite "Test Stopwatch module"
        [ test
            "toSeconds with 1 1 1 1 should return 90061"
            (assertEqual (Model 1 1 1 1 |> toSeconds) 90061)
        , test
            "toStopwatch with 90061 should return Model 1 1 1 1"
            (assertEqual (toStopwatch 90061) (Model 1 1 1 1))
        ]
