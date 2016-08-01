module TestStopwatch exposing (all)

import ElmTest exposing (Test, assertEqual, suite, test)
import Stopwatch exposing (Model, fromTime, toSeconds)


all : Test
all =
    suite "Test Stopwatch module"
        [ test
            "toSeconds with 1 1 1 1 should return 90061"
            (assertEqual (Model 1 1 1 1 |> toSeconds) 90061)
        , test
            "fromTime with 10s and 3s should return Model 0 0 0 7"
            (assertEqual (fromTime 10000.0 3000.0) (Model 0 0 0 7))
        ]
